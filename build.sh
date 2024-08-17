#!/bin/bash

# Download firefox into files directory if it's not there already
export version="129.0.1"
export filename="firefox-$version.tar.bz2"
export url="https://download-installer.cdn.mozilla.net/pub/firefox/releases/$version/linux-x86_64/en-US/$filename"
mkdir -p downloads

if [ "`find downloads -name $filename | wc -l`" != "1" ]; then
  rm downloads/firefox*.bz2
  curl -L "$url" --output downloads/$filename
fi

docker build -t docker-vpn-browser-ubuntu-24 .
