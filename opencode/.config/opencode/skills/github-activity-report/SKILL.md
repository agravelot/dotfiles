---
name: github-activity-report
description: Generate a GitHub activity, pull-request, commit, review, and estimated-time report from the authenticated gh CLI account. Use whenever the user asks for their GitHub activity, contribution summary, PR breakdown, daily project activity, private GitHub activity, commit-by-branch reporting, or an evidence-based time estimate from GitHub events.
---

# GitHub Activity Report

Create an evidence-based report from the local `gh` CLI session. Include private repositories accessible to the authenticated account. Do not rely on the public contribution calendar or anonymous GitHub search: both can omit private activity.

## Inputs

Determine these before querying:

- **Account:** use the active `gh` account unless the user names another configured account. Confirm it with `gh api user --jq .login`.
- **Period:** use the user-specified inclusive date range. If absent, use the current calendar month in UTC.
- **Scope:** report authored work, reviews, comments, and PR lifecycle events by default. Explain that GitHub-visible data cannot measure meetings, local work, uncommitted changes, external ticket work, or CI waiting.

Use `gh auth status` to confirm that the selected account is authenticated and has `repo` scope. If the account cannot access the expected private organization, say so clearly instead of presenting a complete-looking report.

## Data Collection

Use `gh api graphql` rather than the public contribution calendar. Run independent queries in parallel when possible.

### Authored Pull Requests and Commits

Search authored PRs created in the reporting period. Request each PR's repository, number, title, URL, source branch (`headRefName`), lifecycle timestamps, and commits. Only count commits whose `author.user.login` equals the selected account.

Use this query shape, replacing `LOGIN`, `FROM`, and `TO`:

```graphql
query {
  search(
    query: "is:pr author:LOGIN created:FROM..TO"
    type: ISSUE
    first: 100
  ) {
    nodes {
      ... on PullRequest {
        number
        title
        url
        createdAt
        mergedAt
        closedAt
        isDraft
        headRefName
        repository { nameWithOwner }
        commits(first: 100) {
          totalCount
          nodes {
            commit {
              oid
              committedDate
              author { user { login } }
            }
          }
        }
      }
    }
  }
}
```

Paginate the search if needed. If any PR has more than 100 commits, fetch its remaining commits before using its count. Do not use the PR's `commits.totalCount` as a daily commit count: commits might have happened before or after the PR was created.

### Reviews and Discussion Comments

Search separately for:

- `is:pr reviewed-by:LOGIN updated:FROM..TO`
- `is:pr commenter:LOGIN updated:FROM..TO`

For every matching PR, fetch its repository, number, title, URL, and reviews or issue comments. Filter results locally to the selected account and timestamps within the period. Classify review states as `APPROVED`, `CHANGES_REQUESTED`, or `COMMENTED`.

Keep reviews and issue comments distinct. A review can contain comments, but it represents one submitted review event. Do not double-count it as a general PR comment.

### PR Lifecycle Events

Use timestamps from authored PRs:

- Creation: `createdAt`
- Merge: non-null `mergedAt`
- Closed without merge: non-null `closedAt` and null `mergedAt`

Attribute each lifecycle event to its timestamp day, not the PR creation day.

## Aggregation Rules

Use UTC dates unless the user requests a timezone.

- Count an authored commit on its `committedDate` day.
- Deduplicate daily authored commits by `repository + oid`.
- Map a commit to the `headRefName` of each authored PR containing it. This is the PR source branch, not a claim that Git can prove where the commit was originally made.
- If one commit appears in multiple PRs, count it once in the daily total and label its branch mapping as shared.
- Use `0` commits and `N/A` branch for review-only or comment-only rows.
- Do not infer commits from PR creation, merge, review, or comment counts.
- Include activity on projects where the user reviewed or commented even if they authored no PR there.

## Estimated Time

Provide a range, not a timecard. Use GitHub-visible signals only.

Suggested heuristic bands:

| Signal | Typical contribution to estimate |
|---|---:|
| Meaningful authored commit | 15-40 minutes |
| PR creation | 10-25 minutes |
| Merge or close action | 5-15 minutes |
| Approval or comment-only review | 15-35 minutes |
| Changes-requested review | 25-60 minutes |
| General PR comment | 5-15 minutes |

Adjust downward for commits created in a tight timestamp batch or obvious formatting/generated changes. Adjust upward only when the PR description and change scope clearly support it. Never convert raw commit count linearly into hours. State that the estimates exclude work not visible on GitHub.

## Report Structure

Start with a concise scope statement containing the account, period, and whether private repositories were accessible. Then produce this primary table, adding one row per project and day with activity:

| Date | Project | PR / Activity | Commit count | Commit branch | Estimate |
|---|---|---|---:|---|---:|

In `PR / Activity`:

- Link every named PR as `[#123 concise title](URL)`.
- Include lifecycle markers: `PR+` for created, `M` for merged, `X` for closed unmerged, `R` for review, and `Co` for general PR comment.
- For authored implementation, identify the PR and its source branch.
- For reviews or comments, name the target PR and omit a branch unless the user explicitly asks for the target PR's branch.

After the daily table, include:

1. **Project totals** with PRs created, merged, closed unmerged, unique authored commits, reviews, comments, and estimated range.
2. **Summary** with total active days, projects, PRs created, merges, authored commits, reviews by state, comments, and a GitHub-visible total estimate.
3. **Limits** stating that the report is an activity-based estimate, not a record of actual hours.

Do not omit low-activity days: a single review, comment, merge, or commit still receives a row. Keep the table scannable by grouping multiple activities from the same project on the same date into one row.

## Accuracy Checks

Before presenting the report, verify:

- Every PR title, link, and branch comes from the authenticated API response.
- Daily commit totals use commit timestamps, not PR dates or total commits attached to PRs.
- Merged and closed-unmerged counts are mutually exclusive.
- Review-only and comment-only rows show `0` and `N/A` in the commit columns.
- The summary totals reconcile with the daily and project tables.
- Private-access limitations or query truncation are disclosed.
