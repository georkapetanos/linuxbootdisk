#!/bin/bash
cd source
wget https://github.com/strace/strace/releases/download/v5.19/strace-5.19.tar.xz
tar xf strace-5.19.tar.xz
cd strace-5.19
./configure --enable-mpers=no
make -j4
strip --strip-unneeded src/strace
cd ../../
