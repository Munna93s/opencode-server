import {
  Composition,
  Img,
  Video,
  Solid,
  useCurrentFrame,
  interpolate,
  staticFile,
} from "remotion";
import { HormoziCaptions } from "./components/HormoziCaptions";
import { SmoothZoom } from "./components/SmoothZoom";
import { TrendyTextOverlay } from "./components/TrendyTextOverlay";
import { DynamicBroll } from "./components/DynamicBroll";
import { DriftReelComp } from "./components/DriftReel";
import { CarReel, WIDTH as CAR_REEL_WIDTH, HEIGHT as CAR_REEL_HEIGHT } from "./components/CarReel";

export const FPS = 30;
export const DURATION_IN_FRAMES = 300; // 10 seconds

// LuxeOctaneReel — Instagram Reel: 60 FPS, 8s = 480 frames, 1080x1920 (9:16)
export const LUXE_FPS = 60;
export const LUXE_DURATION_IN_FRAMES = 480;

const REELS_VIDEO = staticFile("assets/videos/reels-background.mp4");
const YT_VIDEO = staticFile("assets/videos/youtube-background.mp4");
const BROLL_IMG = staticFile("assets/images/broll.jpg");

const DEMO_CAPTIONS = [
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

export const ReelsTemplate = () => (
  <Composition
    id="ReelsTemplate"
    component={Reels}
    durationInFrames={DURATION_IN_FRAMES}
    fps={FPS}
    width={1080}
    height={1920}
  />
);

export const YouTubeTemplate = () => (
  <Composition
    id="YouTubeTemplate"
    component={YouTube}
    durationInFrames={DURATION_IN_FRAMES}
    fps={FPS}
    width={1920}
    height={1080}
  />
);

export const LuxeOctaneReel = () => (
  <Composition
    id="LuxeOctaneReel"
    component={CarReel}
    durationInFrames={LUXE_DURATION_IN_FRAMES}
    fps={LUXE_FPS}
    width={CAR_REEL_WIDTH}
    height={CAR_REEL_HEIGHT}
  />
);

/** Root rendered by Remotion Studio — exposes all templates. */
export const Root = () => (
  <>
    <ReelsTemplate />
    <YouTubeTemplate />
    <DriftReelComp />
    <LuxeOctaneReel />
  </>
);

export { DriftReelComp };

const fillStyle: React.CSSProperties = {
  position: "absolute",
  top: 0,
  left: 0,
  width: "100%",
  height: "100%",
  objectFit: "cover",
};

const Reels = () => (
  <div
    style={{
      width: 1080,
      height: 1920,
      background: "#0b0b0f",
      overflow: "hidden",
    }}
  >
    {/* Background layer */}
    <Video src={REELS_VIDEO} style={fillStyle} />

    {/* Main video with CapCut-style punch-in zoom + camera shake */}
    <SmoothZoom zoom={1.35} punchIn={{ start: 0, end: 70 }} shake shakeIntensity={7}>
      <Video src={REELS_VIDEO} style={fillStyle} />
    </SmoothZoom>

    {/* B-roll overlay with rounded corners + shadow */}
    <DynamicBroll
      src={BROLL_IMG}
      type="image"
      startFrame={90}
      endFrame={240}
      x={540}
      y={420}
      width={300}
      height={300}
      borderRadius={28}
      shadow="0 24px 60px rgba(0,0,0,0.65)"
    />

    {/* Trendy title overlays */}
    <TrendyTextOverlay
      text="CAPCUT STYLE"
      animation="pop"
      startFrame={0}
      endFrame={50}
      x={540}
      y={270}
      fontSize={74}
      color="#FFD700"
    />
    <TrendyTextOverlay
      text="Reels • 1080×1920 • 30fps"
      animation="slide-in"
      startFrame={70}
      endFrame={130}
      x={540}
      y={350}
      fontSize={38}
      color="#FFFFFF"
    />

    {/* Word-by-word Hormozi captions (built with @remotion/captions) */}
    <HormoziCaptions
      captions={DEMO_CAPTIONS}
      fontSize={60}
      x={540}
      y={1500}
      maxWidth={960}
    />
  </div>
);

const YouTube = () => (
  <div
    style={{
      width: 1920,
      height: 1080,
      background: "#0b0b0f",
      overflow: "hidden",
    }}
  >
    {/* Background layer */}
    <Video src={YT_VIDEO} style={fillStyle} />

    {/* Main video with smooth punch-in (no shake for cinematic look) */}
    <SmoothZoom zoom={1.25} punchIn={{ start: 0, end: 90 }} shake={false}>
      <Video src={YT_VIDEO} style={fillStyle} />
    </SmoothZoom>

    {/* B-roll overlay */}
    <DynamicBroll
      src={BROLL_IMG}
      type="image"
      startFrame={120}
      endFrame={270}
      x={1420}
      y={260}
      width={440}
      height={440}
      borderRadius={34}
      shadow="0 30px 70px rgba(0,0,0,0.65)"
    />

    {/* Trendy title overlays */}
    <TrendyTextOverlay
      text="YOUTUBE TEMPLATE"
      animation="bounce"
      startFrame={0}
      endFrame={70}
      x={960}
      y={190}
      fontSize={84}
      color="#FFFFFF"
    />
    <TrendyTextOverlay
      text="1920×1080 • 30fps • CapCut Style"
      animation="slide-in"
      startFrame={90}
      endFrame={160}
      x={960}
      y={300}
      fontSize={48}
      color="#FFD700"
    />

    {/* Word-by-word Hormozi captions */}
    <HormoziCaptions
      captions={DEMO_CAPTIONS}
      fontSize={66}
      x={960}
      y={940}
      maxWidth={1640}
    />
  </div>
);
