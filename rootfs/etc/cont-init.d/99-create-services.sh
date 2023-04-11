#!/usr/bin/with-contenv sh
# shellcheck shell=sh

FLOOD_HOST=${FLOOD_HOST:-0.0.0.0}
FLOOD_PORT=${FLOOD_PORT:-3000}
FLOOD_PARAMETER=${FLOOD_PARAMETER:---auth none --rtsocket /var/run/rtorrent/scgi.socket}

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


mkdir -p /etc/services.d/rt_log
cat > /etc/services.d/rt_log/run <<EOL
#!/bin/bash
exec s6-setuidgid ${PUID}:${PGID} bash -c 'tail -f /data/rtorrent/log/*.log'
EOL
chmod +x /etc/services.d/rt_log/run