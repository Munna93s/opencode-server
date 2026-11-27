# ACTION MOVIE MONTAGE EDITING PLAYBOOK
*Ek hi 37s reference reel se nikal gayi editing skills + reusable template. Burned-in editor handle/watermark aur closing handle card JAAN-BUJH KAR HATA DIYE GAYE HAIN — koi handle name is playbook mein copy nahi kiya gaya. Movie scenes ki apni in-scene text (DANGER sign, POLICE car, "Loki / #3") scene ka hissa hai, overlay nahi.*

---

## SOURCE / TECHNICAL
- **File:** `savefromins.com  0 1080P.mp4` (uploaded reference)
- **Canvas:** 1080x1080 **SQUARE (1:1)**, 60fps, 37.05s, H.264, AAC stereo.
- **Native sound:** mean −16.6 dB / peak −1.8 dB — music-led, dialogue nahi; cut sync audio peaks se kiya gaya hai.
- **Content:** Deadpool / Spider-Verse / Black Widow / Loki / Hulk / Black Panther ke movie clips — ek "character-burst montage", koi car footage nahi.
- **Verification:** 2fps contact sheets (74 frames) + 4fps fine sheets + scene-score detection + 20fps frame-diff + RMS audio peaks + full-res watermark crop.

---

## ⚠️ WATERMARK / HANDLE POLICY (user request — pehle ki tarah)
- Source reel mein **bottom-center** ek chhota, semi-transparent white editor handle tha (approx `x=400..740, y=882..930` px, ~30px font).
- Antimat ke baad **35.3s se 37.05s tak handle end-card** tha (black frame + white glowing handle + red ember particles).
- **Dono hata diye gaye.** Na skills mein handle likha gaya, na template mein, na output video mein.
- Cleanup recipe (agar dobara aise source par karna ho): `delogo=x=410:y=848:w=430:h=88` + video/audio dono ka `trim=end=35.28` se end-card cut. Test ke baad 3 alag frames par watermark nahi mila.
- Ready cleaned reference: `clips/action_montage_2026-11-27/reference_clean_1080.mp4` (1080x1080, 35.28s, 28.3 MB).
- Rule: **handle/branding intro-outro kabhi copy mat karo** — apni identity apne editing pattern se banao (yahan: color-coded clusters + macro-to-action beat).

---

## FORMAT / CONCEPT (SAVE KARNE LAYAK)
- **"Character-burst montage"**: har character ka 2-4 shot ka chhota cluster, phir agla character. Total 6 clusters in 35s.
- **Square 1:1 canvas** — feed Reels/Shorts/TikTok ke liye, lekin letterbox nahi; frame poori tarah bhari hai.
- **Koi text overlay nahi** — hook, pacing, color shift aur motion blur hi storytelling karte hain.
- **Color-coded chapters**: har cluster ki alag grading — pehchaan instantly badalti hai bina text ke.
- Editor ka "signature" motion-blur + hard-cut rhythm hai, watermark nahi.

---

## HOOK (0 – 2s) — cold open
1. **0.0–0.65s** — extreme close-up: black tactical glove + pistol, dark teal bokeh background. Tight focus, shallow DOF.
2. **0.65–0.85s** — muzzle flash: bright orange/white blast, heavy motion blur — pura frame "impact" me badal jata hai.
3. **0.85–2.3s** — Deadpool helicopter ke andar do haath se pistol aim karta hai; skylight se daylight + city.
4. **2.3–2.9s** — brass bullet casing slow-motion girta hua, red/blue bokeh.
5. **2.9s** — casing zameen par, near-black background.

**Tachnetique:** hook **object se shuru** hota hai (gun → flash → casing), character 1s ke baad aata hai. Seedha "character reveal" nahi — curiosity peak par character.

---

