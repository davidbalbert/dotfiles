#!/bin/sh

pushd `dirname $0` > /dev/null
DIR=`pwd`
popd > /dev/null

DEST=${DEST:-~}

DOTFILES="
  bash_profile
  bashrc
  ctags
  editrc
  editorconfig
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
  zprofile
"

for f in $DOTFILES; do
  ln -sfn "$DIR/$f" "$DEST/.$f"
done

mkdir -p "$DEST/bin"

for f in $DIR/bin/*; do
  ln -sfn "$f" "$DEST/bin"
done
