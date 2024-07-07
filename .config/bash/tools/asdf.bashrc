#!/usr/bin/env bash

[ -s "$HOME/.asdf/asdf.sh" ] && source "$HOME/.asdf/asdf.sh"

if [[ $ASDF_DIR ]]; then
  eval "$(direnv hook bash)" # Load up direnv hook after asdf
fi
