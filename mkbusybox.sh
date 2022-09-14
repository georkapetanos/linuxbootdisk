#!/bin/sh
cd source
wget https://busybox.net/downloads/busybox-1.35.0.tar.bz2
tar xf busybox-1.35.0.tar.bz2
cp ./busybox.config busybox-1.35.0/.config
cd busybox-1.35.0
make -j4
strip --strip-unneeded busybox
cd ../../
