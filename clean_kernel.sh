#!/bin/bash

LANG=C

cp -pv .config .config.bkp;
make ARCH=arm64 CC=clang CLANG_TRIPLE=google-ndk-clang/bin/aarch64-linux- CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-4.9/bin/arm-linux-androideabi- mrproper;
make ARCH=arm64 CC=clang CLANG_TRIPLE=google-ndk-clang/bin/aarch64-linux- CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-4.9/bin/arm-linux-androideabi- CC=clang clean;
cp -pv .config.bkp .config;

git checkout firmware/

# clean ccache
read -t 5 -p "clean ccache, 5sec timeout (y/n)?";
if [ "$REPLY" == "y" ]; then
        ccache -C;
fi;
