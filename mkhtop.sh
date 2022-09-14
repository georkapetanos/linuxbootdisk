#!/bin/sh
cd source
wget https://github.com/htop-dev/htop/archive/refs/tags/3.2.1.tar.gz
tar xf 3.2.1.tar.gz
cd htop-3.2.1
./autogen.sh
./configure
make -j4
strip --strip-unneeded htop
