#!/usr/bin/env sh
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export PATH="/usr/local/bin${PATH:+:}$PATH" # ~vern specifics, might work on this soon.
mesg n 2> /dev/null || true

# then import the rest
source "$HOME/.env"
source "$HOME/.config/aliases"
