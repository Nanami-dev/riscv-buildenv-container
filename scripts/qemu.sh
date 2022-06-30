#!/bin/sh

cd qemu
./configure --target-list=riscv64-softmmu,riscv64-linux-user --prefix=$PWD/../install/qemu
make -j $(nproc)
make install

