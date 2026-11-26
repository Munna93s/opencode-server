---
name: mcp-research
description: Find and configure MCP servers for OpenCode, and read up-to-date docs/code from any GitHub repo with the configured GitMCP server. Use when the user asks about MCP servers, "check this repo's docs", library docs, tool discovery, or mentions awesome-mcp-servers / MCPHub / MCP installer.
---

# MCP research & repo docs

OpenCode already has MCP support (`opencode mcp list|add|auth|logout`). This skill covers the one server worth having by default and where to look for others.

## Configured: GitMCP (free, remote, no API key)

Registered globally by `setup.sh` in `~/.config/opencode/opencode.json`:

```bash
opencode mcp add --global gitmcp --url https://gitmcp.io/docs
```

It turns **any public GitHub repo** into live documentation/code search. Available tools:

| Tool | Use |
| --- | --- |
| `match_common_libs_owner_repo_mapping` | Library name → owner/repo; try this first when only a name is given |
| `fetch_generic_documentation` | Whole doc set for an owner/repo |
| `search_generic_documentation` | Semantic search inside a repo's docs |
| `search_generic_code` | Find code files in a repo (30 results/page) |
| `fetch_generic_url_content` | Fetch an absolute URL referenced by fetched docs (robots.txt respected) |

Workflow: if you only know the library name, call `match_common_libs_owner_repo_mapping` first; then search docs, then code if needed. Prefer this over guessing APIs from memory, especially for fast-moving projects (OpenCode, Remotion, FFmpeg wrappers).

**Privacy:** public repos only. Never send private repo names, tokens, cookies or user data to a remote MCP server.

## Catalogues checked (reference, not installed)

- [punkpeye/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) — largest curated list; use when the user needs a specific capability (browser, GitHub, databases, etc.).
- [liuyoshio/mcp-compass](https://github.com/liuyoshio/mcp-compass) — discovery/recommendation service (stale, small; catalogue only).
- [idosal/git-mcp](https://github.com/idosal/git-mcp) — source of the configured GitMCP server.
- [idosal/AgentPolyfill](https://github.com/idosal/AgentPolyfill) — MCP support bridge for hosts including OpenCode (only if a host lacks native MCP).
- [samanhappy/mcphub](https://github.com/samanhappy/mcphub) — self-hosted MCP gateway; install only if the user actually wants a central control plane.

## Deliberately NOT installed (Claude Code ecosystem)

These target Claude Code / Claude Desktop or IDEs and would duplicate the running OpenCode agent or require an Anthropic API key: `anthropics/claude-code`, `anthropics/claude-cookbooks`, `anthropics/claude-quickstarts`, Claude Desktop extensions, `SuperClaude-Org/SuperClaude_Framework`, `musistudio/claude-code-router`, `eyaltoledano/claude-task-master`, `Doriandarko/claude-engineer`, `affaan-m/claude-swarm`, `continuedev/continue`, `cline/cline`, `Aider-AI/aider`, `OpenHands/OpenHands`, `OpenInterpreter/open-interpreter`.

Install any of them only on explicit request, with the needed API key/IDE and in an isolated directory. Note the user's links had typos; corrected slugs are listed in `templates/mcp-review.md`.
