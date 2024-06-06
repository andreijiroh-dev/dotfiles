#!/usr/bin/env bash

export DENO_INSTALL="$HOME/.deno"
[ -d "$DENO_INSTALL/bin" ] && export PATH="$DENO_INSTALL/bin:$PATH"