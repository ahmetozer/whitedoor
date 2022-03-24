#!/usr/bin/env bash
set -x
PLATFORMS=('linux/arm/v7')

for PLATFORM in "${PLATFORMS[@]}"; do
    mkdir -p  build/${PLATFORM//\//_} && \
    docker build -t whitedoor-${PLATFORM//\//_} \
    --platform $PLATFORM . && \
    docker container kill whitedoor-${PLATFORM//\//_}-data ;\
    docker container rm whitedoor-${PLATFORM//\//_}-data ;\
    docker run -itd --rm --name whitedoor-${PLATFORM//\//_}-data whitedoor-${PLATFORM//\//_} && \
    docker cp  whitedoor-${PLATFORM//\//_}-data:/system.squashfs build/${PLATFORM//\//_}/system.squashfs && \
    docker container kill whitedoor-${PLATFORM//\//_}-data && sleep 3 && docker image rm whitedoor-${PLATFORM//\//_}
done
