#!/bin/bash

docker run \
    -v /tmp/.X11-unix:/tmp/.X11=unix \
    -v /home/danilo/.Xauthority:/root/.Xauthority \
    --net=host \
    -e DISPLAY \
    $@
