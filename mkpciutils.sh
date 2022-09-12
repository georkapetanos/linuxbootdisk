#!/bin/bash
cd source
wget https://mirrors.edge.kernel.org/pub/software/utils/pciutils/pciutils-3.8.0.tar.xz
tar xf pciutils-3.8.0.tar.xz
cd pciutils-3.8.0
make
strip --strip-unneeded lspci
cd ../../

