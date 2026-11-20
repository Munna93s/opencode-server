---
name: neonclipping
description: Use the locally installed NeonClipping on this server to turn a YouTube/Twitch/Kick link or a local MP4 into captioned vertical 9:16 clips for Reels, Shorts and TikTok. Covers the isolated venv, starting the web app, the /make API, output location and CPU-only limits. Use when the user asks to install/use NeonClipping, clip a video link into shorts, or says "neonclipping", "make reels from this video", "captioned 9:16 clips".
---

# NeonClipping (local install)

NeonClipping is a free, local FastAPI web app that finds loud / quotable
moments in a long video and renders captioned 1080x1920 MP4 clips. It lives in
`./neonclipping/` in the repo root (git-ignored, recreated by `setup.sh`
step [8/8]). Its dependencies are in `./neonclipping/.venv` — never install
them system-wide: `faster-whisper`, `ctranslate2`, `av` and `opencv` versions
clash with the global toolchain and with FaceFusion/ComfyUI.

This VM has no NVIDIA GPU: runs are CPU-only. YouTube links are fast because
the app uses YouTube's own word-timed captions and downloads only the chosen
sections. Twitch VODs and local MP4s need local speech recognition and are slow.

YouTube from this datacenter IP is bot-checked, so the venv also has the
`bgutil-ytdlp-pot-provider` plugin (Docker container `bgutil-provider` on
127.0.0.1:4416, started by `setup.sh`). Fresh browser cookies are still needed:
export a Netscape `cookies.txt` while logged into YouTube and save it at
`/tmp/opencode/youtube_cookies.txt` (or set `YOUTUBE_COOKIES_FILE`). Expired
cookies produce "Sign in to confirm you're not a bot" — replace them, don't
retry with the old file. Add `--js-runtimes node` when calling yt-dlp manually.

## Paths

- App: `./neonclipping/app.py`
- Python: `./neonclipping/.venv/bin/python`
- Pins: `./requirements-neonclipping.txt` (upstream list: `./neonclipping/requirements.txt`)
- Clips / source downloads / feedback: `./neonclipping/data/`
- Default URL: <http://127.0.0.1:8770> (loopback only unless phone access is enabled)

## Verify / diagnose

```bash
./neonclipping/.venv/bin/python -c \
  "import fastapi, uvicorn, yt_dlp, numpy, cv2, faster_whisper, PIL; print('imports ok')"
curl -s http://127.0.0.1:8770/healthz
```

## Start the web UI

From the repo root:

```bash
nohup ./neonclipping/.venv/bin/python ./neonclipping/app.py \
  > /tmp/opencode/neonclipping.log 2>&1 &
```

Wait a few seconds, then open `http://127.0.0.1:8770` in the browser. To use
another port set `NEONCLIPPING_PORT=8771`. `NEONCLIPPING_CPU=1` forces CPU.
`NEONCLIPPING_LAN=1` enables the phone remote (`/m`, PIN protected) — avoid it
unless the user explicitly asks for phone access. Stop the app with
`pkill -f 'neonclipping/app.py'`.

## Make clips without the UI

```bash
curl -s -X POST http://127.0.0.1:8770/make \
  -H 'Content-Type: application/json' \
  -d '{"url":"https://www.youtube.com/watch?v=QdBZY2fkU-0","count":2,"min_len":15,"max_len":30,"layout":"blur","mode":"fast"}'
# -> {"job": "..."}
curl -s http://127.0.0.1:8770/make/<job>   # poll until status == "done"
```

Rendered MP4s land under `./neonclipping/data/`. Check one with
`ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 <file>`
(expect `1080,1920`).

Optional AI titles/hooks need Ollama with `ollama pull llama3.2:3b`; without it
moment picking still works from audio/motion score. The first "Accurate"
caption render downloads a Whisper model (~1.6 GB) — warn the user first.

## Reinstalling / fixing the environment

```bash
./neonclipping/.venv/bin/python -m pip install -r requirements-neonclipping.txt
```
