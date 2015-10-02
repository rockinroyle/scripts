#!/bin/sh

# Script for buiding clean ROM. Removes "~/.ccache". Compile using uber-4.8-androideabi-cortex-a15 and uber-4.9-arm-eabi-cortex-a15 for shamu. Run from source dir.

# By: rockinroyle

# Cleanup and set environment to build

rm ~/buildlog.txt
rm -R ~/.ccache
. build/envsetup.sh

# Define variables

export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=~/toolchains/arm-linux-androideabi-4.8-cortex-a15/bin/arm-linux-androideabi-
export CROSS_COMPILE=~/toolchains/arm-eabi-4.9-cortex-a15/bin/arm-eabi-

# Meat and bones

lunch aospd_shamu-userdebug
make clobber
make -j6 otapackage | tee ~/buildlog.txt
