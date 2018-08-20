#!/bin/bash
set -eux
docker run -ti --rm -e DISPLAY \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v `pwd`/openvpn:/etc/openvpn \
  -v `pwd`/dbip:/home/user/dbip \
  -e ASSERT_COUNTRY \
  --dns 1.1.1.1 \
  docker-vpn-browser
