#!/bin/bash

#
# ROM build script
#
# Copyright (C) 2017-2018 @rockinroyle aka Ralph L Royle III
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/> 


# Run the script im the root directory of ROM's source
# Syntax: "bash ./build [-c|-d|-w] [device]" 
# Args: -c -> "clean" clobber build dir
#       -d -> "dirty" build dirty and clean nothing (expert only!!! USE AT OWN RISK!!!!)
#       -w -> "wipe" clobber build dir and wipe .ccache

# Set functions

#############################################
# Name: printUSAGE
# Desc: prints a USAGE message then exits
# Args: $@ -> message to print
#############################################

printUSAGE () {
	echo "USAGE:" $@
}

# Check proper script usage before running

USAGE="`basename $0` [-c|-d|-w] [device]"

if [ $# -lt "2" ]; then
	printUSAGE $USAGE;
	exit 1;
fi

# Kick off build environment setup

. ./build/envsetup.sh
USECCACHE=${default:-'1'} ; export USE_CCACHE

# case statement to define arguments specifying "clean" or "dirty" build

case "$1" in
	-c)make clobber
	   brunch "$2"
	   ;;
	-d)brunch "$2"
	   ;;
	-w)rm -rf $HOME/.ccache && make clobber
	   ;;
	 *)printUSAGE $USAGE
	   exit 1
	   ;;
esac

exit 0
