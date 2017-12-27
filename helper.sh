#! /bin/bash

#
# Functions
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

kj () {
	JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
	./prebuilts/sdk/tools/jack-admin kill-server
	./prebuilts/sdk/tools/jack-admin start-server
}

env () {
	build/envsetup.sh
}
		
cln () {
	rm -rf ~/.ccache && make clobber
}
