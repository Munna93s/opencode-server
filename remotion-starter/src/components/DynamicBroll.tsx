import { useCurrentFrame, interpolate, staticFile, Img, Video } from "remotion";

export type DynamicBrollProps = {
  /** Path relative to public/ (e.g. "assets/images/broll.jpg") */
  src: string;
  type?: "image" | "video";
  startFrame: number;
  endFrame: number;
  x?: number;
  y?: number;
  width?: number;
  height?: number;
  borderRadius?: number;
  shadow?: string;
  scale?: number;
  opacity?: number;
};

export const DynamicBroll = ({
  src,
  type = "image",
  startFrame,
  endFrame,
  x = 540,
  y = 100,
  width = 300,
  height = 300,
  borderRadius = 24,
  shadow = "0 20px 50px rgba(0, 0, 0, 0.55)",
  scale = 1,
  opacity = 1,
}: DynamicBrollProps) => {
  const frame = useCurrentFrame();

  if (frame < startFrame || frame > endFrame) return null;

  const progress = (frame - startFrame) / Math.max(endFrame - startFrame, 1);
  const clamped = Math.min(Math.max(progress, 0), 1);

  const fade = interpolate(
    clamped,
    [0, 0.12, 0.88, 1],
    [0, opacity, opacity, 0]
  );
  const s = interpolate(clamped, [0, 0.15, 1], [scale * 0.85, scale * 1.05, scale]);

  const mediaStyle: React.CSSProperties = {
    position: "absolute",
    left: x,
    top: y,
    width,
    height,
    borderRadius,
    boxShadow: shadow,
    overflow: "hidden",
    opacity: fade,
    transform: `translate(-50%, -50%) scale(${s})`,
    transformOrigin: "center",
    willChange: "transform, opacity",
  };

  const Media = type === "video" ? Video : Img;

  return <Media src={staticFile(src)} style={mediaStyle} />;
};
