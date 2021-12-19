#!/bin/bash

echo "Linking dotfiles dir"
ln -s "$DTTR_OUT" "$HOME/.dotfiles"

echo "Linking individual dotfiles"
cd "$HOME/.dotfiles"
for dir in $(find . -maxdepth 1 -type d -printf "%f\n" | grep -v '\.'); do
  stow -d "$HOME/.dotfiles" -t "$HOME" -S "$dir"
done

ln -s "$HOME/.Xdefaults" "$HOME/.Xresources"

if [ -n "$DISPLAY" ]; then
    echo "Loading X settings"
    xrdb "$HOME/.Xdefaults"
fi

if [ "$TERM" = "xterm-kitty" ]; then
    echo "Reloading kitty terminals"
    kitty @ set-colors -a -c ~/.config/kitty/kitty.conf
fi

if [ -n "$I3SOCK" ]; then
    echo "Reloading i3"
    i3-msg restart &
fi

systemctl --user is-active --quiet emacs
emacs_running=$?

if [ emacs_running = 0 ]; then
    sh -c "doom sync && systemctl --user restart emacs && notify-send 'Emacs finished reloading'" &> /dev/null &
else
    sh -c "doom sync && notify-send 'Emacs finished reloading'" &> /dev/null &
fi

disown

echo "Syncing packer.nvim"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

exit 0
