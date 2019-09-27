#!/bin/sh

pushd `dirname $0` > /dev/null
DIR=`pwd`
popd > /dev/null

DOTFILES="
  bash_profile
  bashrc
  ctags
  editrc
  gdbinit
  gemrc
  gitconfig
  gitignore_global
  gvimrc
  inputrc
  ocamlinit
  sqliterc
  tmux.conf
  vimrc
  vim
"

for f in $DOTFILES; do
  ln -s "$DIR/$f" "~/.$f"
done

mkdir -p ~/bin

for f in $DIR/bin/*; do
  ln -s "$f" ~/bin
done
