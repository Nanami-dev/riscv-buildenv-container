#!/bin/sh

cd riscv-toolchain
./configure --prefix=$PWD/../install/riscv --enable-multilib
make -j $(nproc)
make -j $(nproc) linux

