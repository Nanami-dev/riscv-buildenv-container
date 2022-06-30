#!/bin/bash

DISTRIBUTION=`cat /etc/os-release | awk '$1 == "ID" { print $2 }' FS="="`
VER_CODE=`cat /etc/os-release | awk '$1 == "VERSION_CODENAME" { print $2 }' FS="="`

echo "Host Distribution: $DISTRIBUTION"
echo "Host Codename: $VER_CODE"

if [ $DISTRIBUTION != "ubuntu" ]; then
    echo "Unsupported distribution for local build."
    exit 1
fi

DOCKERFILE=docker/$VER_CODE-local.Dockerfile
if [ -e $DOCKERFILE ]; then
    if [ ! -d ./install ]; then
        mkdir -p install
    fi
    if ($(command -v riscv64-unknown-elf-gcc > /dev/null))
    then
        TC_PATH=`which riscv64-unknown-elf-gcc`
        TC_BIN_DIR=`dirname $TC_PATH`
        echo "Toolchain found. Copying..."
        cp -r $(dirname $TC_BIN_DIR) ./install
    else
        git submodule init
        git submodule update
        ./scripts/riscv-toolchain.sh    
    fi
    docker build -t riscv-buildenv-container:$VER_CODE -f $DOCKERFILE .
    echo "Cleaning..."
    rm -rf ./install
else
    echo "Unsupported version for local build."
    exit 1
fi

