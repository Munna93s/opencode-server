# Review of the 20 Claude / MCP repos (2026-11-26)

User-supplied links were checked against the GitHub API. Corrected slugs where the pasted URL was wrong.

| # | Pasted repo | Correct slug | Stars | Verdict |
| --- | --- | --- | --- | --- |
| 1 | anthropics/claude-code | same | 157k | Skip — alternative agent CLI; needs Anthropic key, OpenCode is the harness here |
| 2 | anthropics/claude-cookbooks | same | 55k | Skip — example notebooks, need Claude API key; reference only |
| 3 | anthropics/claude-quickstarts | same | 21k | Skip — Claude API starter apps, need key |
| 4 | Claude Desktop Extensions | no such `anthropics/*` repo | — | Skip — desktop-only, headless server |
| 5 | hesreallyhim/awesomeclaudecode | `hesreallyhim/awesome-claude-code` | 59k | Skip install — useful catalogue, covered by `mcp-research` note |
| 6 | punkpeye/awesome-mcp servers | `punkpeye/awesome-mcp-servers` | 99k | Reference only — 654 MB repo, catalogue linked in `mcp-research` |
| 7 | SuperClaude Framework | `SuperClaude-Org/SuperClaude_Framework` | 24k | Skip — Claude Code slash-command/persona config, not OpenCode |
| 8 | musistudio/claude-code-router | same | 38k | Skip — OpenCode already has provider fallback plugin |
| 9 | eyaltoledano/claude-task-master | same | 29k | Skip — stale (Apr 2026), needs Anthropic key |
| 10 | Doriandarko/claude-engineer | same | 11k | Skip — stale (2024), Claude 3.5 API key |
| 11 | parallaxsys/claude-swarm | `affaan-m/claude-swarm` | 503 | Skip — orchestrates Claude Code processes |
| 12 | zebbern/claude-dev-tools | not found (`zebbern/claude-code-guide` exists) | — | Skip |
| 13 | liuyoshio/mcp-compass | same | 255 | Reference only — discovery service, stale |
| 14 | anaisbetts/mcp-installer | same | 1.5k | Skip — OpenCode has native `opencode mcp add` |
| 15 | idosal/mcphub | no such repo (`idosal/git-mcp` exists; `samanhappy/mcphub` is the gateway) | — | Installed the useful part: **GitMCP** remote MCP server |
| 16 | continuedev/continue | same | 37k | Skip — IDE extension/CLI agent, duplicate of OpenCode |
| 17 | cline/cline | same | 72k | Skip — IDE extension/SDK, duplicate |
| 18 | OpenInterpreter/open-interpreter | `openinterpreter/openinterpreter` | 69k | Skip — another coding agent, needs model keys |
| 19 | Aider AI/aider | `Aider-AI/aider` | 50k | Skip — needs model API key, duplicate |
| 20 | OpenDevin/OpenDevin | `OpenHands/OpenHands` | 94k | Skip — heavy self-hosted platform, duplicate |

**Installed from this review:** GitMCP (`https://gitmcp.io/docs`) as a global OpenCode MCP server, plus the `mcp-research` skill that documents it. No repo was cloned; no API keys were needed.
