#!/bin/bash

DISTRIBUTION=`cat /etc/os-release | awk '$1 == "ID" { print $2 }' FS="="`
VER_CODE=`cat /etc/os-release | awk '$1 == "VERSION_CODENAME" { print $2 }' FS="="`

if [ $DISTRIBUTION != "ubuntu" ]; then
    echo "Unsupported distribution for local build."
    exit 1
fi

DOCKERFILE=docker/$VER_CODE-local.Dockerfile
if [ -e $DOCKERFILE ]; then
    if ($(command -v riscv64-unknown-elf-gcc > /dev/null))
    then
        TC_PATH=`which riscv64-unknown-elf-gcc`
        TC_DIR=`dirname $TC_PATH`
        ln -s $TC_DIR ./install
    fi
    git submodule init
    git submodule update
    if [ ! -d ./install ]; then
        mkdir -p install
    fi
    ./scripts/qemu.sh
    ./scripts/riscv-toolchain.sh
    docker build -t riscv-buildenv-container:$VER_CODE -f $DOCKERFILE .
else
    echo "Unsupported version for local build."
    exit 1
fi

