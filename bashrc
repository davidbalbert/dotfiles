export PATH=$HOME/bin:/Applications/Postgres.app/Contents/Versions/10/bin:/usr/local/bin:/usr/local/sbin:$PATH
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

# path prompt
rvm_path() {
  local prompt=$(~/.rvm/bin/rvm-prompt)
  if [[ $prompt != "" ]]; then
    printf "[$prompt] "
  fi
}

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
PS1='\h:\w$(__git_ps1 " [%s]")\$ '

# plan9port
PLAN9=/usr/local/plan9 export PLAN9
PATH=$PATH:$PLAN9/bin export PATH

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

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

# Run if acme is running ($acme is set by ~/bin/a)
if [ "$acme" = "true" ]; then
  PS1="\$ "
  EDITOR=E

  cd ()
  {
    __zsh_like_cd cd "$@"
    awd
  }
fi

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/david/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;