export PATH=$HOME/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/usr/local/bin:/usr/local/sbin:$PATH
export SVN_EDITOR=vim
export LC_CTYPE=en_US.UTF-8
export EDITOR=vim

alias ll='ls -alhFG'
alias git=hub
alias ag='ag --pager "less -RFX"'

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  export CPATH=/opt/homebrew/include:$CPATH
  export LIBRARY_PATH=/opt/homebrew/lib:$LIBRARY_PATH
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

if [ -f $HOMEBREW_PREFIX/etc/bash_completion ]; then
  source $HOMEBREW_PREFIX/etc/bash_completion
fi

# ec2 setup
if [ -f ~/.ec2/setup_ec2 ]; then
  source ~/.ec2/setup_ec2
fi

set -o vi

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

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
PS1='\h:\w$(__git_ps1 " [%s]")'

if [[ "online" = "${SANDBOX_MODE_NETWORK:-online}" ]]; then
    PS1+=" 📡"
fi

if [[ -r "$HOME" ]]; then
    PS1+=" 🏠"
fi

PS1+=' \$ '

# jenv
#export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"

if [ -f $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh ]; then
  source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
fi

# Set the default Ruby. Must be before sourcing auto.sh. Otherwise it will override autodetection in new tabs.
chruby ruby-3.1.2

if [ -f $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh ]; then
  source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh
fi

# Wraps docker so you can add custom `docker foo` commands by adding
# `docker-foo` to your path.
docker() {
  if command -v "docker-$1" > /dev/null 2>&1; then
    subcommand=$1
    shift
    docker-$subcommand $@
  else
    command docker $@
  fi
}
