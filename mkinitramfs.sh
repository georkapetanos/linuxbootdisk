#!/bin/bash

mkdir -p ./initramfs
mkdir -p ./initramfs/{bin,sbin,lib,mnt,etc,proc,sys,root,tmp,usr}
mkdir -p ./initramfs/usr/{bin,sbin,local,lib,lib64,share}
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
#create cpio archive
cd initramfs
find . | cpio -H newc -o > ../initramfs.cpio
cd ..
gzip initramfs.cpio -c > initramfs.igz
