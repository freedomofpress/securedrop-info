test environment for a static site offered as a hidden service

To run it
- install docker 
- run `docker compose up -d`
- run `docker exec -it securedrop-info-tor-1  cat /var/lib/tor/nginx/hostname` to get the hidden service address
- open said hidden service in tor browser

(Tor service Dockerfile borrowed from the Onionprobe project: https://gitlab.torproject.org/tpo/onion-services/onionprobe)



