FROM ubuntu:focal as tcbuild
RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get -y install git autoconf automake autotools-dev curl python3 \
    libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex \
    texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev \
    libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build \
    libssh-dev

WORKDIR /src
RUN mkdir -p install
RUN git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git riscv-toolchain
RUN cd riscv-toolchain && git checkout 2022.06.10
COPY ./scripts/riscv-toolchain.sh ./riscv-toolchain.sh
RUN chmod +x ./riscv-toolchain.sh && ./riscv-toolchain.sh

FROM ubuntu:focal as qemubuild
RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get -y install git autoconf automake autotools-dev curl python3 \
    libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex \
    texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev \
    libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build \
    libssh-dev

WORKDIR /src
RUN mkdir -p install
RUN git clone https://github.com/qemu/qemu.git qemu
RUN cd qemu && git checkout v7.0.0
COPY ./scripts/qemu.sh ./qemu.sh
RUN chmod +x ./qemu.sh && ./qemu.sh

FROM ubuntu:focal as runner
RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get -y install git autoconf automake autotools-dev curl python3 \
    libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex \
    texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev \
    libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build \
    libssh-dev

COPY --from=tcbuild /src/install/riscv /opt/riscv
COPY --from=qemubuild /src/install/qemu /opt/qemu-riscv

RUN echo "export PATH=$PATH:/opt/riscv/bin:/opt/qemu-riscv/bin" > source.sh
RUN echo "source /source.sh" >> /root/.bashrc

