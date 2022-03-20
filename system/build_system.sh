#!/usr/bin/env bash
set -x
PLATFORMS=('linux/arm/v7')

for PLATFORM in "${PLATFORMS[@]}"; do
    mkdir -p  build/${PLATFORM//\//_}
    
    docker build -t whitedoor-${PLATFORM//\//_} \
    --platform $PLATFORM .

    docker save  whitedoor-${PLATFORM//\//_} > build/${PLATFORM//\//_}/container.tar
    
    system_tar_file=$(tar tvf build/${PLATFORM//\//_}/container.tar | grep layer.tar | cut -d'>' -f 2 | cut -d'/' -f2)
    
    tar --extract --file=build/${PLATFORM//\//_}/container.tar -C build/${PLATFORM//\//_}/ --transform "s/${system_tar_file}/system.tar/" ${system_tar_file}
    
    rm build/${PLATFORM//\//_}/container.tar
done
