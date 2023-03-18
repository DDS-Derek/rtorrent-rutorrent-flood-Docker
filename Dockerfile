ARG DOCKER_METADATA_OUTPUT_VERSION

FROM crazymax/rtorrent-rutorrent:${DOCKER_METADATA_OUTPUT_VERSION}

RUN set -ex && \
    apk add --no-cache \
        npm \
        nodejs && \
    npm i -g flood@latest && \
    npm ls --global && \
    npm cache clean --force

COPY --chmod=755 ./rootfs /