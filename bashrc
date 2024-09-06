export SVN_EDITOR=vim
export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
export THOR_MERGE=thor-ksdiff

alias ll='ls -alhFG'
alias ag='ag --pager "less -RFX"'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias ruby-install="ruby-install --cleanup --src-dir /tmp"


PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/bin:$PATH"

set -o vi

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]; then
  source "/opt/homebrew/etc/profile.d/bash_completion.sh"
fi

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.bash 2>/dev/null || :


GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
PS1='\h:\w$(__git_ps1 " [%s]") \$ '

if [ -f $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh ]; then
  source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
fi

# Set the default Ruby. Must be before sourcing auto.sh. Otherwise it will override autodetection in new tabs.
chruby ruby-3.3.5

if [ -f $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh ]; then
  source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh
fi

function dev() {
  if [ $# == 0 ]
  then
    cd ~/Developer
  else
    cd ~/Developer/$1
  fi
}

function _dev() {
  local cur
  cur="${COMP_WORDS[COMP_CWORD]}"

  if [ $COMP_CWORD == 1 ]; then
    COMPREPLY=( $(compgen -W "$(ls ~/Developer)" -- $cur) )
  else
    COMPREPLY=()
  fi
}

complete -F _dev dev


function up() { # cd to root of repository
  old_pwd="$PWD";
  while [ 1 ]; do
    cd ..
    if [ "$PWD" == "/" ]; then
      cd "$old_pwd"
      return 1
    fi
    for repo in ".git" ".hg"; do
      if [ -d "$repo" ]; then
        return 0;
      fi
    done
  done
}
