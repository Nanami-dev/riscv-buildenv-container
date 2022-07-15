# riscv-buildenv-container
Container environment for development with RISC-V architecture

## Included tools
- RISC-V GNU Toolchain (Newlib, Linux multilib)
- QEMU v7.0.0 (Only `qemu-system-riscv64`)

## Usage
### Pre-built images
https://hub.docker.com/r/nanamiiiii/riscv-buildenv-container

### build docker image
**Warning:** this generate huge size of intermediate image about 20GB
```sh
./scripts/build.sh <OS VERSION>
```
Now support `Ubuntu 22.04`, `Ubuntu 20.04`, `Ubuntu 18.04`. Allowed arguments below.
- `jammy` (Ubuntu 22.04)
- `focal` (Ubuntu 20.04)
- `bionic` (Ubuntu 18.04)

This generate docker image named `riscv-buildenv-container:<OS VERSION>`

### build with toolchain built on local
RISC-V Toolchain's build process make image huge. In this method, toolchain is built on local and copy into the image.  
You can build only image with **same OS version as host**.  
If you already build toolchain and configure PATH, skip building. 

```sh
./scripts/build-local.sh
```

### Launch container
```sh
./scripts/launch.sh <OS VERSION>
```
This script runs `bash` in the container.

### Recommended
This image contains dependencies of only qemu & toolchain. You should customize before using.

In `Dockerfile`,
```dockerfile
FROM riscv-buildenv-container:<OS Version>
...
```

