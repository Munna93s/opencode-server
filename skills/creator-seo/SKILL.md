---
name: creator-seo
description: Free/open-source workflow for helping with Instagram and YouTube growth tasks: clipping, hooks, titles, descriptions, hashtags, keywords, competitor research, transcript analysis, and posting plans. Uses local tools (yt-dlp, ffmpeg, neonclipping/beyondgtaclips/ortha-clipper/opencut) plus youtube-transcript-api, instaloader, and gallery-dl. Use when the user asks to handle/manage their Instagram or YouTube, improve SEO, get more views, research competitors, write captions/titles/tags, or plan/post clips.
---

# Creator SEO & Channel Support (free/open-source)

Use this skill to help the user grow YouTube/Instagram with **free tools and manual workflows**. Be honest: you cannot guarantee views, cannot log into accounts without user-provided credentials/API setup, and cannot run an always-on scheduler from ephemeral sessions. Focus on high-leverage work: better clips, hooks, packaging (SEO), and research-driven posting plans.

## Installed tools on this server

- **Specialised YouTube writing/analysis skills (`yt-*`, installed 2026-11-26, MIT from Jakeschincariol/youtube-agent-skill):**
  - `yt-script` — 21 hook formulas + scored hooks, then the script with retention beats. Use instead of writing hooks from scratch.
  - `yt-package` — lint title + thumbnail as one pairing (truncation, duplication, vagueness).
  - `yt-edit` — transcript → edit decision list (dead air, filler, retakes).
  - `yt-retention` — YouTube Studio retention CSV → hook leak, cliffs, slide.
  - `yt-chapters`, `yt-seo`, `yt-shorts`, `yt-comment`, `yt-plan`, `yt-audit`, `yt-viral` — chapters, metadata, Shorts ideas, comment replies, weekly plan, channel audit, niche outliers.
  - Six stdlib-only Python tools live inside those skill folders; see `templates/youtube/README.md`. Shared voice profile: `~/.config/opencode/youtube/voice.md`.

- **Research / metadata**
  - `yt-dlp` — search/fetch video metadata, formats, subtitles info, and public content details.
  - `youtube-transcript-api` (Python lib) — fetch YouTube transcripts/captions when available.
  - `instaloader` — inspect/download public Instagram profile/post/reel metadata and media (respect platform rules; use only for permitted/public research).
  - `gallery-dl` — extract/download media/metadata from supported sites for research or clipping sources where allowed.
- **Clipping / editing / media**
  - `ffmpeg`, `ffprobe`
  - Skills/tools: `neonclipping`, `beyondgtaclips`, `ortha-clipper`, `opencut`
  - `image-vision` for analyzing frames/thumbnails/screenshots

## What you can do well

1. **Competitor & keyword research**
   - Use `yt-dlp` to collect titles, views, upload dates, durations, tags/chapters/description patterns from relevant channels/videos.
   - Identify repeated winning patterns: hook style, topic angle, length, keywords, thumbnail/caption themes.
   - Build keyword/topic clusters (primary keyword + variants + long-tail questions).

2. **Transcript/hook extraction**
   - Pull transcripts via `youtube-transcript-api` (or yt-dlp subtitles where available) to find quotable/shocking/funny moments and convert them into hooks.
   - Turn long content into Shorts/Reels ideas with timestamps and hook lines.

3. **SEO packaging for each post**
   - Provide: 3-5 hook options, 3 title options (search-friendly + curiosity), description, 5-15 relevant hashtags/tags (mix broad+niche), pinned comment/CTA suggestion, and thumbnail text idea.
   - Keep metadata relevant to the actual clip; avoid misleading/clickbait that hurts retention.

4. **Clipping workflow**
   - Prefer existing local skills: `neonclipping` for captioned shorts from links/MP4, `beyondgtaclips`/`ortha-clipper` for stream/GTA-style moment finding, `opencut` for edits.
   - Output vertical 9:16 when targeting Shorts/Reels, strong first 1-2 seconds, readable captions, no dead time.

5. **Posting plan**
   - Create a realistic weekly plan based on user's capacity (consistency > volume).
   - Recommend posting times/windows to test, but prioritize checking **YouTube Studio / Instagram Insights** for the account's real audience data.

