import { useCurrentFrame, interpolate } from "remotion";

export type SmoothZoomProps = {
  children: React.ReactNode;
  /** Max punch-in zoom factor */
  zoom?: number;
  /** Frames over which to punch in (zoom 1 -> zoom) */
  punchIn?: { start: number; end: number };
  /** Frames over which to punch out (zoom -> 1) */
  punchOut?: { start: number; end: number };
  /** Add a handheld camera shake while zoomed in */
  shake?: boolean;
  shakeIntensity?: number;
  shakeFrequency?: number;
};

export const SmoothZoom = ({
  children,
  zoom = 1.4,
  punchIn,
  punchOut,
  shake = true,
  shakeIntensity = 10,
  shakeFrequency = 0.45,
}: SmoothZoomProps) => {
  const frame = useCurrentFrame();

  let scale = 1;
  if (punchIn) {
    scale = interpolate(
      frame,
      [punchIn.start, punchIn.end],
      [1, zoom],
      { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
    );
  }
  if (punchOut && frame >= punchOut.start) {
    scale = interpolate(
      frame,
      [punchOut.start, punchOut.end],
      [zoom, 1],
      { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
    );
  }

  let tx = 0;
  let ty = 0;
  if (shake && scale > 1.01) {
    tx =
      Math.sin(frame * shakeFrequency) *
      shakeIntensity *
      Math.abs(Math.sin(frame * 0.11));
    ty =
      Math.cos(frame * shakeFrequency * 0.7) *
      shakeIntensity *
      Math.abs(Math.sin(frame * 0.17));
  }

  return (
    <div
      style={{
        transform: `scale(${scale}) translate(${tx}px, ${ty}px)`,
        transformOrigin: "center center",
        willChange: "transform",
      }}
    >
      {children}
    </div>
  );
};
