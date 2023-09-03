#!/usr/bin/env bash

export HOMEBREW_HOME=${HOMEBREW_HOME:-"/home/linuxbrew/.linuxbrew"}
test -d "$HOMEBREW_HOME" && eval "$($HOMEBREW_HOME/bin/brew shellenv)"
[[ -r "$HOMEBREW_HOME/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_HOME/etc/profile.d/bash_completion.sh"