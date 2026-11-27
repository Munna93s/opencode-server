# AGENTS.md

## स्थायी नियम (Permanent rule — always follow)

जब भी यूज़र इस सर्वर पर कोई नया skill, tool, python/npm/apt पैकेज या AI मॉडल इंस्टॉल करवाए, तो काम पूरा होते ही तुरंत `setup.sh`, `requirements.txt` और `skills/` फ़ोल्डर को अपडेट करो। इसके बाद बड़ी वीडियो फ़ाइलों (`*.mp4`, `*.zip`) को छोड़कर बाकी सभी बदलावों को सीधे GitHub रिपॉजिटरी (`Munna93s/opencode-server`) में push कर दो।

### English (same rule, for reference)

Whenever the user installs any new skill, tool, Python/npm/apt package, or AI model on this server, immediately update `setup.sh`, `requirements.txt`, and the `skills/` folder as soon as the work is done. Then push every change except large video files (`*.mp4`, `*.zip`) directly to the GitHub repository `Munna93s/opencode-server`.

### Kam shuru karne se pehle check (Pre-check rule — hamesha follow karein)

Jab bhi user koi naya kam bataye (`jo kam karna hai`), toh sabse pehle ye check karein:

1. `./scripts/kaam.sh "<user ka kam>"` chalayein (ya `~/.local/bin/kaam "<kam>"`). Ye installed skills (`skills/` folder), CLI tools (ffmpeg, yt-dlp, tesseract, ollama, opencode, igos, ocr, image-upload, see), pip packages, aur AI models (Ollama + OpenCode default model) ki list nikalega.
2. User ke kam se related installed skill / tool / AI select karein (script ki "SIFARISH" section mein dekhein).
3. Usi installed skill / tool / AI ka use karke kam shuru karein.
4. Agar koi zaroori skill / tool / AI install nahi hai, toh user se poochein — phir `setup.sh`, `requirements.txt` aur `skills/` update karke install karwayein, aur badlaav GitHub (`Munna93s/opencode-server`) par push karein.

Yeh rule har baar kaam shuru karne se pehle lagu hogi taaki pehle check karein, phir related install cheezon ka use karein.

### English (same rule, for reference)

Before starting any user task, always run `./scripts/kaam.sh "<task>"` (or `~/.local/bin/kaam "<task>"`). It inventories installed skills (`skills/`), CLI tools, pip packages, and AI models (Ollama + OpenCode default). Then pick the related installed skill/tool/AI from the "SIFARISH" section and use it to start the work. If something needed isn't installed, ask the user, then update `setup.sh`, `requirements.txt`, and `skills/`, install it, and push to GitHub (`Munna93s/opencode-server`).

## Supporting notes

- Default OpenCode model is `opencode/big-pickle` (free, reliable tool use with all skills + this AGENTS.md). Local Ollama models (`qwen2.5:7b`, etc.) are opt-in via the `unlimited` command or `/model` in the TUI — they are offline fallbacks only, because small 7B models loop on the tool-call protocol when 82 skills are loaded. Do not set a local 7B model as the default again.
- Git push authentication is configured automatically on server start by `.github/workflows/server.yml` using the repository's `GH_PAT` secret. Do not ask the user for a token unless that secret is missing or invalid.
- Large binaries are listed in `.gitignore` and stay local only; captions, SRT, JSON and text manifests are backed up.
- After any install, run `bash -n setup.sh` and validate `.github/workflows/server.yml` before committing.
