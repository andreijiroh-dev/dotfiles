#!/usr/bin/env bash

if [[ $DEBUG != "" ]]; then
  set -x
fi

if [ ! -d "$HOME/.git" ] && [ -d "$HOME/.local/share/yadm/repo.git" ]; then
    echo "[git-symlinks] Symlinking ~/.git to ~/.local/share/yadm/repo.git for compatibility"
    ln -s ~/.local/share/yadm/repo.git ~/.git
elif [ -d "$HOME/.git" ] && [ ! -d "$HOME/.local/share/yadm/repo.git" ]; then
    echo "[git-symlinks] Symlinking ~/.local/share/yadm/repo.git  to ~/.git for compatibility"
    ln -s ~/.git ~/.local/share/yadm/repo.git
else
    echo "[git-symlinks] Looks like everything is all clear on git"
fi

echo "[git-remotes] Setting git remote URLs to SSH"
git remote set-url --add --push hut ssh://git@git.sr.ht/~ajhalili2006/dotfiles \
  || git remote add hut https://git.sr.ht/~ajhalili2006/dotfiles \
  && git remote set-url --add --push hut ssh://git@git.sr.ht/~ajhalili2006/dotfiles
