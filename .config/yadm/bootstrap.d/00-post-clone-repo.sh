#!/usr/bin/env bash

set -x

if [ ! -d "$HOME/.git" ] && [ -d "$HOME/.local/share/yadm/repo.git" ]; then
    echo "Symlinking ~/.git to ~/.local/share/yadm/repo.git for compatibility"
    ln -s ~/.local/share/yadm/repo.git ~/.git
elif [ -d "$HOME/.git" ] && [ ! -d "$HOME/.local/share/yadm/repo.git" ]; then
    echo "Symlinking ~/.local/share/yadm/repo.git  to ~/.git for compatibility"
    ln -s ~/.git ~/.local/share/yadm/repo.git
fi

echo "Setting git remote URLs to SSH"
git remote set-url --add origin ssh://git@mau.dev/andreijiroh.dev/dotfiles || true
git remote set-url --add hut ssh://git@git.sr.ht/~ajhalili2006/dotfiles || git remote add hut ssh://git@git.sr.ht/~ajhalili2006/dotfiles
