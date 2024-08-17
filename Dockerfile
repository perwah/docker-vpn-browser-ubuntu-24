FROM ubuntu:noble

RUN apt-get update && \
  apt-get install -y curl sudo openvpn transmission pipewire libgtk-3-bin ubuntu-restricted-extras && \
  rm -rf /var/lib/apt/lists/*

# Enable sudo (needed by openvpn, unfortunately)
RUN echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
  chmod 0440 /etc/sudoers.d/ubuntu

USER ubuntu
ENV HOME=/home/ubuntu

ADD downloads/firefox*.bz2 $HOME
RUN mkdir $HOME/tmp
RUN mkdir -p /tmp/user.js.d/
COPY files/user.js.d/* /tmp/user.js.d/
RUN cat /tmp/user.js.d/* > $HOME/user.js
COPY files/start.sh $HOME
COPY files/start-openvpn-blocking.sh $HOME

ENTRYPOINT ["/bin/bash", "/home/ubuntu/start.sh"]
CMD ["firefox"]
