# YouTube agent skills (yt-*)

Eleven skills vendored from [Jakeschincariol/youtube-agent-skill](https://github.com/Jakeschincariol/youtube-agent-skill) (MIT — see `LICENSE`), adapted for OpenCode on this server (2026-11-26).

## Installed skills

| Skill | What it does |
| --- | --- |
| `yt-script` | Idea → 5 scored hooks (21 formulas) + spoken script with retention beats |
| `yt-package` | Title + thumbnail linted as one pairing |
| `yt-edit` | Transcript → edit decision list (dead air, filler, repeats) |
| `yt-comment` | Comment triage + replies in the creator's voice |
| `yt-plan` | Realistic weekly plan (one anchor, one cheap video, three Shorts) |
| `yt-viral` | Videos ranked by multiple of their own channel's median |
| `yt-retention` | Retention CSV: hook leak, cliffs, slide, and what was said at each cliff |
| `yt-shorts` | Shorts already inside a long video, with a new first line |
| `yt-seo` | Description, worthwhile tags, three queries to win |
| `yt-chapters` | YouTube-valid chapters from a transcript |
| `yt-audit` | Whole-channel audit ending in ONE fix |

## Six stdlib-only Python tools

Run from the skill folder (no pip dependencies):

```bash
python3 skills/yt-script/hookscore.py --hook "one line"
python3 skills/yt-package/title.py --title "..." --thumb "AI RAN IT"
python3 skills/yt-edit/deadair.py transcript.srt
python3 skills/yt-chapters/chapters.py transcript.srt --target 8
python3 skills/yt-retention/retention.py retention.csv --transcript transcript.srt
python3 skills/yt-viral/swipe.py collected.json --min 2.0
```

## Adaptations from upstream

- Claude `/yt-*` slash commands are referenced as plain `yt-*` skill names; OpenCode discovers each `skills/yt-*/SKILL.md` by its frontmatter description.
- The shared voice file moved from `~/.claude/youtube/voice.md` to `~/.config/opencode/youtube/voice.md`. `setup.sh` seeds it from `voice.md` here if it does not exist; fill it in (ten minutes here beats any prompt).
- Nothing publishes. Every skill ends with a copyable block and asks the user to ship it or change it.
- `hookscore.py` is a heuristic, not a predictor: a low score means look again, a high score promises nothing. `yt-viral` reads only public listings you collected; it never logs in.

Source of truth for updates: upstream repository above. Re-vendor by copying `skills/yt-*` and re-applying the two path adaptations above.
