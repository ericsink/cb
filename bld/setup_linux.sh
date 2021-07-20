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
