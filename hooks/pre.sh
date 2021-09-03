#!/bin/bash

set -euo pipefail

OLDIR="$PWD"
cd "$DTTR_OUT"

if [ -L "$HOME/.Xresources" ]; then
  unlink "$HOME/.Xresources"
fi

# Create directories to symlink single files
for dir in $(find . -type d); do
    _path=$(echo "$dir" | cut -d'/' -f3-)
    c=$(echo "$_path" | wc -m)
    if [ $c -gt 1 ]; then
        abspath="$HOME/$_path"
        [ ! -d "$abspath" ] && mkdir -p "$abspath"
    fi
done

if [ -d "$HOME/.dotfiles" ]; then
  cd "$HOME/.dotfiles"
  for dir in $(find . -maxdepth 1 -type d -printf "%f\n" | grep -v '\.'); do
    stow -D -d "$HOME/.dotfiles" -t "$HOME" "$dir" &> /dev/null
  done

  cd $OLDIR
fi

echo "Unlinking dotfiles dir"
if [ -L "$HOME/.dotfiles" ]; then
  unlink "$HOME/.dotfiles"
fi
