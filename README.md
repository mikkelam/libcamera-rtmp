# 📹 libcamera-rtmp

A simple yet powerful script for streaming video from Raspberry Pi cameras to RTMP servers using libcamera and ffmpeg.

## Features

- Stream directly to YouTube, Twitch, Facebook Live or any RTMP(S) server
- Hardware-accelerated H.264 encoding
- Configurable video resolution, framerate and bitrate
- Silent audio track automatically added (required by many streaming platforms)

Mainly tested on youtube

## Requirements

- Raspberry Pi (tested on Pi 4 and newer)
- Raspberry Pi OS Bullseye or newer
- libcamera-apps for `rpicam-vid` NOT `libcamera-apps-lite`
- ffmpeg

## Installation

```bash
git clone https://github.com/yourusername/libcamera-rtmp.git
cd libcamera-rtmp
chmod +x rtmp.sh
```

## Usage

Basic usage:

```bash
./rtmp.sh --url rtmp://your-streaming-url
```

With custom settings:

```bash
./rtmp.sh --url rtmp://your-streaming-url --width 1280 --height 720 --framerate 30 --bitrate 3000000
```

### Options

```
--url, -u URL        🔗 RTMP(S) streaming URL (required)
--width, -w WIDTH    📐 Video width (default: 1920)
--height, -h HEIGHT  📏 Video height (default: 1080)
--framerate, -f FPS  ⏱️  Framerate (default: 30)
--bitrate, -b BPS    📊 Video bitrate (default: 4800000)
--help               📋 Show help message
```

## License

MIT
