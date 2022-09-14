#!/bin/bash

mkdir -p ./initramfs
mkdir -p ./initramfs/{bin,sbin,lib,mnt,etc,proc,sys,root,tmp,usr}
mkdir -p ./initramfs/usr/{bin,sbin,local,lib,lib64,share}
mkdir -p ./initramfs/usr/local/share
mkdir -p ./initramfs/lib/x86_64-linux-gnu
mkdir -p ./initramfs/usr/lib64/x86_64-linux-gnu
mkdir -p ./initramfs/usr/lib/x86_64-linux-gnu
rm ./initramfs/lib64
ln -s -r ./initramfs/usr/lib64 ./initramfs/lib64
touch ./initramfs/etc/mdev.conf
cp -a ./source/init ./initramfs/init
chmod +x ./initramfs/init
cp -a ./source/{group,inittab,passwd} ./initramfs/etc/
#./mkbusybox.sh
cp -a ./source/busybox-1.35.0/busybox ./initramfs/bin/busybox
#Populate bin, sbin etc with symbolink relative links to busybox executable
for i in $(./initramfs/bin/busybox --list-full)
do
    ln -s -r ./initramfs/bin/busybox ./initramfs/$i
done
#pci-utils
#./mkpciutils.sh
rm ./initramfs/usr/bin/lspci
cp ./source/pciutils-3.8.0/lspci ./initramfs/usr/bin/lspci
cp ./source/pciutils-3.8.0/pci.ids.gz ./initramfs/usr/local/share/pci.ids.gz
#nano
#./mknano.sh
cp ./source/nano-6.4/src/nano ./initramfs/usr/bin/nano
#strace
#cp ./source/strace-5.19/src/strace ./initramfs/usr/bin/strace
#screen
#./mkscreen.sh
cp ./source/screen-v.4.9.0/src/screen ./initramfs/usr/bin/screen
cp ./source/screen-v.4.9.0/src/etc/etcscreenrc ./initramfs/etc/screenrc
#htop
#./mkhtop.sh
cp ./source/htop-3.2.1/htop ./initramfs/usr/bin/htop
#net
cp ./source/udhcpc.script ./initramfs/usr/bin/
cp ./source/autonet.sh ./initramfs/usr/bin/
#libs
#./mklibc.sh
cp ./source/glibc/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 ./initramfs/usr/lib64/
ln -s -r ./initramfs/usr/lib64/ld-linux-x86-64.so.2 ./initramfs/usr/lib64/ld.so
cp ./source/glibc/lib/x86_64-linux-gnu/libc.so.6 ./initramfs/lib/x86_64-linux-gnu/
ln -s -r ./initramfs/lib/x86_64-linux-gnu/libc.so.6 ./initramfs/lib/x86_64-linux-gnu/libc.so
cp ./source/zlib-1.2.12/libz.so.1.2.12 ./initramfs/lib/x86_64-linux-gnu/
ln -s -r ./initramfs/lib/x86_64-linux-gnu/libz.so.1.2.12 ./initramfs/lib/x86_64-linux-gnu/libz.so.1
cp ./source/glibc/lib/x86_64-linux-gnu/libm.so.6 ./initramfs/lib/x86_64-linux-gnu/libm.so.6
#./librest.sh
cp ./source/libudev/usr/lib/x86_64-linux-gnu/libudev.so.1.7.2 ./initramfs/usr/lib/x86_64-linux-gnu/libudev.so.1.7.2
ln -s -r ./initramfs/usr/lib/x86_64-linux-gnu/libudev.so.1.7.2 ./initramfs/usr/lib/x86_64-linux-gnu/libudev.so.1
cp ./source/libselinux-3.3/src/libselinux.so.1 ./initramfs/lib/x86_64-linux-gnu/libselinux.so.1
cp ./source/libpcre/usr/lib/x86_64-linux-gnu/libpcre2-8.so.0 ./initramfs/lib/x86_64-linux-gnu/libpcre2-8.so.0
cp ./source/libpcre3/lib/x86_64-linux-gnu/libpcre.so.3.13.3 ./initramfs/lib/x86_64-linux-gnu/libpcre.so.3.13.3
ln -s -r ./initramfs/lib/x86_64-linux-gnu/libpcre.so.3.13.3 ./initramfs/lib/x86_64-linux-gnu/libpcre.so.3
cp ./source/libtinfo6/lib/x86_64-linux-gnu/libtinfo.so.6 ./initramfs/lib/x86_64-linux-gnu/libtinfo.so.6
cp ./source/libncursesw/lib/x86_64-linux-gnu/libncursesw.so.6.3 ./initramfs/lib/x86_64-linux-gnu/libncursesw.so.6.3
ln -s -r ./initramfs/lib/x86_64-linux-gnu/libncursesw.so.6.3 ./initramfs/lib/x86_64-linux-gnu/libncursesw.so.6
cp -r ./source/ncurses-base/lib/terminfo ./initramfs/lib/terminfo
cp ./source/libcrypt/lib/x86_64-linux-gnu/libcrypt.so.1.1.0 ./initramfs/lib/x86_64-linux-gnu/libcrypt.so.1.1.0
ln -s -r ./initramfs/lib/x86_64-linux-gnu/libcrypt.so.1.1.0 ./initramfs/lib/x86_64-linux-gnu/libcrypt.so.1
#create cpio archive
cd initramfs
find . | cpio -H newc -o > ../initramfs.cpio
cd ..
gzip initramfs.cpio -c > initramfs.igz
