#!/usr/bin/env bash
set -euo pipefail

resolve_base() {
  if git rev-parse --verify origin/main >/dev/null 2>&1; then
    echo "origin/main"
    return
  fi
  if git rev-parse --verify origin/master >/dev/null 2>&1; then
    echo "origin/master"
    return
  fi
  echo "origin/master"
}

BASE=""
NO_FETCH=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --base)
      BASE="${2:-}"
      shift 2
      ;;
    --base=*)
      BASE="${1#*=}"
      shift
      ;;
    --no-fetch)
      NO_FETCH=1
      shift
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

if [[ -z "$BASE" ]]; then
  BASE="$(resolve_base)"
fi

if [[ "$NO_FETCH" -eq 0 ]]; then
  git fetch origin
fi

echo "# base: $BASE"
git diff "$BASE" -- "*.java"
