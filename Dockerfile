# ehough/docker-kodi - Dockerized Kodi with audio and video.
#
# https://github.com/ehough/docker-kodi
# https://hub.docker.com/r/erichough/kodi/
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

FROM alpine:3.15

ARG KODI_VERSION=19.1

# Set timezone
ENV TZ=Africa/Johannesburg

RUN apk update && apk upgrade && \
    apk add musl-locales tzdata && \
    apk add kodi~$KODI_VERSION

RUN cp /usr/share/zoneinfo/America/Santiago /etc/localtime && \
    rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
