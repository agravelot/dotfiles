---
name: codebase-memory
description: Use for code discovery, tracing execution paths, and understanding architecture. Triggered when searching for functions/classes/routes/variables, tracing call chains, analyzing code structure, or navigating large codebases. Use INSTEAD of grep/glob for structural queries like "who calls X", "where is Y defined", "how does Z work".
---

# Codebase Knowledge Graph (codebase-memory-mcp)

This project is indexed by codebase-memory-mcp. Every structural code query MUST start with graph tools before falling back to grep/glob/file-search.

## Tool Priority

1. **`search_graph`** — find functions, classes, routes, variables, interfaces by name, pattern, or semantic query. Use for "where is X", "find all handlers", "what classes implement Y".
2. **`trace_path`** — trace callers (inbound), callees (outbound), or data flow. Use for "who calls X", "what does X call", "impact analysis".
3. **`get_code_snippet`** — read a function/class source by qualified name. Use after `search_graph` to get the exact source. Faster than opening files.
4. **`query_graph`** — Cypher queries for complex multi-hop patterns. Use for "find functions that call X AND Y", dead code detection, aggregations.
5. **`get_architecture`** — high-level overview: packages, clusters, entry points, routes. Use for "how is this codebase organized".
6. **`search_code`** — graph-augmented grep over indexed files. Use for text patterns that need graph enrichment.

## When to fall back to grep/glob

- Searching for string literals, error messages, config values
- Searching non-code files (Dockerfiles, shell scripts, YAML configs)
- When graph tools return insufficient results (project not yet indexed, incomplete coverage)
- When you need raw file contents, not structural analysis

## Indexing

- `index_repository` — index a new project. Required before graph tools work.
- `index_status` — check if a project is indexed and fresh.
- `list_projects` — see all indexed projects.
- **Always verify the project is indexed** before querying. If `search_graph` returns empty, check `index_status` first.

## Tracing & Impact Analysis

- `trace_path` with `direction="inbound"` — find all callers
- `trace_path` with `direction="outbound"` — find all callees
- `trace_path` with `mode="data_flow"` — trace value propagation
- `detect_changes` — map uncommitted git changes to affected symbols with risk classification

## Graph Schema

- `get_graph_schema` — discover node labels, edge types, and property schemas. Run first in an unfamiliar indexed project.
- `manage_adr` — persist architectural decisions across sessions.

## Key Rules

- ALWAYS use `search_graph` before `grep` for any structural question about code
- ALWAYS use `trace_path` before manually tracing call chains with grep
- NEVER claim a function has "no callers" or "no usage" without running `trace_path` first
- ALWAYS provide the `project` parameter — use `list_projects` to find the correct project name
- Use `get_code_snippet` after `search_graph` to read source — it's faster than opening files
- For cross-project analysis, query multiple projects and compare results