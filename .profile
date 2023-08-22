#!/usr/bin/env sh
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export PATH="/usr/local/bin${PATH:+:}$PATH" # ~vern specifics and more
mesg n 2> /dev/null || true

# then import the rest
source "$HOME/.env"
source "$HOME/.config/aliases"
export POSIX_PROFILE_SOURCED=true

# how about detecting local configs
if [ -f "$HOME/.config/localconfig.env" ]; then
  . "$HOME/.config/localconfig.env"
fi

# Added by Toolbox App
export PATH="$PATH:/home/ajhalili2006/.local/share/JetBrains/Toolbox/scripts"

# Import asdf to shell
#export ASDF_DIR="$HOME/.asdf"
#. "$HOME/.asdf/asdf.sh"

eval "$(devbox global shellenv)"

_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
