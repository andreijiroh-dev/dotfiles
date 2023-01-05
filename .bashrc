#!/usr/bin/env bash

# This is my meta bashrc file, with oh-my-posh instead of zsh-specific
# oh-my-zsh, although I still use zsh as my default shell. Sorry for a
# lot of personal commentary and links hellscape here, it's there for
# in-code docs and for future me to not dig through 'git log' hell.
# SPDX-License-Identifier: TBD

## Stage 0: Init keychain + GPG_TTY for pinentry hellscapes in TUI. ##
##          This stage also initalizes oh-my-posh here.             ##
if [[ $TERMUX ]]; then
  export SSH_AGENT_=todo
else
  eval $(keychain --agents gpg,ssh --eval)
fi
export GPG_TTY=$(tty)
# Tip: I don't want to f**k things up on POSIX-based stuff, I might try
# using 
if command -v oh-my-posh >>/dev/null; then
  eval "$(oh-my-posh init bash)"
fi

## Stage 1: Init custom vars and shortcuts before anything else     ##
# Dotfiles stuff, maybe should be on ~/.env?
export DOTFILES_HOME="$HOME/.dotfiles"
export DOTFILES_BIN="$DOTFILES_HOME/bin"
# gopath should be on ~/.local/share/go to not fuck up with local install
# at ~/go if exists
export GOPATH="$HOME/.local/share/go"
# Shut up, VS Code (not the OSS distributions off github:microsoft/vscode).
# Don't let me pay for JetBrains IDEs or go nuts with nvim (or emacs, since
# I'm both a bit neutral and off the rails at Vim vs Emacs debate). Also RIP
# to my first editor after Notepad that started my web dev + Linux journey,
# Atom (https://github.com/atom).
export EDITOR=nano
# For compartibility reasons and not to fuck things up on ~/go/bin.
# Custom path might be also on ~/.env too?
export PATH="$DOTFILES_BIN:$HOME/go/bin:$HOME/.local/bin:$GOPATH/bin:$PATH"
# It would be nice if I would work on self-hosted reimplementation of
# proxy.golang.org, but in meanwhile, you need to fuck off Google on this.
# (Fucking Facebook and Microsoft off your lives are also hard too ICYMI.)
# Context: https://git.sr.ht/~sircmpwn/dotfiles/tree/master/item/.profile#L13-15
# and https://drewdevault.com/2021/08/06/goproxy-breaks-go.html
export GOPROXY=direct GOSUMDB=off

## Stage 2: Source literally everything else                       ##
if [[ -d "$HOME/.bashbox" ]]; then
  source "$HOME/.bashbox/env"
fi

export HOMEBREW_HOME=${HOMEBREW_HOME:-"/home/linuxbrew/.linuxbrew"}
test -d "$HOMEBREW_HOME" && eval "$($HOMEBREW_HOME/bin/brew shellenv)"
[[ -r "$HOMEBREW_HOME/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_HOME/etc/profile.d/bash_completion.sh"