## BEAT MAP (measured cuts; ~= hard cut)
| Time | Shot / cluster | Technique |
|---|---|---|
| 0.00 | Gloved hand + pistol macro | ECU, cool teal grade |
| 0.65 | Muzzle flash | 1-frame blast, motion blur |
| 0.85 | Deadpool in helicopter, aiming | medium, daylight, red interior frame |
| 2.30 | Falling brass casing | slow-mo + bokeh |
| 2.90 | Casing on dark surface | macro, low-key |
| 2.97 | Deadpool street, katana up | medium-full, desaturated city |
| 4.05 | Tom Cruise tight close-up, gun | hard side light, dark interior |
| 4.45 | Bus/train confrontation | medium, **yellow poles** framing |
| 5.20 | Miles Morales leap | low angle, purple/blue comic grade |
| 6.20 | Spider-Man in glowing corridor | wide, lens flare right |
| 6.80 | Stairwell over-the-shoulder | OTS, natural light |
| 7.30 | Miles scream ECU | low angle, high contrast |
| 7.80 | Black-suited figure reaching | dark medium |
| 8.55 | Taxi/car flip | **golden-yellow cluster starts**, heavy motion blur |
| 9.37 | High-angle crash | golden tint, debris |
| 9.82 | Scream ECU, grime on face | golden grade, tight face |
| 10.17 | Spidey + Miles energy blast | pink/purple glow, mist |
| 10.40 | Miles venom-blast full body | pink glow, wide |
| 11.23 | Night police scene | OTS, street-lamp bloom, in-scene "POLICE" |
| 12.68 | Symbiote Spider-Man + tactical figure | wet pavement, green wall |
| 13.85 | Widow aiming gun | "DANGER" signs + red extinguishers in background |
| 14.35 | Futuristic pistol ECU | dark glass reflections, faint handle |
| 14.50 | Widow face close-up | soft dark background |
| 15.60 | Loki + Widow + third figure | golden palace interior, three-shot |
| 16.27 | Loki with staff, shouting | warm haze, medium |
| 16.50 | Hulk close-up | **progressive push-in** 16.5→17.5 |
| 18.00 | Loki static medium shot | **longest hold ~3.45s** — breath before storm |
| 21.45 | Loki turn/lunge | **motion-blur whip** starts |
| 21.90 | Hulk landing/lunge | motion blur, warm lights |
| 22.60 | Hulk crouch + strike | yellow/blue striped barrier in frame |
| 23.00 | Hulk fast blur / debris | speed smear |
| 23.50 | Dark fight + in-scene "Loki / #3" | chaotic close shot |
| 24.50 | **RAPID-FIRE CLUSTER STARTS** | ~0.25–0.8s cuts till 35.3s |
| 24.50–26.90 | Black Panther: blur → orange bokeh → claw insert → crouch → high kick → flying kick | cool steel + fire, sharp/slow-mo mix |
| 27.17 | Mug / hands close-up | rack focus, warm interior |
| 27.62 | Web-shooter hands ECU | tight texture shot |
| 28.00 | Panther mask ECU | red background, sharp detail |
| 28.28–29.37 | School hallway: Peter profile → OTS striped shirt → Spider-Man stance | golden lockers, rack focus |
| 29.37–31.83 | Blue-lit close-ups → purple bubble figure → hooded graffiti figure | cool blue/purple, composited bubbles |
| 31.83 | Warehouse clash | warm amber, **orange spark particles** |
| 32.50 | Fight, heavy blur | sparks continue |
| 33.00 | Heavy-bag punch | side medium, warm gym |
| 33.50–35.25 | Boxing gym wide, static — figure walks across left edge | 4 near-identical wide frames, "held tableau" |
| 35.30 | End card — **CUT OUT** | handle + ember particles, ignored |

---

## PACING (measured)
- **0–16s:** ~1 hard cut / 0.5–1.5s, har cut nayi shot/color. Micro-bursts of 2 frames bhi hote hain (same shot ke andar speed change).
- **16–18s:** push-in + ek slow reveal.
- **18–21.45s:** **ek hi static shot 3.45s** — deliberate slowdown; ye contrast agle rapid cluster ko aur tez banata hai.
- **21.45–24.5s:** motion-blur acceleration (three Hulk shots, blur badhta jata hai).
- **24.5–35.3s:** sabse tez — 14+ hard cuts in ~11s, average ~0.6s; kuch shots 0.25s (bokeh, blur) = "flash inserts".
- **Aakhir me static gym tableau (33.5–35.25)** — rapid-fire ke baad dobara hold = breath ↔ burst ↔ breath pattern.
- Koi dissolve/cross-fade nahi. **Hard cuts + motion-blur whip + speed smear** hi transition tools hain.

---

## TEXT OVERLAY TECHNIQUE
- **BILKUL KOI ADDED TEXT NAHI.** Pure footage edit.
- Jo text dikhtha hai wo scene ka physical hissa hai: `DANGER` signs, `POLICE` car, graffiti wall, heavy-bag patch, `Loki` + `#3` (in-scene graphic).
- Isliye template hamesha **clean** rehta hai — kisi doosre editor ke handle ya caption style ko copy karne ki zarurat nahi.
- Optional (apne version ke liye): agar text chahiye to sirf apna brand mark ek jagah, chhota, bottom safe-area me — source wala bottom-center band kabhi nahi.

---

## COLOR / GRADE CHOREOGRAPHY (SAVE KARNE LAYAK)
| Cluster | Grade | Purpose |
|---|---|---|
| Gun / Deadpool | dark teal + daylight mix | cold, tense opening |
| Spider-Verse | purple / blue, comic saturation | fantasy shift |
| Taxi crash | heavy golden-yellow | impact, heat |
| Energy blasts | pink / violet on mist | magical beat |
| Night police | blue-black + lamp bloom | noir beat |
| Widow / Loki | warm gold interior | prestige/drama |
| Hulk | natural green + warm lights | raw power |
| Panther | cool steel + orange fire | contrast within one cluster |
| School | golden lockers | mundane calm |
| Warehouse / gym | amber warm | grounded finale |

**Rule:** grade **cluster boundary par badlo**, shot ke beech nahi. Isse "chapters" bante hain bina text ke.

---

