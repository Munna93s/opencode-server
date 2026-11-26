import { Config } from "@remotion/cli/config";

/**
 * Instagram Reel render settings — composition "LuxeOctaneReel".
 *
 * Tuned to survive Instagram's re-compression while keeping the file
 * size reasonable for a 9:16 Reel.
 *
 * - Codec:      h264 (widest device / Instagram compatibility)
 * - Pixel fmt:  yuv420p (required for broad player support)
 * - CRF:        18 (near visually lossless; 16-18 is the sweet spot
 *                 between quality and file size)
 * - Frames:     JPEG image sequence before stitching
 */
Config.setCodec("h264");
Config.setPixelFormat("yuv420p");
Config.setCrf(18);
Config.setVideoImageFormat("jpeg");
