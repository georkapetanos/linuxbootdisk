#!/bin/sh

qemu-system-x86_64 \
    -m 256 \
    -kernel bzImage \
    -initrd initramfs.igz
