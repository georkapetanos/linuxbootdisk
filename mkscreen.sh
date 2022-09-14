#!/bin/sh
cd source
wget https://git.savannah.gnu.org/cgit/screen.git/snapshot/screen-v.4.9.0.tar.gz
tar xf screen-v.4.9.0.tar.gz
cd screen-v.4.9.0
cd src
./autogen.sh
./configure
make -j4
strip --strip-unneeded screen
cd ../../../
