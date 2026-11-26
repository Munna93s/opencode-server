import {
  OffthreadVideo,
  useCurrentFrame,
  interpolate,
  staticFile,
} from "remotion";

/**
 * CarReel — Instagram Reel (9:16, 1080x1920, 60 FPS, 8 seconds / 480 frames).
 *
 * Source: public/assets/videos/luxe-octane-ramped.mp4  (1440x2560 @ 60fps,
 * exactly 8.0s / 480 frames). This is `luxe-octane.mp4` (14.58s) with a
 * Remotion-friendly speed ramp baked in via ffmpeg:
 *   0.0s – 2.5s (Hook)    : 1.8x  (fast car entry)
 *   2.5s – 6.0s (Main)    : 0.7x  (ultra-smooth slow-mo, wheels/headlights)
 *   6.0s – 8.0s (Loop Exit): 2.0x  (fast exit, seamless loop back to 0s)
 *
 * Because Remotion v4's OffthreadVideo does not advance its playhead when a
 * component mounts mid-composition with `trimBefore`, the ramp is applied once
 * upstream (ffmpeg) and played here as a single video from frame 0. This keeps
 * the speed ramp seamless across all 480 frames while preserving every other
 * Remotion setting below.
 */
export const FPS = 60;
export const DURATION_IN_SECONDS = 8;
export const DURATION_IN_FRAMES = DURATION_IN_SECONDS * FPS; // 480

export const WIDTH = 1080;
export const HEIGHT = 1920;

const REEL_VIDEO = staticFile("assets/videos/luxe-octane-ramped.mp4");

const fillAndGrade: React.CSSProperties = {
  position: "absolute",
  top: 0,
  left: 0,
  width: "100%",
  height: "100%",
  objectFit: "cover",
  // Dark & moody grade: lifts contrast, drops brightness, boosts saturation
  // so the red car pops against the twilight highway.
  filter: "contrast(1.18) brightness(0.85) saturate(1.15)",
  transformOrigin: "center",
};

export const CarReel = () => {
  const frame = useCurrentFrame();

  // Slow digital zoom-in: 1.00 -> 1.08 across the 8s reel for a dynamic
  // feel (scales into the frame; edges are covered by objectFit cover).
  const scale = interpolate(frame, [0, DURATION_IN_FRAMES], [1.0, 1.08]);

  const videoStyle: React.CSSProperties = {
    ...fillAndGrade,
    transform: `scale(${scale})`,
  };

  return (
    <div
      style={{
        width: WIDTH,
        height: HEIGHT,
        background: "#050507",
        overflow: "hidden",
      }}
    >
      {/* Main video — single pre-ramped clip, played from frame 0. */}
      <OffthreadVideo
        src={REEL_VIDEO}
        trimBefore={0}
        durationInFrames={DURATION_IN_FRAMES}
        playbackRate={1}
        style={videoStyle}
      />

      {/* Vignette overlay — dark cinematic top / bottom look. */}
      <div
        style={{
          position: "absolute",
          top: 0,
          left: 0,
          width: "100%",
          height: "100%",
          background:
            "radial-gradient(circle, transparent 50%, rgba(0,0,0,0.65) 100%)",
          pointerEvents: "none",
        }}
      />
    </div>
  );
};

export default CarReel;
