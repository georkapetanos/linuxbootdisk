#!/bin/bash
cd source
mkdir libudev
cd libudev
wget http://launchpadlibrarian.net/621833763/libudev1_249.11-0ubuntu3.5_amd64.deb
ar vx libudev1_249.11-0ubuntu3.5_amd64.deb
unzstd data.tar.zst
tar -xvf data.tar
cd ../
cd source
wget https://github.com/SELinuxProject/selinux/archive/refs/tags/3.4.tar.gz
