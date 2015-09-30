#!/bin/sh

# Script for buiding clean ROM. Removes "~/.ccache". Compile using uber-4.8-androideabi-cortex-a15 and uber-4.9-arm-eabi-cortex-a15 for shamu. Run from source dir.
# By: rockinroyle


# Define variables

export ARCH=arm
export SUBARCH=arm
export PATH=(pwd):~/toolchains/androideabi/uber-4.8-androideabi-cortex-a15/bin:$PATH
export CROSS_COMPILE=~/toolchains/eabi/uber-4.9-arm-eabi-cortex-a15/bin/arm-eabi-

# Meat and bones

rm ~/buildlog.txt
rm -R ~/.ccache
. build/envsetup.sh
lunch aospd_shamu-userdebug
make clobber
make -j6 otapackage | tee ~/buildlog.txt
