#!/usr/bin/env sh
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="/usr/local/bin:$HOME/.local/bin:$HOME/bin${PATH:+:}$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts" # ~vern specifics and more
mesg n 2> /dev/null || true

# then import the rest
source "$HOME/.env"
source "$HOME/.config/aliases"
export POSIX_PROFILE_SOURCED=true

# how about detecting local configs
if [ -f "$HOME/.config/localconfig.env" ]; then
  . "$HOME/.config/localconfig.env"
fi

##########################################################################################
# Code snippets from https://git.sr.ht/~sircmpwn/dotfiles/tree/db5945a4/item/.env
##########################################################################################
if ls --version 2>&1 | grep -i gnu >/dev/null
then
	alias ls='ls --color=auto '
elif ls --version 2>&1 | grep -i busybox >/dev/null
then
	alias ls='ls --color=auto '
fi

alias recent='ls -ltch'

# Add optmizations for multicore builds
if [ $(uname) = "Linux" ]
then
	nproc=$(grep '^processor' /proc/cpuinfo | wc -l)
	if [ $nproc -gt 4 ]
	then
		# Reserve two cores
		nproc=$((nproc - 2))
	fi
	export MAKEFLAGS="-j$nproc"
	export SAMUFLAGS="-j$nproc"
fi
##########################################################################################

if [[ $FF_BYOBU_ON_LOGIN != "" ]]; then
fi
