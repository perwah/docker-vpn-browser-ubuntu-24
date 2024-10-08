#!/bin/bash
set -e
COMMAND="$1"
echo "$COMMAND"

sudo chown ubuntu:ubuntu $HOME/Downloads

OPENVPN_CONF='/etc/openvpn/openvpn.conf'
if [ -f "$OPENVPN_CONF" ]; then
  "$HOME/start-openvpn-blocking.sh" "$OPENVPN_CONF"
else
  echo "no OpenVPN config"
fi

# revoke sudo privileges after OpenVPN start
sudo rm /etc/sudoers.d/ubuntu

if [ ! -z ${ASSERT_COUNTRY+x} ]; then
  IP_COUNTRY=`curl ifconfig.co/country`
  echo " ---------------------------------------------------------------"
  echo "      The IP of this container seems to be in $IP_COUNTRY"
  echo " ---------------------------------------------------------------"
  if [ "$IP_COUNTRY" != "$ASSERT_COUNTRY" ]; then
    echo "*** does not match $ASSERT_COUNTRY ***"
    exit 1
  fi
fi

# If no profile ...
if [ $COMMAND == "firefox" ]; then
  # create the default Firefox profile and put some settings there
  COMMAND="$HOME/firefox/firefox"
  $COMMAND &
  FIREFOX_PID=$!
  # Since some recent Firefox version, calling CreateProfile and copying
  # user.js stopped working on the first use for reasons I could not find on
  # Google and do not frankly care about. This is the workaround
  set +e
  while [ `find $HOME/.mozilla/firefox -type f | grep prefs.js | wc -l` == "0" ];
  do
    echo "... waiting for Firefox to start the first time"
    sleep 1
  done
  set -e
  echo "killing Firefox and copying settings"
  kill $FIREFOX_PID
  mv $HOME/user.js `find $HOME/.mozilla/firefox -maxdepth 1 -type d | grep .default-release`

  if [ -e "$HOME/tmp/pipewire-0" ]; then
    # Start audio
    # We assume host is running pipewire with a unix socket mapped in by -v /run/user/1000/pipewire-0:$USERHOME/tmp/pipewire-0
    echo "Pipewire socket found at $HOME/tmp/pipewire-0, starting audio."
    pipewire-pulse &
  else
    echo "Pipewire socket not found at $HOME/tmp/pipewire-0, not starting audio."
  fi
fi

$COMMAND
