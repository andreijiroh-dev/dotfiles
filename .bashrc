#!/usr/bin/env bash
#shellcheck disable=SC1091

# My base bash shell customizations outside Home Manager, to make things
# portable at least.
# SPDX-License-Identifier: MPL-2.0

# do feature detection if keychain is installed
if command -v keychain >> /dev/null; then
  FF_KEYCHAIN=1
else
  FF_KEYCHAIN=0
fi

try_1password_ssh_agent() {
  export OP_SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
  if [[ ! -S "$OP_SSH_AUTH_SOCK" ]]; then
    echo "[ssh-agent-loader::1password] 1Password SSH agent isn't enabled or desktop app isn't installed yet"
    return 1
  fi

  echo "[ssh-agent-loader::1password] attempting to use 1Password SSH agent"
  if ! SSH_AUTH_SOCK=$OP_SSH_AUTH_SOCK ssh-add -l >> /dev/null 2>&1; then
    echo "[ssh-agent-loader::1password] something went wrong while checking for 1Password SSH agent availability"
    echo "[ssh-agent-loader::1password] unlock the desktop app first or enable SSH agent from settings"
    return 1
  fi
  export SSH_AUTH_SOCK=$OP_SSH_AUTH_SOCK
  unset OP_SSH_AUTH_SOCK
}

try_keychain_ssh_agent() {
  if [[ $FF_KEYCHAIN == "1" ]]; then
    echo "[ssh-agent-loader::keychain] attempting to use keychain for SSH agents"
    eval "$(keychain --eval --agents ssh,gpg)"
  fi
}

ssh-agent-loader() {
  if [[ $1 == "" || $1 == "auto" ]]; then
    unset SSH_AGENT_PID SSH_AUTH_SOCK
    if try_1password_ssh_agent; then
      return
    elif try_keychain_ssh_agent; then
      return
    else
      echo "[ssh-agent-loader] SSH agent seems to be failed to load at the moment"
      echo "[ssh-agent-loader] try again later by manually invoking the shell function"
      return 1
    fi
  elif [[ $1 == "1passowrd" || $1 == "op" ]]; then
    unset SSH_AGENT_PID SSH_AUTH_SOCK
    try_1password_ssh_agent
  elif [[ $1 == "keychain" ]]; then
    try_keychain_ssh_agent
  else
    echo "ssh-agent-loader [auto|[1password|op|1p]|keychain]"
    return 1
  fi
}

command -v direnv >> /dev/null && eval "$(direnv hook bash)"

# Technically a hack in case we don't use home-manager switch
if [ -L "$HOME/.nix-profile" ]  && [ -e "$HOME/.nix-profile" ]; then
  export PATH="$HOME/.nix-profile/bin:$HOME:$PATH"
  if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
  # Don't return yet, since we still do some stuff after that.
  #return
  fi
fi

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export DOCKER_BUILDKIT=1

# Check if we're running bash shell inside VS Code and update EDITOR and
# GIT_EDITOR accordingly. We'll probably figure it out for desktop, but in the
# meanwhile, just stick to nano at the moment.
if [[ -n $VSCODE_IPC_HOOK_CLI ]]; then
  EDITOR="code --wait"
  ssh-agent-loader auto
elif [[ -n "$SSH_CONNECTION" ]]; then
  EDITOR="nano"
  ssh-agent-loader keychain
else
  EDITOR="nano"
  ssh-agent-loader auto
fi
export EDITOR GIT_EDITOR=$EDITOR
