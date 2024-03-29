export PATH=$HOME/bin:/Applications/Postgres.app/Contents/Versions/13/bin:/usr/local/bin:/usr/local/sbin:$PATH
export SVN_EDITOR=vim
export LC_CTYPE=en_US.UTF-8
export EDITOR=vim

alias ll='ls -alhFG'
alias git=hub
alias ag='ag --pager "less -RFX"'

function dev() {
  if [ $# == 0 ]
  then
    cd ~/Development
  else
    cd ~/Development/$1
  fi
}

function _dev() {
  local cur
  cur="${COMP_WORDS[COMP_CWORD]}"

  if [ $COMP_CWORD == 1 ]; then
    COMPREPLY=( $(compgen -W "$(ls ~/Development)" -- $cur) )
  else
    COMPREPLY=()
  fi
}

complete -F _dev dev

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
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
PS1='\h:\w$(__git_ps1 " [%s]")\$ '

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

source /usr/local/opt/chruby/share/chruby/chruby.sh
# Set the default Ruby. Must be before sourcing auto.sh. Otherwise it will override autodetection in new tabs.
chruby ruby-3.0.2

source /usr/local/opt/chruby/share/chruby/auto.sh

if [[ -f /usr/local/bin/aws ]]; then
  complete -C aws_completer aws
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

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/david/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

