#
# Dockerfile for a Tor container.
#
# Copyright (C) 2022 The Tor Project, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License,
# or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

FROM debian:latest

ENV APP="tor"
ENV APP_BASE="/etc"
ENV SHELL="/bin/bash"

WORKDIR ${APP_BASE}/${APP}

# Install basic dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    wget gnupg

COPY configs/apt/tor.list /etc/apt/sources.list.d/tor.list
COPY scripts/get-tor-debian-key.sh /usr/local/bin
RUN  /usr/local/bin/get-tor-debian-key.sh /usr/share/keyrings/tor-archive-keyring.gpg
RUN  rm /usr/local/bin/get-tor-debian-key.sh

# Install Tor and dependencies
RUN apt-get update && \
    apt-get install -y \
    deb.torproject.org-keyring \
    tor \
    && rm -rf /var/lib/apt/lists/*

COPY containers/tor/torrc ${APP_BASE}/${APP}/torrc

RUN chown -R debian-tor: ${APP_BASE}/${APP}/torrc

RUN chmod 600 ${APP_BASE}/${APP}/torrc

USER debian-tor

ENTRYPOINT [ "/usr/bin/tor", "-f", "/etc/tor/torrc" ]

EXPOSE 9050 9051

