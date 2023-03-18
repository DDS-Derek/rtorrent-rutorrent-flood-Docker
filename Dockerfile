ARG RTAG=3.10-0.9.8-0.13.8

FROM crazymax/rtorrent-rutorrent:${RTAG}

RUN set -ex && \
    apk add --no-cache \
        npm \
        nodejs && \
    npm i -g flood@latest && \
    npm ls --global && \
    npm cache clean --force

COPY --chmod=755 ./rootfs /