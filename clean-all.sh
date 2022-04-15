#!/bin/bash

LANG=C

# location
KERNELDIR=$(readlink -f .);

rm .config .config.bkp .config.old;
make ARCH=arm64 CC=clang CLANG_TRIPLE=google-ndk-clang/bin/aarch64-linux- CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-4.9/bin/arm-linux-androideabi- mrproper;
make ARCH=arm64 CC=clang CLANG_TRIPLE=google-ndk-clang/bin/aarch64-linux- CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-4.9/bin/arm-linux-androideabi- clean;

rm -rf "$KERNELDIR"/B--B/boot
# rm -f "$KERNELDIR"/B--B/system/lib/modules/*;
rm -f "$KERNELDIR"/B--B/*.zip
rm -f "$KERNELDIR"/B--B/*.img
rm -f "$KERNELDIR"/B--B/view_only_config
rm -f "$KERNELDIR"/B--B/.config

if [ -d ../Ramdisk-Gemini-tmp ]; then
	rm -rf ../Ramdisk-Gemini-tmp/*
else
	mkdir ../Ramdisk-Gemini-tmp
	chmod 777 ../Ramdisk-Gemini-tmp
fi;

# force regeneration of .dtb and Image files for every compile
rm -f arch/arm64/boot/*.dtb
rm -f arch/arm64/boot/dts/*.dtb
rm -f arch/arm64/boot/*.cmd
rm -f arch/arm64/boot/zImage
rm -f arch/arm64/boot/Image
rm -f arch/arm64/boot/Image.gz
rm -f arch/arm64/boot/Image.gz-dtb

git checkout firmware/

# clean ccache
read -t 5 -p "clean ccache, 5sec timeout (y/n)?";
if [ "$REPLY" == "y" ]; then
        ccache -C;
fi;
