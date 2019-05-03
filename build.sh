#!/bin/bash

AIK_DIR=/home/litao/Tools/cepheus_AIK_tool
KERNEL_DIR=`pwd`
DTC_DIR=/home/litao/Tools/dtc-1.5.0
GCC_DIR=/home/litao/Tools/aarch64-linux-android-4.9
LLVM_DIR=/home/litao/Tools/snapdragon-llvm-6.0.9-linux64

mkdir out
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=$DTC_DIR/dtc
export CROSS_COMPILE=$GCC_DIR/bin/aarch64-linux-android-

make O=out REAL_CC=$LLVM_DIR/toolchains/llvm-Snapdragon_LLVM_for_Android_6.0/prebuilt/linux-x86_64/bin/clang CLANG_TRIPLE=aarch64-linux-gnu- cepheus_p_bawan_defconfig
make O=out REAL_CC=$LLVM_DIR/toolchains/llvm-Snapdragon_LLVM_for_Android_6.0/prebuilt/linux-x86_64/bin/clang CLANG_TRIPLE=aarch64-linux-gnu- -j4

cp $KERNEL_DIR/out/arch/arm64/boot/Image-dtb $AIK_DIR/split_img/boot.img-zImage
chmod 664 $AIK_DIR/split_img/boot.img-zImage

source $AIK_DIR/repackimg.sh
