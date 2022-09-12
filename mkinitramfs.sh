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
cp -a ./source/busybox ./initramfs/bin/busybox
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
#strace
cp ./source/strace-5.19/src/strace ./initramfs/usr/bin/strace
#libs
#./mklibc.sh
cp ./source/glibc-2.36/glibc-build/elf/ld.so ./initramfs/usr/lib64/
ln -s -r ./initramfs/usr/lib64/ld.so ./initramfs/usr/lib64/ld-linux-x86-64.so.2
cp ./source/glibc-2.36/glibc-build/libc.so ./initramfs/lib/x86_64-linux-gnu/
ln -s -r ./initramfs/lib/x86_64-linux-gnu/libc.so ./initramfs/lib/x86_64-linux-gnu/libc.so.6
cp ./source/zlib-1.2.12/libz.so.1.2.12 ./initramfs/lib/x86_64-linux-gnu/
ln -s -r ./initramfs/lib/x86_64-linux-gnu/libz.so.1.2.12 ./initramfs/lib/x86_64-linux-gnu/libz.so.1
#./librest.sh
cp ./source/libudev/usr/lib/x86_64-linux-gnu/libudev.so.1.7.2 ./initramfs/usr/lib/x86_64-linux-gnu/libudev.so.1.7.2
ln -s -r ./initramfs/usr/lib/x86_64-linux-gnu/libudev.so.1.7.2 ./initramfs/usr/lib/x86_64-linux-gnu/libudev.so.1
#create cpio archive
cd initramfs
find . | cpio -H newc -o > ../initramfs.cpio
cd ..
gzip initramfs.cpio -c > initramfs.igz
