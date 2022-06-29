#!/bin/sh

VER=$1

docker run -it riscv-buildenv-container:$VER /bin/bash

