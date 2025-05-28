FROM ubuntu:18.04 AS build

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8   

# Setup cross compilers
RUN dpkg --add-architecture i386 && \
    apt-get -y update && \
    apt-get install --allow-downgrades -y \
    wget \
    linux-libc-dev:i386 \
    gcc-7-multilib \
    gcc-arm-linux-gnueabi \
    gcc-arm-linux-gnueabihf \
    musl-dev musl-tools \
    gcc-aarch64-linux-gnu \
    gcc-mips64el-linux-gnuabi64 \
    gcc-s390x-linux-gnu \
    # gcc-powerpc64le-linux-gnu \
    gcc-riscv64-linux-gnu

WORKDIR /a/crosscompilers

ARG TOOLCHAIN_RELEASE_BASE_URL

RUN wget -q ${TOOLCHAIN_RELEASE_BASE_URL}/arm-linux-musleabihf-cross.tgz && \
    # wget https://musl.cc/arm-linux-musleabihf-cross.tgz
    # wget https://ericsink.com/arm-linux-musleabihf-cross.tgz
    tar --strip-components=1 -zxf ./arm-linux-musleabihf-cross.tgz && \
    wget -q ${TOOLCHAIN_RELEASE_BASE_URL}/aarch64-linux-musl-cross.tgz && \
    # wget https://musl.cc/aarch64-linux-musl-cross.tgz
    # wget https://ericsink.com/aarch64-linux-musl-cross.tgz
    tar --strip-components=1 -zxf aarch64-linux-musl-cross.tgz && \
    wget -q ${TOOLCHAIN_RELEASE_BASE_URL}/s390x-linux-musl-cross.tgz && \
    # wget https://musl.cc/s390x-linux-musl-cross.tgz
    tar --strip-components=1 -zxf s390x-linux-musl-cross.tgz && \
    wget -q ${TOOLCHAIN_RELEASE_BASE_URL}/riscv64-linux-musl-cross.tgz && \
    # wget https://musl.cc/riscv64-linux-musl-cross.tgz
    tar --strip-components=1 -zxf riscv64-linux-musl-cross.tgz && \
    wget -q ${TOOLCHAIN_RELEASE_BASE_URL}/powerpc64le-power8--glibc--stable-2024.05-1.tar.xz && \
    # wget https://toolchains.bootlin.com/downloads/releases/toolchains/powerpc64le-power8/tarballs/powerpc64le-power8--glibc--stable-2024.05-1.tar.xz
    tar --strip-components=1 -xJf powerpc64le-power8--glibc--stable-2024.05-1.tar.xz

WORKDIR /a

COPY --link . .

WORKDIR /a/cb/bld

SHELL ["/bin/bash", "-c"]

# run build scripts
RUN export PATH="$PWD/../../crosscompilers/bin:$PATH" && \
    set -e && \
    for f in linux_*.sh; do \
        if [[ "$f" == *_cross.sh ]] || [[ "$f" == *_regular.sh ]]; \
        then \
            continue; \
        fi; \
        bash "$f"; \
    done

# pull end build products out into scratch image to simplify extraction  
FROM scratch

COPY --from=build /a/cb/bld /cb/bld
