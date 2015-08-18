#!/bin/sh

pushd `dirname $0` > /dev/null
DIR=`pwd`
popd > /dev/null

DOTFILES="
  bash_profile
  bashrc
  ctags
  editrc
  gemrc
  gvimrc
  inputrc
  ocamlinit
  tmux.conf
  vimrc
  vim
"

NON_DOTFILES="
  lib
"

for f in $DOTFILES; do
  ln -s $DIR/$f ~/.$f
done

for f in $NON_DOTFILES; do
  ln -s $DIR/$f ~/$f
done

mkdir -p ~/bin

for f in `ls $DIR/bin`; do
  ln -s $DIR/bin/$f ~/bin/$f
done
