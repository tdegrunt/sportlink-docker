#! /usr/bin/env bash

# make sure we're in the right dir
cd "$( dirname "${BASH_SOURCE[0]}" )" || exit 2

xhost +localhost

docker run --rm --net=host -e DISPLAY=host.docker.internal:0 \
  --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
  --volume="$(pwd)/config:/home/sportlink/.config/icedtea-web" \
  --volume="$(pwd)/cache:/home/sportlink/.cache/icedtea-web" \
  sportlink-knvb:1.0