---
name: instagram-growth-os
description: Instagram growth and audit toolkit (Ethos6/instagram-growth-os, MIT). Provides the `igos` CLI for auditing Instagram Insights CSV exports, scoring hooks, linting captions, timing Reel beat sheets/SRT, checking profile rubric, planning content, and humanizing/detecting AI-ish text. Use when the user wants an Instagram audit, profile review, content plan, hook/caption linting, or Insights CSV analysis. Does not log in, scrape, or post to Instagram.
---

# Instagram Growth OS (`igos`)

Open-source (MIT) Instagram workflow toolkit installed locally.

- Repo: https://github.com/Ethos6/instagram-growth-os
- Local clone: `tools/instagram-growth-os/`
- CLI: `igos` (installed via editable pip install)
- No dependencies beyond Python stdlib; no API keys; no network calls; no Instagram login/scraping/posting.

## What it can audit

- **Insights CSV audit**: `igos audit <insights_export.csv> [--top N] [--json]` - ranks posts by sends/reach, compares formats, surfaces patterns. Requires user-exported Instagram Insights CSV.
- **Profile audit/rubric**: `igos profile --rubric` prints the 100-point rubric; `igos profile <file>` lints name/bio fields.
- **Caption lint**: `igos caption <caption.txt> [--keywords "..."] [--sponsored]` checks preview cut, length, hashtags, CTA, disclosure, search terms.
- **Hook scoring**: `igos hook <hooks.txt>` ranks hooks; `igos patterns` shows pattern library.
- **Reel beats/SRT**: `igos beats <script.txt> --target 25 --srt captions.srt`.
- **Humanize/detect**: `igos humanize <draft.txt>`, `igos detect <before.txt> <after.txt>`.
- **Planning**: `igos plan <plan.csv> --ics plan.ics`.
- **Platform limits**: `igos limits`.

## Honest limits

- Not a magic "audit any public IG/YouTube account by URL" tool. Instagram audits are strongest with the user's own Insights export and profile/content inputs.
- For public YouTube/Instagram research by URL, combine with `creator-seo` skill tools (`yt-dlp`, `instaloader`, `gallery-dl`, `youtube-transcript-api`).
- It never posts to Instagram; all outputs are drafts/checks for human review.
