---
name: remotion
description: Remotion — React framework for programmatically creating videos (MP4, PNG, image sequences) in Node.js. Use when you want to render video from React components, build a Remotion starter project, or render still frames / animations with `remotion still` / `remotion render`.
---

# Remotion — React video framework

[Remotion](https://github.com/remotion-dev/remotion) is a React-based framework
for creating videos programmatically. You write React components, and Remotion
renders them to MP4, PNG, or image sequences using Chrome Headless + FFmpeg.

This server has a ready-to-use Remotion starter project at `./remotion-starter/`
(v4.0.547, React 19, TypeScript). It is installed by `setup.sh` and the source
is committed (without `node_modules`).

## What is installed

- `remotion` — core framework
- `@remotion/cli` — CLI (`remotion preview`, `remotion render`, `remotion still`, …)
- `react`, `react-dom` — peer dependencies
- `typescript`, `@types/react`, `@types/react-dom` — dev dependencies

## Project layout

```
remotion-starter/
├── package.json            # scripts: start | build | test
├── tsconfig.json
├── prettier.config.ts      # required by Remotion
└── src/
    ├── index.ts            # registerRoot(MyComp) — entry point
    └── HelloWorld.tsx      # <Composition> + <Solid> example
```

## How to use

```bash
cd remotion-starter

# Install dependencies (already done by setup.sh, but re-run if needed)
npm install

# Start the Remotion Studio (live preview in browser)
npm start          # → remotion preview

# Render a single still frame (PNG)
npx remotion still src/index.ts HelloWorld /tmp/opencode/frame.png

# Render a video (MP4)
npm run build      # → remotion render src/index.ts HelloWorld out.mp4 --image-format jpeg

# List compositions
npx remotion compositions src/index.ts

# Check Remotion version
npx remotion --version
```

## Example component (`src/HelloWorld.tsx`)

```tsx
import { Composition, Solid } from "remotion";

export const HelloWorld = () => (
  <Solid width={800} height={450} style={{ background: "#4f46e5" }} />
);

export const MyComp = () => (
  <Composition
    id="HelloWorld"
    component={HelloWorld}
    durationInFrames={90}
    fps={30}
    width={800}
    height={450}
  />
);
```

## Notes

- `node_modules/` is **not** committed to Git; it is recreated by
  `setup.sh` (`npm install` in `remotion-starter/`).
- Large render outputs (`*.mp4`, `*.png`) are git-ignored — keep them local
  under `/tmp/opencode/` or the `clips/` folder.
- Rendering uses Chrome Headless Shell (auto-downloaded by Remotion on first
  run) and FFmpeg (already installed on this server).
- `remotion still` / `remotion render` bundle the entry point with webpack; if
  you see `"registerRoot() was called more than once"`, wrap the call in a
  `try/catch` (see `src/index.ts`).
