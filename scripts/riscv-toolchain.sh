#!/bin/sh

cd riscv-gnu-toolchain
./configure --prefix=$PWD/../install/riscv --enable-multilib
make -j $(nproc)
make -j $(nproc) linux

