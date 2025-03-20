#! /usr/bin/env bash

# make sure we're in the right dir
cd "$( dirname "${BASH_SOURCE[0]}" )" || exit 2

# https://github.com/XQuartz/XQuartz/issues/31
defaults write org.xquartz.X11 enable_render_extension 0
xhost +localhost

# docker build --tag sportlink-knvb:1.0 .
# For Apple Mx architecture
docker buildx build --platform linux/amd64 --tag sportlink-knvb:1.0 .

docker run --rm --net=host -e DISPLAY=host.docker.internal:0 \
  --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
  --volume="$(pwd)/config:/home/sportlink/.config/icedtea-web" \
  --volume="$(pwd)/cache:/home/sportlink/.cache/icedtea-web" \
  --volume="$(pwd)/files:/home/sportlink/files" \
  sportlink-knvb:1.0
