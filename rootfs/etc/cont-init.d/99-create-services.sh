#!/usr/bin/with-contenv sh
# shellcheck shell=sh

FLOOD_HOST=${FLOOD_HOST:-0.0.0.0}
FLOOD_PORT=${FLOOD_PORT:-3000}
FLOOD_PARAMETER=${FLOOD_PARAMETER:---auth none --rtsocket /var/run/rtorrent/scgi.socket}

GU_EDITION_IDS=${GU_EDITION_IDS:-GeoLite2-City,GeoLite2-Country}
GU_LICENSE_KEY=${GU_LICENSE_KEY:-0123456789ABCD}
GU_SCHEDULE=${GU_SCHEDULE:-0 0 * * 0}
GU_LOG_LEVEL=${GU_LOG_LEVEL:-info}

mkdir -p /etc/services.d/flood
cat > /etc/services.d/flood/run <<EOL
#!/usr/bin/execlineb -P
with-contenv
/bin/export HOME /data/flood
/bin/export PWD /data/flood
s6-setuidgid ${PUID}:${PGID}
$(which flood) --rundir /data/flood --port ${FLOOD_PORT} --host ${FLOOD_HOST} ${FLOOD_PARAMETER}
EOL
chmod +x /etc/services.d/flood/run

mkdir -p /tmp/geoip
chown -R ${PUID}:${PGID} /tmp/geoip
mkdir -p /etc/services.d/geoip_updater
cat > /etc/services.d/geoip_updater/run <<EOL
#!/usr/bin/execlineb -P
with-contenv
/bin/export HOME /tmp/geoip
/bin/export PWD /tmp/geoip
s6-setuidgid ${PUID}:${PGID}
/usr/local/bin/geoip-updater \
  --edition-ids ${GU_EDITION_IDS} \
  --license-key ${GU_LICENSE_KEY} \
  --download-path /data/geoip \
  --schedule "${GU_SCHEDULE}" \
  --log-level "${GU_LOG_LEVEL}"
EOL
chmod +x /etc/services.d/geoip_updater/run

mkdir -p /etc/services.d/rt_log
cat > /etc/services.d/rt_log/run <<EOL
#!/bin/bash
exec s6-setuidgid ${PUID}:${PGID} bash -c 'tail -f /data/rtorrent/log/*.log'
EOL
chmod +x /etc/services.d/rt_log/run