## EFFECTS TOOLKIT (SAVE KARNE LAYAK)
1. **Macro insert** (gun, casing, claws, mask, mug, web-shooter) — har action cluster ke andar 1 detail shot; ye "premium" feel deta hai aur pace bhi todta hai.
2. **Motion blur / speed smear** — blur ko *climax* ki tarah use karo: pehle sharp, phir blur, phir sharp (21.45–24.5 aur 24.5–26.9).
3. **Progressive push-in** — Hulk ke 3 frames me subtle zoom; slow build ka easiest trick.
4. **Bokeh flash insert** — 0.25s ka defocused orange light frame, akshar "transition pause" ki jagah.
5. **Particle accents** — sparks (warehouse), pink energy glow (Spider-Verse), ember (end card — hamare version me cut).
6. **Rack focus / OTS** — school hallway me foreground striped shirt + blurred subject; depth bina VFX ke.
7. **Lens flare / bloom** — corridor aur street-lamp shots me natural flare; color grade ke saath milta hai.
8. **Static tableau hold** — gym wide shot 4 baar near-identical, subject frame me move karta hai; "ending breath".

---

## AUDIO / BEAT SYNC
- RMS peaks measured at ~0.77, 2.90, 4.10, 4.93, 6.20, 8.70, 9.73, 11.78, 12.03, 14.08, 16.00, 18.11, 21.63, 22.91, 24.90, 25.66, 26.18, 27.20, 28.99, 29.25, 30.27, 31.81, 32.96, 33.79, 35.26s.
- Hard cuts in peaks ke ±0.15s me aate hain — especially 2.9, 4.0, 6.2, 8.55, 14.3, 16.2, 24.5, 25.25, 25.6, 26.0, 28.55, 30.1, 31.8, 35.25.
- Music-only source me transcription mat karo — Whisper hallucinate karta hai. **Waveform/RMS hi kaam ka hai.**

---

## EFFORT LEVEL
- **MEDIUM:** sourcing + beat-sync + per-cluster grading + motion blur. Koi 3D/CGI/VFX nahi, koi text animation nahi.
- Sabse zyada time clip selection aur cut placement me lagta hai, effects me nahi.

---

## REUSABLE TEMPLATE — "CHARACTER-BURST ACTION MONTAGE"
*Square 1:1 · 30–40s · music-led · no added text · no borrowed watermark*

```
0.0–2.0s   HOOK     macro object (2 shots) → impact flash → character first look
2.0–8.0s   CLUSTER 1  2–4 shots: detail → medium action → wide, one grade
8.0–13.0s  CLUSTER 2  grade badlo; motion blur peak; same internal shot order
13.0–18.0s CLUSTER 3  prestige/warm grade; 1 push-in shot
18.0–21.0s BREATH     one static hold, 3s (contrast ke liye zaroori)
21.0–24.0s ACCEL      blur badhate jao, 3 shots, peak par fire
24.0–33.0s RAPID      ~0.3–0.7s cuts; every cluster: 1 macro + 1 action + 1 flash insert
33.0–35.0s TABLEAU    static wide, subject cross kare, dobara breathe
35.0s+     END        apna clean end (ya seedha fade) — kisi ka handle nahi
```

**Cluster internal rule (har baar repeat karo):**
`macro/detail (0.3–0.5s) → medium action (0.5–1.0s) → wide/impact (0.3–0.6s) → optional blur flash (0.25s)`

**Watermark rule:** source ka handle bottom-center ho to `delogo` se hatao ya crop karo; end-card ko trim karo; apna mark sirf apne brand se lagao.

**What to save from this reel:** color-coded chapters, macro-to-action cluster rhythm, breath↔burst pacing, motion-blur acceleration, static tableau ending.
**What NOT to save:** editor watermark, handle name, end card, in-scene movie text ko overlay ki tarah copy karna.

---

## QUICK REFERENCE — 10 skills is video se
1. Cold open **object macro** se, character reveal 1s later.
2. **Character-burst** structure: 2–4 shots per character, phir switch.
3. Har cluster me **1 detail insert** — premium feel.
4. **Grade cluster boundary par badlo**, shot-to-shot nahi.
5. **Breath ↔ burst ↔ breath**: 3s static hold ke baad rapid cuts.
6. **Motion-blur acceleration** =FREE climax (3 shots, blur badhta jaye).
7. **Progressive push-in** 3 frames me = slow build.
8. **Flash insert** (bokeh/blur 0.25s) = transition bina dissolve ke.
9. **Static tableau hold** finale me = clean landing.
10. **Hard cuts + RMS peaks** = beat sync bina fancy plugins ke.

---

## CROSS-CHECK NOTE
- Vision: 7 broad contact sheets + 3 fine (4fps) sheets — saare tiles dekhe gaye.
- Cut detection: scene-score thresholds 0.4/0.5 + 20fps frame-diff peaks — table ke timings measurement hain, andaza nahi.
- Watermark: full-res crop + 3x zoom par verify; **name intentionally omitted**; cleanup command tested.
- Audio: RMS envelope 579 samples se peak extraction.
