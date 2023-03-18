#!/usr/bin/with-contenv sh
# shellcheck shell=sh

FLOOD_HOST=${FLOOD_HOST:-0.0.0.0}
FLOOD_PORT=${FLOOD_PORT:-3000}

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
