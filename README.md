# Docker VPN browser
Fork of https://github.com/oseiskar/docker-vpn-browser

Run Firefox and an OpenVPN client inside a Docker container. Firefox starts
without any cookies, history or such, and has audio on Ubuntu 24.04.

### Usage

 0. Install Docker (v. 1.12 or above, I think)
 1. Build Docker image: `./build.sh`
 2. (optional) Create a directory `openvpn` and put your `openvpn.conf` there.
    Make sure it's called `openvpn.conf` and all extra files it may need are
    also in the `openvpn/` directory (this will be mounted in the container).
    Files referenced from within openvpn.conf (such as login.conf) must be preceded with `/etc/openvpn/`
 3. Start container `./run.sh firefox`

Also `ASSERT_COUNTRY=Finland ./run.sh firefox` to check that ifconfig.co thinks
that the your IP address is in a given country before starting Firefox.
Be aware that different IP geolocation services can report different countries for your VPN ip address.

### Disclaimer

We can be quite sure that this will stop working (or being even remotely safe
to run) in about 1 to 2 years after the latest commit to this repository.
