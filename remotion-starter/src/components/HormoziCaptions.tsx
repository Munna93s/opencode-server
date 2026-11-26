import { useCurrentFrame, interpolate } from "remotion";
import {
  createTikTokStyleCaptions,
  type Caption,
} from "@remotion/captions";

export type HormoziCaptionsProps = {
  /** Word-level caption data (startMs/endMs in milliseconds) */
  captions?: Caption[];
  fontSize?: number;
  /** Dimmed color for inactive words */
  inactiveColor?: string;
  /** Text color for the active word */
  activeTextColor?: string;
  /** Pill background color for the active word */
  highlightColor?: string;
  strokeColor?: string;
  strokeWidth?: number;
  /** Merge tokens closer than this many ms into one visual group */
  combineWithinMs?: number;
  x?: number;
  y?: number;
  maxWidth?: number;
  lineHeight?: number;
  fps?: number;
};

const DEMO_CAPTIONS: Caption[] = [
  { text: "This", startMs: 600, endMs: 1000, timestampMs: null, confidence: null },
  { text: "is", startMs: 1000, endMs: 1300, timestampMs: null, confidence: null },
  { text: "a", startMs: 1300, endMs: 1550, timestampMs: null, confidence: null },
  { text: "CapCut", startMs: 1550, endMs: 2100, timestampMs: null, confidence: null },
  { text: "style", startMs: 2100, endMs: 2700, timestampMs: null, confidence: null },
  { text: "Hormozi", startMs: 2700, endMs: 3300, timestampMs: null, confidence: null },
  { text: "caption", startMs: 3300, endMs: 4100, timestampMs: null, confidence: null },
  { text: "with", startMs: 4100, endMs: 4550, timestampMs: null, confidence: null },
  { text: "pop-up", startMs: 4550, endMs: 5200, timestampMs: null, confidence: null },
  { text: "animation!", startMs: 5200, endMs: 6100, timestampMs: null, confidence: null },
  { text: "Watch", startMs: 6100, endMs: 6600, timestampMs: null, confidence: null },
  { text: "the", startMs: 6600, endMs: 7000, timestampMs: null, confidence: null },
  { text: "active", startMs: 7000, endMs: 7550, timestampMs: null, confidence: null },
  { text: "word", startMs: 7550, endMs: 8100, timestampMs: null, confidence: null },
  { text: "glow.", startMs: 8100, endMs: 8800, timestampMs: null, confidence: null },
];

export const HormoziCaptions = ({
  captions = DEMO_CAPTIONS,
  fontSize = 64,
  inactiveColor = "rgba(255, 255, 255, 0.3)",
  activeTextColor = "#FFD700",
  highlightColor = "#00E676",
  strokeColor = "#000000",
  strokeWidth = 5,
  combineWithinMs = 120,
  x = 540,
  y = 1480,
  maxWidth = 960,
  lineHeight = 1.05,
  fps = 30,
}: HormoziCaptionsProps) => {
  const frame = useCurrentFrame();
  const currentMs = (frame / fps) * 1000;

  const pages = createTikTokStyleCaptions({
    captions,
    combineTokensWithinMilliseconds: combineWithinMs,
  }).pages;

  const activePageIndex = pages.findIndex(
    (p) => currentMs >= p.startMs && currentMs <= p.startMs + p.durationMs
  );

  if (activePageIndex < 0) return null;

  const page = pages[activePageIndex];
  const pageProgress = Math.min(
    Math.max((currentMs - page.startMs) / Math.max(page.durationMs, 1), 0),
    1
  );

  return (
    <div
      style={{
        position: "absolute",
        left: x,
        top: y,
        width: maxWidth,
        textAlign: "center",
        lineHeight,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        pointerEvents: "none",
      }}
    >
      <div
        style={{
          display: "inline-block",
          transform: `scale(${interpolate(pageProgress, [0, 1], [0.9, 1])})`,
          transformOrigin: "center",
        }}
      >
        {page.tokens.map((token, index) => {
          const tokenDuration = Math.max(token.toMs - token.fromMs, 1);
          const tokenProgress = Math.min(
            Math.max((currentMs - token.fromMs) / tokenDuration, 0),
            1
          );
          const isActive =
            currentMs >= token.fromMs && currentMs <= token.toMs;

          // Pop-up animation: 1 -> 1.35 -> 1 across the word's lifetime
          const scale = interpolate(tokenProgress, [0, 0.35, 1], [
            1,
            1.35,
            1,
          ]);
          const opacity = interpolate(tokenProgress, [0, 0.2, 1], [0.45, 1, 1]);

          return (
            <span
              key={index}
              style={{
                display: "inline-block",
                margin: "3px 5px",
                fontSize,
                fontWeight: "900",
                fontFamily:
                  '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif',
                color: isActive ? activeTextColor : inactiveColor,
                WebkitTextStroke: `${strokeWidth}px ${strokeColor}`,
                opacity,
                transform: `scale(${scale})`,
                transformOrigin: "center",
                filter: isActive
                  ? `drop-shadow(0 0 14px ${highlightColor})`
                  : "none",
                ...(isActive
                  ? {
                      background: highlightColor,
                      padding: "4px 10px",
                      borderRadius: "10px",
                      boxShadow: `0 0 24px ${highlightColor}`,
                    }
                  : {}),
              }}
            >
              {token.text}
            </span>
          );
        })}
      </div>
    </div>
  );
};
