#!/bin/bash
cd source
wget https://zlib.net/zlib-1.2.12.tar.xz
tar xf zlib-1.2.12.tar.xz
cd zlib-1.2.12
./configure
make -j4
strip --strip-unneeded libz.so.1.2.12
cd ../../
