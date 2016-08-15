#!/bin/bash

DISTRO_CHECK=0

if [ $# -gt 0 ]
then
	echo "Discarding argument(s) \"" $@ "\""
fi

if [ ! -f .stage ]
then
	echo "Seems to be your first run, lets check few things before we proceed"
	if [ -f /etc/os-release ]
	then
		DISTRO=`cat /etc/os-release | grep ^ID= | cut -d'=' -f2`
		if [ ! $DISTRO = "ubuntu" ]
		then
			DISTRO_CHECK=1
		else
			echo -n "Installing necessary packages before preceeding further .... "
			sudo apt-get install build-essential git subversion cvs unzip whois ncurses-dev bc mercurial > /dev/null 2>&1
			echo "DONE"
			echo "1" > .stage
		fi
	else
		DISTRO_CHECK=1
	fi

	if [ $DISTRO_CHECK -ne 0 ]
	then
		echo "You are running some distribution which the script might not support, this"
		echo "script is meant to be used with Ubuntu (Tested to work better on Ubuntu 12.04 LTS)"
		echo "Better luck :)"
	fi
fi
