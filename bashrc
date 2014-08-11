export PATH=/Applications/Postgres.app/Contents/Versions/9.3/bin:/usr/local/bin:/usr/local/sbin:$PATH
export SVN_EDITOR=vim
export LC_CTYPE=en_US.UTF-8
export EDITOR=vim

alias ll='ls -alhFG'
alias git=hub
alias dev='cd ~/Development'

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
PS1='$(rvm_path)\h:\w$(__git_ps1 " [%s]")\$ '

# node.js
if which node >/dev/null 2>&1; then
  PATH=/usr/local/share/npm/bin:$PATH
fi

# virtualenvwrapper
if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
  export WORKON_HOME=~/.virtualenvs
  [[ ! -d $WORKON_HOME ]] && mkdir $WORKON_HOME
  source /usr/local/bin/virtualenvwrapper.sh
fi

# Go
export GOROOT=`brew --prefix go`
export GOPATH=~/Development/gopath

# plan9port
PLAN9=/usr/local/plan9 export PLAN9
PATH=$PATH:$PLAN9/bin export PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# OCaml
if [[ -f /usr/local/bin/opam ]]; then
  eval `opam config env`
fi

# Racket
PATH=$PATH:/Applications/Racket\ v6.1/bin

# Urbit
export URBIT_HOME=/Users/david/Development/urbit/urb

# Cabal
PATH=$HOME/.cabal/bin:$PATH

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
