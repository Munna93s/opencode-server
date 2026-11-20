---
name: opencut
description: Local OpenCut video editors installed on this server. Two clones live in the workspace: OpenCut-classic (archived but working Next.js web editor at http://localhost:3000) and OpenCut (the in-development rewrite with a Rust core, UI at http://localhost:5173 and API at http://localhost:8787). Use when the user asks to open, start, restart or use OpenCut to edit clips. Includes start commands, ports, and the fact that big video files stay local (gitignored).
---

# OpenCut (local video editors)

Two clones are kept in the workspace root and recreated by `setup.sh`:

| Clone | Status | UI | API |
|---|---|---|---|
| `OpenCut-classic/` | Archived but working | http://localhost:3000 | — |
| `OpenCut/` | Rewrite, still in development (README says use classic today) | http://localhost:5173 | http://localhost:8787 |

## Start / restart

Classic (needs Postgres + Redis in Docker):

```bash
cd OpenCut-classic
cp -n apps/web/.env.example apps/web/.env.local
docker compose up -d db redis serverless-redis-http
bun dev:web                 # http://localhost:3000
```

Rewrite (no root `package.json`; install deps per app):

```bash
export PATH="$HOME/.proto/bin:$PATH"   # proto pins moon/bun/rust from .prototools
cd OpenCut
proto use
bun install --cwd apps/web
bun install --cwd apps/api
cd apps/web && bun run dev             # http://localhost:5173
cd ../api && bun run dev               # http://localhost:8787 (wrangler)
```

`moon run web:dev` may report "No tasks found" on a shallow clone; running
`bun run dev` directly in `apps/web` works. Keep servers up with `nohup ... &`
and check with `curl -o /dev/null -w '%{http_code}' http://localhost:PORT/`.

## Notes

- `bun` is installed via npm globally; `proto` is installed from
  https://moonrepo.dev/install/proto.sh by `setup.sh`.
- Both clones are gitignored. Large media (`*.mp4`, `*.zip`) is also gitignored
  and must stay local — never push generated video files to GitHub.
- Prepared 9:16 reels live in `clips/` and `~/BeyondGTAClips/...` (see
  `clips/README_live_OIeLbmyraRQ.md`).
