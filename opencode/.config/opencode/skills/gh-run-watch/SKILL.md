---
name: gh-run-watch
description: >
  Use when waiting for CI checks to finish — instead of writing `sleep` loops
  or polling `gh run view`. Triggers after git push, PR creation, or when
  the user asks to check/verify CI status or workflow completion.
---

# CI Run Watch

## Overview

Discover active CI runs on the current branch, then watch each one with
deduplicated output. A single push often triggers multiple workflows
(e.g. api-go, api-laravel, admin) — the skill discovers them all before
watching.

## When to Use

- After pushing code that triggers CI
- When the user asks to check or wait for CI results
- When merging or before merging, to confirm CI is green
- After running `gh pr create` or similar CI-triggering actions

## Process

### 1. Discover active runs

```bash
branch=$(git branch --show-current)
gh run list --branch "$branch" --limit 10 --json databaseId,displayTitle,status,workflowName
```

Parse the JSON to categorize runs:

| Status | Action |
|--------|--------|
| queued / in_progress | Need watching |
| completed | Report conclusion immediately |

If all runs are already completed, skip to step 3.

If the user requested a specific run ID, skip discovery and go directly to step 2.

### 2. Watch each in-progress run

For each queued/in_progress run, watch sequentially:

```bash
gh run watch <id> --compact --exit-status 2>&1 \
  | sed '/^Refreshing run status/d' \
  | awk '!seen[$0]++'
```

- `sed` strips the repetitive "Refreshing run status..." ticker
- `awk '!seen[$0]++'` deduplicates all output — header prints once, only job status transitions produce new lines
- `--compact` hides passing step details
- `--exit-status` exits non-zero on failure

Add `-i 15` for slow-running workflows to reduce poll frequency.

### 3. Report the outcome

Per workflow:

```
✓ <workflow>
✗ <workflow>
- <workflow> (skipped/cancelled)
```

Single-line summary:
- All passed → `CI passed`
- Any failed → `CI failed: <workflow-names>`

### 4. Helpful flags

| Flag | Effect |
|------|--------|
| `gh run watch <id>` | Watch a specific run by ID |
| `-R owner/repo` | Watch a run in a different repository |
| `-i 30` | Check every 30s instead of 3s |

### 5. Edge cases

- **No runs on branch:** report "No runs found for `<branch>`" and stop
- **All runs already completed:** report status from discovery JSON, skip watching
- **Run cancelled:** treated as failure, report which workflow
- **Multiple runs queued:** watch all sequentially, report per-workflow

## Verification

After reporting, do not automatically retry or trigger a new run. If CI failed, let the user decide next steps.