#!/usr/bin/env bash

if [[ -d "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] && [[ $FF_DISABLE_NIXPKGS != "true" ]]; then
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

if command -v devbox >> /dev/null; then
  eval "$(devbox global shellenv)"
fi