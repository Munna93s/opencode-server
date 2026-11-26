import {
  Composition,
  Video,
  Audio,
  useCurrentFrame,
  interpolate,
  staticFile,
} from "remotion";

export const FPS = 30;
export const DURATION_IN_SECONDS = 8.5;
export const DURATION_IN_FRAMES = Math.round(DURATION_IN_SECONDS * FPS); // 255 frames

const DRIFT_VIDEO = staticFile("assets/videos/drift-reel.mp4");

const fillStyle: React.CSSProperties = {
  position: "absolute",
  top: 0,
  left: 0,
  width: "100%",
  height: "100%",
  objectFit: "cover",
};

export const DriftReel = () => {
  const frame = useCurrentFrame();

  // Beat drop / slow-mo start at 2.0s -> frame 60
  const beatDropFrame = 2 * FPS;
  const shakeWindow = 12;

  // Camera shake: ramps up to peak at beat drop, then decays
  const shake = interpolate(
    frame,
    [beatDropFrame - shakeWindow, beatDropFrame, beatDropFrame + shakeWindow],
    [0, 14, 0]
  );

  // Energy scale pulse at beat drop
  const scale = interpolate(
    frame,
    [beatDropFrame - 4, beatDropFrame, beatDropFrame + 8],
    [1.04, 1.10, 1.04]
  );

  // White flash at beat drop (frame 60), decays quickly
  const flashOpacity = interpolate(
    frame,
    [beatDropFrame - 2, beatDropFrame, beatDropFrame + 6],
    [0, 1, 0]
  );

  // Text hook pop animation: enters 0.0-0.6s, holds, fades after 7.0s
  const hookScale = interpolate(
    frame,
    [0, 18, 210, 240],
    [0, 1, 1, 0],
    { clamp: false }
  );
  const hookOpacity = interpolate(
    frame,
    [0, 18, 210, 240],
    [0, 1, 1, 0]
  );

  const videoStyle: React.CSSProperties = {
    ...fillStyle,
    transform: `translate(${shake}px, ${shake}px) scale(${scale})`,
  };

  return (
    <div
      style={{
        width: 1080,
        height: 1920,
        background: "#050507",
        overflow: "hidden",
      }}
    >
      {/* Main drift video (color-graded upstream; scaled slightly for shake padding) */}
      <Video src={DRIFT_VIDEO} style={videoStyle} />

      {/* Background audio bed (loop.m4a). Specific beat-drop tracks
          ("SLAY! - Eternxlkz", "Montagem Mysterious Game", "Metamorphosis (Slowed)")
          were not provided as files — swap src to your chosen track and time
          its beat drop to frame 60 (2.0s). */}
      <Audio src={staticFile("assets/audio/loop.m4a")} from={0} play volume={0.45} />

      {/* Beat-drop camera shake is applied via the video transform above */}
      {/* White flash at slow-mo start (2.0s) */}
      <div
        style={{
          ...fillStyle,
          background: "#ffffff",
          opacity: flashOpacity,
          pointerEvents: "none",
        }}
      />

      {/* Text hook — centered, bold, glowing */}
      <div
        style={{
          ...fillStyle,
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          pointerEvents: "none",
        }}
      >
        <div
          style={{
            transform: `scale(${hookScale})`,
            opacity: hookOpacity,
            filter: "drop-shadow(0 0 14px rgba(255,60,60,0.9))",
            transition: "all 0.2s ease",
          }}
        >
          <div
            style={{
              fontFamily: "system-ui, -apple-system, sans-serif",
              fontWeight: 900,
              fontSize: 78,
              lineHeight: 1,
              color: "#ffffff",
              textTransform: "uppercase",
              letterSpacing: -2,
              textAlign: "center",
              textShadow:
                "0 0 24px rgba(255, 60, 60, 0.7), 0 2px 0 #000000",
            }}
          >
            RED CAR
          </div>
          <div
            style={{
              fontWeight: 900,
              fontSize: 78,
              lineHeight: 1,
              color: "#ff3b3b",
              textTransform: "uppercase",
              letterSpacing: -2,
              textAlign: "center",
              marginTop: -10,
              textShadow: "0 0 24px rgba(255, 59, 59, 0.8)",
            }}
          >
            DRIFT
          </div>
        </div>

        {/* Sub hook */}
        <div
          style={{
            transform: `scale(${hookScale})`,
            opacity: hookOpacity,
            marginTop: 28,
            fontFamily: "system-ui, -apple-system, sans-serif",
            fontWeight: 700,
            fontSize: 26,
            color: "#ffd700",
            textTransform: "uppercase",
            letterSpacing: 2,
            textAlign: "center",
            textShadow: "0 0 16px rgba(255, 215, 0, 0.6)",
          }}
        >
          लाल कार का ड्रिफ्ट • 9:16 Reel
        </div>

        {/* Beat label at slow-mo start */}
        <div
          style={{
            position: "absolute",
            bottom: 120,
            left: 0,
            right: 0,
            textAlign: "center",
            fontFamily: "system-ui, -apple-system, sans-serif",
            fontWeight: 700,
            fontSize: 20,
            color: "#ffffff",
            opacity: interpolate(frame, [beatDropFrame - 8, beatDropFrame, beatDropFrame + 20], [0, 1, 0]),
            letterSpacing: 4,
            textTransform: "uppercase",
            textShadow: "0 0 20px rgba(255, 255, 255, 0.6)",
          }}
        >
          SLOW-MO DROP
        </div>
      </div>
    </div>
  );
};

export const DriftReelComp = () => (
  <Composition
    id="DriftReel"
    component={DriftReel}
    durationInFrames={DURATION_IN_FRAMES}
    fps={FPS}
    width={1080}
    height={1920}
  />
);
