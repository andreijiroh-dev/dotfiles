#!/usr/bin/env bash

# This is my meta bashrc file, with oh-my-posh instead of zsh-specific
# oh-my-zsh, although I still use zsh as my default shell. Sorry for a
# lot of personal commentary and links hellscape here, it's there for
# in-code docs and for future me to not dig through 'git log' hell.
# SPDX-License-Identifier: MIT AND MPL-2.0

## Stage 0: Init keychain + GPG_TTY for pinentry hellscapes in TUI. ##
##          This stage also initalizes oh-my-posh or custom
##          PSI here.             ##
if [[ $TERMUX ]]; then
  export SSH_AGENT_=todo
elif command -v keychain >> /dev/null; then
  export KEYCHAIN_PATh=$(command -v keychain)
  eval $(keychain --agents gpg,ssh --eval)
fi
export GPG_TTY=$(tty)

# how about detecting local configs
if [ -f "$HOME/.config/localconfig.env" ]; then
  . "$HOME/.config/localconfig.env"
fi

if command -v oh-my-posh >>/dev/null  && [[ $FF_USE_OHMYPOSH != "false" ]]; then
  eval "$(oh-my-posh init bash)"
else
  if [[ $PROMPT_THEME == "disabled" ]]; then
    true
  elif [[ -f "$HOME/.config/bash/shell-prompts/${PROMPT_THEME}.bashrc" ]]; then
    source "$HOME/.config/bash/shell-prompts/${PROMPT_THEME}.bashrc"
  else
    source "$HOME/.config/bash/shell-prompts/vern.bashrc"
  fi
fi

## Stage 1: Init custom vars and shortcuts before anything else           ##
##          Note that ~/.env and ~/.env.local should be loaded eariler on ##
# Dotfiles stuff, maybe should be on ~/.env?
#export DOTFILES_HOME="$HOME/.dotfiles"
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
# Context: https://git.sr.ht/~sircmpwn/dotfiles/tree/master/item/.profile#L13-15
# and https://drewdevault.com/2021/08/06/goproxy-breaks-go.html
export GOPROXY=direct GOSUMDB=off
# nix profile install nixpkgs#glibcLocale
export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"

## Stage 2: Source literally everything else                       ##
if [[ -d "$HOME/.bashbox" ]]; then
  source "$HOME/.bashbox/env"
fi

# handle hostname generation for importing host-specific configs
if [[ $WSL_DISTRO_NAME ]] && [[ $WSL_INTEROP ]]; then
  HOSTNAME_BASH="${HOSTNAME}-wsl-${WSL_DISTRO_NAME}"
  export WSL=1 # similar to CODESPACES and GITPOD_WORKSPACE_ID vars
else
  HOSTNAME_BASH="${HOSTNAME}"
fi

for file in "$HOME/.config/bash/hosts/${HOSTNAME_BASH}.bashrc" "${HOME}/.config/bash/bashrc"; do
    [ -f $file ] && . "$file"
done

