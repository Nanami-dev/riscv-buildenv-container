#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Error: Invalid argument."
    echo "Specify allowed OS version code."
    exit 1
fi

VER_CODE=$1
DOCKERFILE=docker/$VER_CODE.Dockerfile

if [ -e $DOCKERFILE ]; then
    docker build -t riscv-buildenv-container:$VER_CODE -f $DOCKERFILE .
else
    echo "Error: Unsupported OS version specified."
    exit 1
fi

