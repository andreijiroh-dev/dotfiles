#!/usr/bin/env bash
#shellcheck disable=SC1091

# My base bash shell customizations outside Home Manager, to make things
# portable at least.
# SPDX-License-Identifier: MPL-2.0

try_keychain_ssh_agent() {
  if [[ $FF_KEYCHAIN == "1" ]]; then
    echo "[ssh-agent-loader::keychain] attempting to use keychain for SSH agents"
    eval "$(keychain --eval --agents ssh,gpg)"
  fi
}

ssh-agent-loader() {
  if [[ $1 == "" || $1 == "auto" ]]; then
    if [[ $SSH_CONNECTION != "" ]] && [[ $VSCODE_IPC_HOOK_CLI != "" ]]; then
      echo "[ssh-agent-loader] automatic detection disabled while you're in a VS Code Remote SSH session"
      return
    fi

    export OLD_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"

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

# handle
hm-vars-loader() {
  if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
    source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    HM_SESSION_VARS_PATH="$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    HM_SESSION_VARS_LOADED=true
  elif [ -f "$HOME/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh" ]; then
    source "$HOME/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh"
    HM_SESSION_VARS_PATH="$HOME/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh"
    HM_SESSION_VARS_LOADED=true
  elif [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
    source "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
    HM_SESSION_VARS_PATH="/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
    HM_SESSION_VARS_LOADED=true
  else
    HM
  fi
  export HM_SESSION_VARS_LOADED HM_SESSION_VARS_PATH
}

### from Debian and Ubuntu - START ###
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2500
HISTFILESIZE=5000

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
### from Debian and Ubuntu - END ###

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

# Technically a hack in case we don't use home-manager switch
if [ -L "$HOME/.nix-profile" ]  && [ -e "$HOME/.nix-profile" ]; then
  export PATH="$HOME/.nix-profile/bin:$HOME:$PATH"
  hm-vars-loader
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

command -v direnv >> /dev/null && eval "$(direnv hook bash)"
source /home/gildedguy/.config/op/plugins.sh
