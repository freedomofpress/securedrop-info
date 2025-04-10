## SecureDrop How To

This repository contains simplified instructions for sources on how to use SecureDrop
safely and securely.

It is accessible only via a Tor hidden service: <https://howto.securedrop.tor.onion/>.

### Test environment

To view changes to the HTML on a real Tor hidden service:

- install docker
- run `docker compose up -d`
- run `docker exec -it securedrop-info-tor-1  cat /var/lib/tor/nginx/hostname` to get the hidden service address
- open said hidden service in tor browser

(Tor service Dockerfile borrowed from the Onionprobe project: https://gitlab.torproject.org/tpo/onion-services/onionprobe)
