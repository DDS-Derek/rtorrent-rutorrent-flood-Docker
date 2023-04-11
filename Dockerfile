ARG RT_RU_VERSION

FROM crazymax/rtorrent-rutorrent:${RT_RU_VERSION}

RUN set -ex && \
    apk add --no-cache \
        npm \
        nodejs && \
    npm i -g flood@latest && \
    npm ls --global && \
    npm cache clean --force

COPY --chmod=755 ./rootfs /