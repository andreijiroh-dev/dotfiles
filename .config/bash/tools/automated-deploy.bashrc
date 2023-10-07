#!/usr/bin/env bash

for file in "${HOME}"/.config/bash/tools/*.bashrc; do
  if [ "$file" == "${HOME}/.config/bash/tools/automated-deploy.bashrc" ]; then
    [[ $DEBUG != "" ]] && echo "avoiding source loop, skipping $file"
  else
    [[ $DEBUG != "" ]] && echo "sourcing $file"
    source "$file"
  fi
done
