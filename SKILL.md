---
name: java-code-review-skill
description: Provides comprehensive code review guidance for Java. Helps catch bugs, improve code quality, and give constructive feedback. Use when reviewing pull requests, conducting PR reviews, reviewing code changes, checking code quality, finding bugs, giving feedback on code.
---

# Java Code Review

## Goal
Perform a strict two-pass CR for Java changes in the current branch against the latest remote baseline.

## Scope Boundaries
- Compare current local branch with latest remote `origin/main` or `origin/master`.
- Review only code in current diff.
- Focus on correctness, robustness, readability, maintainability, and test quality.
- Do not modify code unless the user explicitly asks for fixes.

## Severity Levels
- `MUST`: blocking issue, must be fixed before merge.
- `SHOULD`: strong recommendation, should be fixed.
- `NICE`: optional improvement with low risk/cost.

## Mandatory Workflow
Follow this exact order without skipping:

1. **Collect whole diff**
   - `sh scripts/collect_java_diff.sh`
2. **Pass-1: general checklist (whole diff CR)**
   - Read `references/checklist.md`
   - Review all diff hunks as one change set.
3. **Pass-1: general checklist (per-file CR)**
   - `sh scripts/collect_java_diff_by_file.sh`
   - Review each changed file independently.
4. **Pass-2: custom RAG list (whole diff CR)**
   - Read `references/rag-knowledge-list.md`
   - Re-review all diff hunks as one change set.
5. **Pass-2: custom RAG list (per-file CR)**
   - `sh scripts/collect_java_diff_by_file.sh`
   - Re-review each changed file independently with RAG rules.
6. **Merge and de-duplicate findings**
   - Keep highest severity if duplicates exist.
   - Keep file-level context when available.

## Required Resources
- `references/checklist.md`: pass-1 general checklist.
- `references/rag-knowledge-list.md`: pass-2 custom RAG rules.
- `scripts/collect_java_diff.sh`: whole-diff collection.
- `scripts/collect_java_diff_by_file.sh`: per-file diff collection.
- `scripts/run_java_code_review.sh`: one-command orchestration helper.

## Output Protocol
Use this structure:

```text
CR result:
- MUST: <count>
- SHOULD: <count>
- NICE: <count>

Pass-1 (General Checklist) - Whole Diff:
1) [RuleID][Level] <issue> -> <suggestion>

Pass-1 (General Checklist) - Per File:
1) [File: <path>][RuleID][Level] <issue> -> <suggestion>

Pass-2 (RAG Knowledge) - Whole Diff:
1) [RuleID][Level] <issue> -> <suggestion>

Pass-2 (RAG Knowledge) - Per File:
1) [File: <path>][RuleID][Level] <issue> -> <suggestion>

Final action:
- Modified: <yes/no>
- Change scope: <files/symbols in current diff>
```

## Interaction Constraints
- If user asks only for CR: report findings only, do not edit code.
- If user asks for fixes: edit only issues related to current diff unless explicitly requested.
- If no findings: return `No critical issues found in current Java diff.`

## Context Isolation
- Treat each pass as a fresh review.
- Do not reuse conclusions from previous runs without re-checking the latest diff.
- Always resolve baseline dynamically (`origin/main` first, fallback to `origin/master`).
