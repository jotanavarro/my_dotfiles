#!/bin/sh
# Links configuration dotfiles to home directory.
# Copyright (C) 2020 Jose Luis Navarro Vicente
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


# Defining some variables
WORKDIR="$HOME/.my_dotfiles"


# Some sanity checks, we want the repo under HOME and the script to
# be invoked from within the repository
[ -d $WORKDIR ] || { echo "ERROR! Repo not at '$WORKDIR'"; exit; }
[ "$PWD" = "$WORKDIR" ] || { echo "ERROR! Invoke from '$WORKDIR'"; exit; }


# Defining functions
link_dir () {
	# Obviously we don't wan't to attempt anything if the directory doesn't exist
	[ -d $1 ] || { echo "ERROR! $1 does not exist!"; exit; }
	for file in `ls $1`; do
		TARGET="$HOME/.$file"
		[ ! -f "$TARGET" ] && ln -s "$WORKDIR/$1/$file" $TARGET
	done
}


# Installing common dotfiles
echo "Generating links for common applications... " ; \
	link_dir 'common'; \
	echo 'Done!'

[ "$(uname -o)" = "GNU/Linux" ] && \
	{ echo "Generating links for GNU/Linux applications... "; \
	link_dir 'gnulinux'; \
	echo 'Done!'; }

