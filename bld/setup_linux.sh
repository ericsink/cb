#!/bin/sh

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install linux-libc-dev:i386
sudo apt-get install gcc-multilib

sudo apt-get install gcc-arm-linux-gnueabi
sudo apt-get install gcc-arm-linux-gnueabihf
sudo apt-get install musl-dev musl-tools
sudo apt-get install gcc-aarch64-linux-gnu
sudo apt-get install gcc-mips64el-linux-gnuabi64
sudo apt-get install gcc-s390x-linux-gnu
sudo apt-get install gcc-powerpc64le-linux-gnu
sudo apt-get install gcc-riscv64-linux-gnu

mkdir crosscompilers
cd crosscompilers
wget https://musl.cc/arm-linux-musleabihf-cross.tgz
#wget https://ericsink.com/arm-linux-musleabihf-cross.tgz
tar --strip-components=1 -zxf ./arm-linux-musleabihf-cross.tgz
wget https://musl.cc/aarch64-linux-musl-cross.tgz
#wget https://ericsink.com/aarch64-linux-musl-cross.tgz
tar --strip-components=1 -zxf aarch64-linux-musl-cross.tgz
wget https://musl.cc/s390x-linux-musl-cross.tgz
tar --strip-components=1 -zxf s390x-linux-musl-cross.tgz
wget https://musl.cc/riscv64-linux-musl-cross.tgz
tar --strip-components=1 -zxf riscv64-linux-musl-cross.tgz
wget https://github.com/loongson/build-tools/releases/download/2024.11.01/x86_64-cross-tools-loongarch64-binutils_2.43.1-gcc_14.2.0-glibc_2.40.tar.xz
tar --strip-components=1 -xf x86_64-cross-tools-loongarch64-binutils_2.43.1-gcc_14.2.0-glibc_2.40.tar.xz
cd ..
