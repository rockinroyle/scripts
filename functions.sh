#! /bin/bash

#
# Functions Library
#
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


#############################################
# Name: printERROR
# Desc: prints a message to STDERR
# Args: $@ -> message to print
#############################################

printERROR () {
	echo "ERROR:" $@ >&2
}

#############################################
# Name: printWARNING
# Desc: prints a message to STDERR
# Args: $@ -> message to print
#############################################

printWARNING () {
	echo "WARNING:" $@ >&2
}

#############################################
# Name: printUSAGE
# Desc: prints a USAGE message then exits
# Args: $@ -> message to print
#############################################

printUSAGE () {
	echo "USAGE:" $@
}

#############################################
# Name: promptYESNO
# Desc: ask a yes/no question
# Args: $1 -> The prompt
#       $2 -> The default answer (optional)
# Vars: YESNO -> set to the users response
#                y for yes, n for no
#############################################

promptYESNO () {
	if [ $# -lt 1 ]; then
		printERROR "Insufficient Arguments!"
		return 1
	fi
	
	DEFAULT=""
	YESNO=""
	
	case "$@" in
		[yY]|[yY][eE][sS])
			DEFAULT=y ;;
		[nN]|[nN]{oO])
			DEFAULT=n ;;
	esac
	
	while : 
	do
	
		printf "$1 (y/n?)"
		
		if [ -n "$DEFAULT" ]; then
			printf "[$DEFAULT] "
		fi
		
		read YESNO
		
		if [ -z "$YESNO" ]; then
			YESNO="$DEFAULT"
		fi
		
		case "YESNO" in
			[yY]|[yY][eE][sS])
				YESNO=y ; break ;;
			[[nN]|[nN][oO]
				YESNO=n ; break ;;
			*)
				YESNO="" ;;
		esac
		
	done
	
	export YESNO
	unset DEFAULT
	return 0
}

	
