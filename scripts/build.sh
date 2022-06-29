#!/bin/sh

VER=$1
DOCKERFILE=docker/jammy.Dockerfile
if [ $VER = "jammy" ]; then
    DOCKERFILE=docker/jammy.Dockerfile
elif [ $VER = "bionic" ]; then
    DOCKERFILE=docker/bionic.Dockerfile
else
    echo "invalid argument."
    exit 1
fi

docker build -t riscv-buildenv-container:$VER -f $DOCKERFILE .

