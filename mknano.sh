#!/bin/sh
cd source
wget https://www.nano-editor.org/dist/v6/nano-6.4.tar.xz
tar xf nano-6.4.tar.xz
cd nano-6.4
./configure
make -j4
strip --strip-unneeded src/nano
cd ../../
