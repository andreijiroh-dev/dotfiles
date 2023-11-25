#!/usr/bin/env sh

if [ ! -d "$HOME/.git" ]; then
    echo "Symlinking ~/.git to ~/.local/share/yadm/repo.git for compatibility"
    ln -s ~/.local/share/yadm/repo.git ~/.git
fi

git remote set-url origin ssh://git@mau.dev/andreijiroh.dev/dotfiles
git remote add hut ssh://git@git.sr.ht/~ajhalili2006/dotfiles