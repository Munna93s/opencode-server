# OpenCode auto-fallback backup

- `opencode.json` — sanitized global OpenCode config. Keys are referenced as
  `{env:GEMINI_API_KEY}` and `{env:GROQ_API_KEY}`; no secrets are stored here.
- `rate-limit-fallback.json` — chain config: free OpenCode model → Gemini →
  Groq on 429/rate-limit errors, with a 3600 s cooldown and cycle-back.
- `server.yml` — the intended updated `.github/workflows/server.yml`. It adds
  the step that restores the config and loads the keys from GitHub Secrets
  into `~/.config/opencode/.env.local` on every server start.

  The server's GitHub App token cannot modify workflow files, so this file is
  kept here as the backup. With a token that has `workflows` permission, copy
  it to `.github/workflows/server.yml` and push.

## Required GitHub Secrets (repo Settings → Secrets and variables → Actions)

- `GEMINI_API_KEY` — Google Gemini API key.
- `GROQ_API_KEY` — Groq API key.

Both are exported by the workflow to the OpenCode server process; the values
are never written to the repository.
