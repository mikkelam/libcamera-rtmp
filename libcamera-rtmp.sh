#!/bin/bash
# --- 📹 libcamera-rtmp streaming script 📹 ---

# Default settings
WIDTH=1920
HEIGHT=1080
FRAMERATE=30
BITRATE=4800000
URL=""


set -e
set -o pipefail

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --url|-u) URL="$2"; shift 2 ;;
    --width|-w) WIDTH="$2"; shift 2 ;;
    --height|-h) HEIGHT="$2"; shift 2 ;;
    --framerate|-f) FRAMERATE="$2"; shift 2 ;;
    --bitrate|-b) BITRATE="$2"; shift 2 ;;
    --help)
      echo "📋 Usage: $0 [options] --url RTMP_URL"
      echo "Options:"
      echo "  --url, -u URL        🔗 RTMP(S) streaming URL (required)"
      echo "  --width, -w WIDTH    📐 Video width (default: 1920)"
      echo "  --height, -h HEIGHT  📏 Video height (default: 1080)"
      echo "  --framerate, -f FPS  ⏱️  Framerate (default: 30)"
      echo "  --bitrate, -b BPS    📊 Video bitrate (default: 4800000)"
      exit 0
      ;;
    *) echo "❌ Unknown parameter: $1"; exit 1 ;;
  esac
done

# Validate required parameters
if [ -z "$URL" ]; then
  echo "❌ Error: RTMP URL is required"
  echo "📋 Usage: $0 --url RTMP_URL [options]"
  exit 1
fi


echo "🔗 Streaming to: $URL"
echo "🎬 Resolution: ${WIDTH}x${HEIGHT} @ ${FRAMERATE}fps"
echo "🔍 Verifying camera capabilities..."
rpicam-vid --list-cameras || exit 1
ffmpeg --version || exit 1
echo "🚀 Starting video stream... Press Ctrl+C to stop"

rpicam-vid \
    -t 0 \
    --width $WIDTH \
    --height $HEIGHT \
    --framerate $FRAMERATE \
    --codec libav \
    --libav-video-codec h264_v4l2m2m \
    --libav-format h264 \
    -b $BITRATE \
    -g $(($FRAMERATE * 2)) \
    --profile high \
    --level 4.1 \
    --inline \
    --nopreview \
    -o - \
| ffmpeg \
    -hide_banner \
    -loglevel warning \
    -fflags +genpts \
    -r $FRAMERATE \
    -f h264 \
    -analyzeduration 2M \
    -probesize 1M \
    -i - \
    -f lavfi \
    -i anullsrc=channel_layout=stereo:sample_rate=44100 \
    -map 0:v \
    -map 1:a \
    -c:v copy \
    -c:a aac \
    -b:a 128k \
    -flags +global_header \
    -f flv \
    "$URL"

echo "🏁 Stream ended."
