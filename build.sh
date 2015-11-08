#!/bin/bash

# basic build script

# Define variables

ROM="$HOME/aospd"
KERNEL_SRC="$ROM/aospdK"
KERNEL_PRODUCT="$KERNEL_SRC/arch/arm/boot/zImage-dtb"
KERNEL_LOC="$ROM/device/moto/shamu-kernel"
DEFCON='aospd_defconfig'
UBER_DIR="$HOME/toolchains/arm-eabi-4.8-cortex-a15"
UBER_GCC="$HOME/toolchains/arm-eabi-4.8-cortex-a15/bin/arm-eabi-"
DEFAULT_GCC="$ROM/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-"

# Setup Cross compilation

export ARCH="arm"
export SUBARCH="arm"

if [ -e "$UBER_DIR" ]; then
	export CROSS_COMPILE="$UBER_GCC" && echo "Building kernel with UBER-4.8-arm-eabi-cortex-a15"
else export CROSS_COMPILE="$DEFAULT_GCC" && echo "Defaulting to AOSP prebuilt arm-eabi toolchain"
fi
	
# Start building

if [ -e "$KERNEL_SRC" ]; then
	cd $KERNEL_SRC
	else echo "Directory doesn't exist? Check that out will ya? ;)";
fi

make clean
make mrproper
make $DEFCON
make -j4

if [ $? -eq 1 ]; then
	unset CROSS_COMPILE
fi

export CROSS_COMPILE="$DEFAULT_GCC" && echo "Defaulting to AOSP prebuilt arm-eabi toolchain"

if [ -e "$KERNEL_SRC" ]; then
	cd $KERNEL_SRC
	else echo "Directory doesn't exist? Check that out will ya? ;)";
fi

make clean
make mrproper
make $DEFCON
make -j4

 if [ $? -eq 1 ]; then
	echo "Kernel compilation error. Build is stopping!"
	exit
fi

if [ -e "$KERNEL_LOC" ]; then
	rm -R $KERNEL_LOC
elif [ ! -e "$KERNEL_LOC" ]; then
	mkdir -p $KERNEL_LOC
fi

if [ -n "$KERNEL_PRODUCT" ]; then
	mv $KERNEL_PRODUCT $KERNEL_LOC/zImage-dtb;
	else echo "Kernel build failed! Ending script!";
fi

cd $ROM
. build/envsetup.sh
echo "Start your engines!!!!!!!!"
make clobber 
echo "Clean house!!!!!!!!"
lunch aospd_shamu-userdebug
echo "Well, well, well. Check out the big brain on Brad!"
make -j4 otapackage | tee $HOME/buildlog.txt

if [ $? -eq 0 ]; then
	echo "Build succesful!!!" `date`
	exit
elif [ $? -ne 0 ]; then
	echo "Ooopsy something went wrong!?!?"
	exit
fi
