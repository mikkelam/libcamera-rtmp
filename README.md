# 📹 libcamera-rtmp

A simple yet powerful script for streaming video from Raspberry Pi cameras to RTMP servers using libcamera and ffmpeg.

Currently does not provide audio support.

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

Dependencies on Raspberry pi BullsEye:
```bash
sudo apt-get update
sudo apt-get install -y libcamera-apps ffmpeg
```

Oneliner:
```bash
curl -sSL https://raw.githubusercontent.com/mikkelam/libcamera-rtmp/main/libcamera-rtmp.sh -o libcamera-rtmp.sh && chmod +x libcamera-rtmp.sh && ./libcamera-rtmp.sh --help
```

Normal:
```bash
git clone https://github.com/mikkelam/libcamera-rtmp.git
cd libcamera-rtmp
chmod +x libcamera-rtmp
```

## Usage

Basic usage:

```bash
./libcamera-rtmp --url rtmp://your-streaming-url
```

With custom settings:

```bash
./libcamera-rtmp --url rtmp://your-streaming-url --width 1280 --height 720 --framerate 30 --bitrate 3000000
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

## Why not not just use libcamera-vid?
Youtube requires an audio source. This is a workaround to add a silent audio track automatically.

If you have an audio source, you can use libcamera-vid directly.

## License

MIT
