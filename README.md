# riscv-buildenv-container
Container environment for development with RISC-V architecture

## Included tools
- RISC-V GNU Toolchain (Newlib, Linux multilib)
- QEMU v7.0.0 (Only `qemu-system-riscv64`)

## Usage
### build docker image
**Warning:** this generate huge size of intermediate image about 20GB
```
scripts/build.sh <OS VERSION>
```
Now support `Ubuntu 22.04`, `Ubuntu 18.04`. Allowed arguments below.
- `jammy` (Ubuntu 22.04)
- `bionic` (Ubuntu 18.04)

This generate docker image named `riscv-buildenv-container:<OS VERSION>`

### Launch container
```
scripts/launch.sh <OS VERSION>
```
This script runs `bash` in the container.

