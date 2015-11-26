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
LOGS="$HOME/ROMlog"


# Home base

if [ ! -e "$LOGS" ]; then
	mkdir $LOGS
fi


# Setup Cross compilation

export ARCH="arm"
export SUBARCH="arm"
export CROSS_COMPILE="$DEFAULT_GCC"

	
# Start building

if [ -e "$KERNEL_SRC" ]; then
	cd $KERNEL_SRC
	else echo "Directory doesn't exist? Check that out will ya? ;)";
fi

make clean | tee $LOGS/kernelclean.txt

if [ $? -eq 1 ]; then
	echo "Error! Check ~/ROMlog/kernelclean.txt!"
fi

make mrproper | tee $LOGS/mrproper.txt

if [ $? -eq 1 ]; then
	echo "Error! Check ~/ROMlog/mrproper.txt!"
fi

make $DEFCON | tee $LOGS/kernelbuild.txt

if [ $? -eq 1 ]; then
	echo "Error! Check ~/ROMlog/kernelbuild.txt!"
fi

make -j4

if [ $? -eq 1 ]; then
	echo "Error! Check ~/ROMlog/kernelmake.txt!"\n
	"Kernel compilation error. Build is stopping!";
	exit;
fi

if [ ! -e "$KERNEL_LOC" ]; then
 mkdir -p $KERNEL_LOC
fi

if [ -e "$KERNEL_PRODUCT" ]; then
	cp $KERNEL_PRODUCT $KERNEL_LOC/zImage-dtb | tee ~/ROMlog/buildlog.txt;
	else exit;
	echo "Kernel build failed! Ending script! Check ~/ROMlog/buildlog.txt";
fi

cd $ROM
. build/envsetup.sh
echo "Start your engines!!!!!!!!"
make clobber 
echo "Clean house!!!!!!!!"
lunch aospd_shamu-userdebug
echo "Well, well, well. Check out the big brain on Brad!"
make -j4 otapackage | tee $LOGS/buildlog.txt

if [ $? -eq 0 ]; then
	echo "Build succesful!!!" `date`;
	exit;
elif [ $? -ne 0 ]; then
	echo "Ooopsy something went wrong!?!?";
	exit;
fi
