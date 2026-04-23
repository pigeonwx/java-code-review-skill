#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "# step-1: collect-whole-diff"
sh "$ROOT/scripts/collect_java_diff.sh" "$@"

echo
echo "# step-2: pass-1-general-whole-diff"
echo "- read: $ROOT/references/checklist.md"

echo
echo "# step-3: pass-1-general-per-file"
sh "$ROOT/scripts/collect_java_diff_by_file.sh" "$@"
echo "- read: $ROOT/references/checklist.md"

echo
echo "# step-4: pass-2-rag-whole-diff"
echo "- read: $ROOT/references/rag-knowledge-list.md"

echo
echo "# step-5: pass-2-rag-per-file"
sh "$ROOT/scripts/collect_java_diff_by_file.sh" "$@"
echo "- read: $ROOT/references/rag-knowledge-list.md"

echo
echo "# step-6: report"
echo "- merge findings and output MUST/SHOULD/NICE counts"
