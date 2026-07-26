---
name: gh-run-watch
description: >
  Watch GitHub Actions CI runs for completion using `gh run watch --compact`
  with minimal, token-efficient output. Triggers after code changes, git
  pushes, or when the user asks to check CI status, wait for workflows, or
  verify that CI passed.
---

# CI Run Watch

## Overview

Use `gh run watch` to wait for a GitHub Actions run to complete and report only the essential outcome. Prefers the `--compact` flag to surface only failed/relevant steps, minimizing token consumption.

## When to Use

- After pushing code that triggers CI
- When the user asks to check or wait for CI results
- When merging or before merging, to confirm CI is green
- After running `gh pr create` or similar CI-triggering actions

## Process

### 1. Watch the run

```bash
gh run watch --compact --exit-status
```

- `--compact` shows only relevant (failed or in-progress) steps, not every passing step.
- `--exit-status` ensures the command exits non-zero if CI fails, so you can branch on the result.
- The command blocks until the run finishes or is cancelled.

### 2. Report the outcome

**If it passes (exit code 0):** output a single line:

```
CI passed
```

**If it fails (non-zero exit code):** output:

```
CI failed: <failed-job-names>
```

Extract the failed job names from the `gh run watch` output. If the output is too long, pipe through `tail` to get the final summary.

### 3. Helpful flags

| Flag | Effect |
|------|--------|
| `gh run watch` | Watches the most recent run on the current branch |
| `gh run watch 12345` | Watches a specific run by ID |
| `-R owner/repo` | Watch a run in a different repository |
| `-i 30` | Check every 30s instead of the default 3s (saves poll requests) |

### 4. Edge cases

- **No runs exist:** `gh run watch` exits with "no runs found." Report that and stop.
- **Run already completed:** The command exits immediately with the final status.
- **Run cancelled:** Treated as a failure — report which job was cancelled.
- **Multiple runs in progress:** The command picks the most recent. Pass an explicit run ID if needed.

## Verification

After reporting, do not automatically retry or trigger a new run. If CI failed, let the user decide next steps.