## Quick commands / snippets

```bash
# YouTube/Instagram/public media metadata (no download)
yt-dlp --dump-single-json "<url>" | jq '{title,upload_date,duration,view_count,like_count,description,tags,webpage_url}'
yt-dlp --flat-playlist --dump-single-json "<channel_or_playlist_url>" | jq '.entries[] | {title,view_count,duration,url}'

# YouTube transcript (Python)
python3 - <<'PY'
from youtube_transcript_api import YouTubeTranscriptApi
vid = "VIDEO_ID"
print(YouTubeTranscriptApi().fetch(vid))
PY

# Public Instagram research (metadata/media where permitted)
instaloader --dirname-pattern=/tmp/opencode/ig/{target} --metadata-json profile <username>
gallery-dl --dump-json "<url>" | head

# Clip with local tools (see their SKILL.md for details)
# neonclipping web: ./neonclipping/.venv/bin/python ./neonclipping/app.py
```

## Limitations (state clearly)

- No guaranteed views; SEO improves discoverability but content/retention/audience fit decide results.
- Cannot directly post/manage accounts without the user's account access, tokens, or API/OAuth setup (and IG/YT APIs have restrictions).
- No always-on background posting from a session that ends; provide ready-to-post packages and a manual/scheduled plan the user can execute.
- Respect copyright, platform Terms of Service, and privacy. Use downloads/reposts only when the user has rights/permission.

## Active Campaign: Lauren Hamden GTA 6 Clipping (Reach / "Sisters")
- Campaign page: https://reachclipping.com/Sisters — $5,000 Lauren Hamden GTA 6 Clipping Campaign (Live)
- User pages: https://www.instagram.com/laurenhamdenfanpage (primary), https://www.instagram.com/_bot_clan_ig_
- Bio link: `https://lozzahamden.click/` (user confirmed already in bio — keep it present)

### Mandatory rules (must follow for every clip/caption)
- **Platforms:** TikTok and Instagram Reels only.
- **Source:** Clip must feature Lauren Hamden's **GTA 6 playthrough livestream** moments (funny moments, memorable quotes, reactions).
- **Account:** Branded/themed Lauren Hamden clipping/fan account.
- **Caption must include:** `#LaurenHamden` and tag `@LaurenHamden` (required).
- **No negatives:** Do not portray Lauren Hamden in a negative light.
- **Not allowed:** AI-generated videos, any logos, view/engagement manipulation (botting, reposts, collab posts, or other manipulation).
- **Submission:** Submit video link within **30 minutes** of posting via Whop Content Rewards.
- **Payout/eligibility:** MVR 10,000 approved views; $1.50/1K views (min $15, max $250 per video) on TikTok/Instagram. At least **50% audience** from USA, CA, AU, UK, NZ.

### Default caption format to use (tailor hook/context to the actual clip)
```text
[STRONG HOOK — the funniest/shocking moment in caps, 0-2 sec focus] 😱

@LaurenHamden [1-2 lines: what happened + best quote/reaction from the GTA 6 livestream clip]

[CTA: question to drive comments + ask to save/share] 👇

Follow @laurenhamdenfanpage for daily @LaurenHamden GTA 6 livestream funny moments, fails & highlights 🎮

#LaurenHamden #GTA6 #GTA6Gameplay #GTA6Funny #GTA6Fails #GTA6Clips #GTAVI #ViceCity #TwitchClips #GamingReels
```

### Caption checklist (before giving/posting)
- [ ] First line is a scroll-stopping hook matching the clip's peak moment
- [ ] Includes `@LaurenHamden` tag and `#LaurenHamden` hashtag
- [ ] Context/quote is accurate to the clip (consistent name: Lauren Hamden)
- [ ] Has a comment CTA and save/share CTA
- [ ] 8–10 relevant hashtags at the end (proper `#tag` format, no broken/merged tags)
- [ ] No duplicate follow lines, no logos mentioned/added, no AI-claim, not negative toward Lauren
- [ ] Remind: bio has `https://lozzahamden.click/`, submit link within 30 min, 10k MVR, 50% US/CA/AU/UK/NZ audience
