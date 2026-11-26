# Ootto-AI skills (installed 2026-11-26)

Source: <https://github.com/Ootto-AI> — MIT licensed, by Ootto / @jayantcreates.ai.

| Installed under `skills/` | Upstream repo | What it is |
|---|---|---|
| 55 skill folders (`content-factory`, `virality`, `ai-brain`, `agent-reach`, `reel-analyzer`, `going-viral`, `viral-hook-writer`, `hook-mining`, `reel-scripter`, `reel-builder`, `humanizer`, `caption-and-hashtags`, `content-repurposer`, `content-calendar`, `comment-responder`, `trend-spotter`, `competitor-teardown`, `content-audit`, `carousel-builder`, `story-sequencer`, `series-planner`, `analytics-readout`, `hashtag-keyword-research`, `cover-thumbnail-brief`, `on-screen-text-writer`, `b-roll-shot-list`, `ugc-creator-brief`, `cta-writer`, `dm-script-writer`, `best-time-scheduler`, `cross-platform-reformatter`, `ab-hook-tester`, `viral-carousel`, `bio-profile-optimizer`, `collab-outreach`, `x-thread-strategy`, `linkedin-thought-leadership`, `utm-campaign-plan`, `social-listening`, `social-proof-mining`, `social-analytics-report`, `profile-conversion-audit`, `positioning-audit`, `competitor-positioning`, `audience-personas`, `campaign-brief`, `influencer-partnerships`, `creator-outreach`, `paid-social-brief`, `community-engagement-plan`, `launch-retrospective`, `content-research`, `cross-platform-distribution`) | [Ootto-AI/claude-content-skills](https://github.com/Ootto-AI/claude-content-skills) | Copy-paste Claude skills that run an Instagram/content growth factory. `content-factory` orchestrates the whole pipeline; `virality` and `humanizer` are the standouts (built from 262 posts / 3.5M views). |
| `watch-video` | [Ootto-AI/ootto-watch](https://github.com/Ootto-AI/ootto-watch) | Give the agent eyes + ears: `yt-dlp` download → `ffmpeg` frame sampling → transcript (native captions or local Whisper) → frames and words aligned on one timeline, for grounded video analysis or batch pattern-finding. |

## Install notes

- These are prompt skills with `SKILL.md` frontmatter in the same format OpenCode uses, so `setup.sh` restores them together with all other skills via `cp -a skills/. ~/.config/opencode/skill/`.
- No new pip/npm/apt packages were needed. `hook-mining/mine_hooks.py` is Python 3 stdlib-only.
- `watch-video` uses `yt-dlp` and `ffmpeg`/`ffprobe`, already on PATH. For videos without native captions, `faster-whisper` is available in the pre-existing `~/.beyondgtaclips/venv`; run `~/.beyondgtaclips/venv/bin/python skills/watch-video/scripts/watch.py ...` for those. `--no-whisper` skips transcription entirely.
- Some Ootto skills (notably `content-factory` and `agent-reach`) assume Claude Code connectors such as Apify MCP, Composio, or an Obsidian filesystem vault. On this server they work as standalone prompts; connecting those accounts is optional and must be done by the user (never fake a post/render).
- Upstream `SKILL.md` files were kept verbatim except `watch-video/SKILL.md`, which got two local notes about the Whisper venv and the image-vision fallback.
