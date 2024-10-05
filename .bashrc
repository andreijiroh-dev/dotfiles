#!/usr/bin/env bash

# This is my meta bashrc file, with oh-my-posh instead of zsh-specific
# oh-my-zsh, although I still use zsh as my default shell. Sorry for a
# lot of personal commentary and links hellscape here, it's there for
# in-code docs and for future me to not dig through 'git log' hell.
# SPDX-License-Identifier: MIT AND MPL-2.0

# shellcheck disable=SC2155
export GPG_TTY=$(tty)

# how about detecting local configs
if [ -f "$HOME/.config/localconfig.env" ]; then
  . "$HOME/.config/localconfig.env"
fi

export DOTFILES_BIN="$HOME/bin"

# Golang
export GOPATH="$HOME/.local/share/go"
export PATH="${GOPATH}/bin:${PATH}"
# Context: https://git.sr.ht/~sircmpwn/dotfiles/tree/master/item/.profile#L13-15
# and https://drewdevault.com/2021/08/06/goproxy-breaks-go.html
export GOPROXY=direct GOSUMDB=off

# Use nano by default
export EDITOR=nano VISUAL=nano

# nix profile install nixpkgs#glibcLocale
export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"
export PATH="${DOTFILES_BIN}:${GOPATH}/bin:${HOME}/.local/bin:${PATH}"

# bashbox
if [[ -d "$HOME/.bashbox" ]]; then
  # shellcheck disable=SC1091
  source "$HOME/.bashbox/env"
fi

# load the meta bashrc and the rest
source "$HOME/.config/bash/bashrc"