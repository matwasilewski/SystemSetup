#!/bin/bash

while getopts ":r:b:p:h" o; do case "${o}" in
	h) printf "Optional arguments for custom use:\\n  -r: Dotfiles repository (local file or url)\\n  -p: Dependencies and programs csv (local file or url)\\n  -h: Show this message\\n" && exit 1 ;;
	p) progsfile=${OPTARG} ;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit 1 ;;
esac done

[ -z "$progsfile" ] && progsfile="assets/progs.csv"


installpkg(){ apt-get --assume-yes install "$1" >/dev/null 2>&1 ;}

maininstall() { # Installs all needed programs from main repo.
	echo "Installing $1  ($n of $total). $1 $2"
	installpkg "$1"
	}

installationloop() { \
	([ -f "$progsfile" ] && cp "$progsfile" /tmp/progs.csv) || curl -Ls "$progsfile" | sed '/^#/d' > /tmp/progs.csv
	total=$(wc -l < /tmp/progs.csv)
	while IFS=, read -r tag program comment; do
		n=$((n+1))
		echo "$comment" | grep -q "^\".*\"$" && comment="$(echo "$comment" | sed "s/\(^\"\|\"$\)//g")"
		case "$tag" in
			*) maininstall "$program" "$comment" ;;
		esac
	done < /tmp/progs.csv ;}

# apt-get install dialog
installationloop
