#!/bin/bash

export USERHOME=/home/ubuntu

set -eux
docker run -ti --rm -e DISPLAY \
  --cap-add=NET_ADMIN --device /dev/net/tun \
  --shm-size 256M \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /run/user/1000/pipewire-0:$USERHOME/tmp/pipewire-0 \
  -v `pwd`/openvpn:/etc/openvpn \
  -v `pwd`/shared:$USERHOME/Downloads \
  -e XDG_RUNTIME_DIR=$USERHOME/tmp \
  -e ASSERT_COUNTRY \
  --name docker-vpn-browser-container \
  --dns 1.1.1.1 \
  docker-vpn-browser-ubuntu-24 \
  "$@"
