#!/usr/bin/env bash
# Creates or updates labels from labels.tsv in the repositories you list.
# Existing labels with the same name get the color and description from the file;
# labels that are not in the file are never touched or deleted.
#
# Usage:
#   scripts/sync-labels.sh [--tier TIERS] [--label NAMES] [--dry-run] OWNER/REPO [OWNER/REPO ...]
#   scripts/sync-labels.sh --list
#
#   --tier TIERS   comma-separated tiers to apply, e.g. --tier base,area,hw
#   --label NAMES  comma-separated label names to apply, e.g. --label "on develop,do not close"
#                  (case-insensitive, can be repeated)
#                  --tier and --label can be combined: their union is applied.
#                  With neither, the "base" tier is applied.
#   --dry-run      print what would be done, change nothing
#   --list         print the tiers and their labels
#
# Output is colored by tier when printing to a terminal.
# NO_COLOR=1 disables colors, FORCE_COLOR=1 forces them (e.g. when piping to less -R).
#
# Requires the GitHub CLI (gh), logged in with access to the repositories.
set -euo pipefail

here="$(cd "$(dirname "$0")/.." && pwd)"
labels="${LABELS_FILE:-$here/labels.tsv}"
tiers=""
names=""   # ",name1,name2," lowercase
dry=0
repos=()

usage() {
  awk 'NR > 1 && /^#/ { sub(/^# ?/, ""); print; next } NR > 1 { exit }' "$0"
  exit "${1:-1}"
}

# ------------------------------------------------------------------ colors
# One color per tier, in the order tiers first appear in labels.tsv;
# if there are more tiers than colors, the palette wraps around.
palette=(36 33 35 32 34 31 96 93 95 92 94 91)   # cyan yellow magenta green blue red, then bright
use_color=0
if [[ -n "${FORCE_COLOR:-}" ]] || { [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; }; then
  use_color=1
fi

tier_list=()
while IFS= read -r t; do tier_list+=("$t"); done < <(
  awk -F'\t' '!/^#/ && NF && !seen[$1]++ { print $1 }' "$labels"
)

tier_color() {
  local i
  for i in "${!tier_list[@]}"; do
    if [[ "${tier_list[$i]}" == "$1" ]]; then
      echo "${palette[$((i % ${#palette[@]}))]}"
      return
    fi
  done
  echo 0
}

# paint CODE TEXT: prints TEXT in the given ANSI color (no newline)
paint() {
  if [[ $use_color -eq 1 ]]; then printf '\033[%sm%s\033[0m' "$1" "$2"; else printf '%s' "$2"; fi
}

# ------------------------------------------------------------------- options
while [[ $# -gt 0 ]]; do
  case "$1" in
    --tier) [[ $# -ge 2 ]] || usage; tiers="$2"; shift 2 ;;
    --tier=*) tiers="${1#*=}"; shift ;;
    --label) [[ $# -ge 2 ]] || usage; names="$names,$2"; shift 2 ;;
    --label=*) names="$names,${1#*=}"; shift ;;
    --dry-run) dry=1; shift ;;
    --list)
      while IFS=$'\t' read -r tier name _color description; do
        [[ -z "$tier" || "$tier" == \#* ]] && continue
        c="$(tier_color "$tier")"
        paint "$c" "$(printf '%-10s %-18s' "$tier" "$name")"
        printf ' %s\n' "$description"
      done < "$labels"
      exit 0 ;;
    -h|--help) usage 0 ;;
    -*) echo "unknown option: $1" >&2; usage ;;
    */*) repos+=("$1"); shift ;;
    *) echo "not OWNER/REPO: $1" >&2; usage ;;
  esac
done
[[ ${#repos[@]} -gt 0 ]] || usage
[[ -z "$tiers" && -z "$names" ]] && tiers="base"

IFS=',' read -ra wanted <<< "$tiers"
for t in "${wanted[@]}"; do
  [[ -z "$t" ]] && continue
  [[ " ${tier_list[*]} " == *" $t "* ]] || { echo "unknown tier: $t (available: ${tier_list[*]})" >&2; exit 1; }
done

# normalize label names: trim spaces, lowercase, check they exist in labels.tsv
lc() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]'; }
known_names=",$(awk -F'\t' '!/^#/ && NF { printf "%s,", tolower($2) }' "$labels")"
wanted_names=","
IFS=',' read -ra raw <<< "$names"
for n in "${raw[@]}"; do
  n="$(lc "$(echo "$n" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')")"
  [[ -z "$n" ]] && continue
  if [[ "$known_names" != *",$n,"* ]]; then
    echo "unknown label: $n (see --list)" >&2; exit 1
  fi
  wanted_names="$wanted_names$n,"
done

# ---------------------------------------------------------------------- sync
for repo in "${repos[@]}"; do
  paint 1 "== $repo"; echo
  while IFS=$'\t' read -r tier name color description; do
    [[ -z "$tier" || "$tier" == \#* ]] && continue
    if [[ ",$tiers," != *",$tier,"* && "$wanted_names" != *",$(lc "$name"),"* ]]; then continue; fi
    c="$(tier_color "$tier")"
    if [[ $dry -eq 1 ]]; then
      printf '   [dry-run] '; paint "$c" "$(printf '%-10s' "$tier")"; printf ' %s\n' "$name"
    else
      gh label create "$name" --repo "$repo" --color "$color" --description "$description" --force >/dev/null
      printf '   '; paint "$c" "$(printf '%-10s' "$tier")"; printf ' %s\n' "$name"
    fi
  done < "$labels"
done