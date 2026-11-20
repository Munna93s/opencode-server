# IShowSpeed GTA 6 FINALE — live clips (this run)

Source: https://www.youtube.com/live/OIeLbmyraRQ?si=1YpLP91PKLn9ul8A
Captured live 2026-11-20. All files are LOCAL ONLY (never push — `*.mp4` / `*.zip` are gitignored).

## Final 9:16 picks (use these)
| Clip | File | Note |
|---|---|---|
| Clutch — "You just saved my life!" | `clutch_saved_my_life_9x16_final.mp4` | hook corrected, true 9:16 |
| Hulk joke — "TURN INTO THE HULK" | `hulk_joke_9x16_final.mp4` | hook corrected, true 9:16 |
| "He wants hat me" | `he_wants_hat_me_9x16_final.mp4` | true 9:16 |
| Barcode chaos | `barcode_chaos_9x16_final.mp4` | true 9:16 |

Everything in one archive: `clips_pack.zip`

## Aspect-ratio fix
Earlier 9x16 files had SAR 256:81 / DAR 16:9 (looked flat in players).
All `_final.mp4` files are now 1080x1920, SAR 1:1, DAR 9:16 — verified with ffprobe.

## Also available
- `*_raw.mp4` — original 16:9 capture for each moment
- `*__hookcard.mp4`, `*__stack.mp4`, `*__bubble.mp4` — extra styled renders
- `checks/*.jpg` — 3-frame check images (vision QA)
- `POSTING.md` — A/B hooks, caption, hashtags
- `clips.json` — manifest

## Vision QA note
The two `*_fixed.mp4` hooks were rewritten to match what is actually visible/audible.
Free vision-model quota ran out before checking the other two check images.
