import { useCurrentFrame, interpolate } from "remotion";

export type TextAnimation = "slide-in" | "bounce" | "pop" | "fade";

export type TrendyTextOverlayProps = {
  text: string;
  animation?: TextAnimation;
  startFrame: number;
  endFrame: number;
  x?: number;
  y?: number;
  fontSize?: number;
  color?: string;
  strokeColor?: string;
  strokeWidth?: number;
  align?: "center" | "left" | "right";
  fontWeight?: number;
  lowercase?: boolean;
};

export const TrendyTextOverlay = ({
  text,
  animation = "pop",
  startFrame,
  endFrame,
  x = 540,
  y = 200,
  fontSize = 60,
  color = "#FFFFFF",
  strokeColor = "#000000",
  strokeWidth = 4,
  align = "center",
  fontWeight = 800,
  lowercase = false,
}: TrendyTextOverlayProps) => {
  const frame = useCurrentFrame();

  if (frame < startFrame || frame > endFrame) return null;

  const progress = (frame - startFrame) / Math.max(endFrame - startFrame, 1);
  const clamped = Math.min(Math.max(progress, 0), 1);

  let opacity = 1;
  let scale = 1;
  let translateY = 0;
  let translateX = 0;

  if (animation === "slide-in") {
    opacity = interpolate(clamped, [0, 0.15, 1], [0, 0, 1]);
    translateY = interpolate(clamped, [0, 0.2, 1], [80, 0, 0]);
    translateX = interpolate(clamped, [0, 0.25, 1], [-140, 0, 0]);
  } else if (animation === "bounce") {
    scale = interpolate(clamped, [0, 0.3, 0.6, 1], [0, 1.35, 1, 1]);
    opacity = interpolate(clamped, [0, 0.2, 1], [0, 1, 1]);
  } else if (animation === "pop") {
    scale = interpolate(clamped, [0, 0.25, 1], [0.55, 1.2, 1]);
    opacity = interpolate(clamped, [0, 0.15, 1], [0, 1, 1]);
  } else {
    opacity = interpolate(clamped, [0, 0.3, 1], [0, 1, 1]);
  }

  return (
    <div
      style={{
        position: "absolute",
        left: x,
        top: y,
        transform: `translate(-50%, -50%) scale(${scale}) translate(${translateX}px, ${translateY}px)`,
        transformOrigin: "center",
        opacity,
        textAlign: align,
        willChange: "transform, opacity",
      }}
    >
      <div
        style={{
          display: "inline-block",
          fontSize,
          fontWeight,
          color,
          WebkitTextStroke: `${strokeWidth}px ${strokeColor}`,
          textTransform: lowercase ? "lowercase" : "none",
          fontFamily:
            '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif',
          lineHeight: 1.25,
          padding: "8px 16px",
          borderRadius: 12,
          background: "rgba(0, 0, 0, 0.4)",
        }}
      >
        {text}
      </div>
    </div>
  );
};
