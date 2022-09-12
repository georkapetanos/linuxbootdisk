#!/bin/bash
cd source
wget http://ftp.gnu.org/gnu/glibc/glibc-2.36.tar.xz
tar xf glibc-2.36.tar.xz
cd glibc-2.36
mkdir glibc-build
cd glibc-build
../configure --prefix=$(pwd)/../../../initramfs/usr
make -j4
strip --strip-unneeded elf/ld.so
strip --strip-debug elf/ld.so
strip --strip-unneeded libc.so
strip --strip-debug libc.so
cd ../../../
