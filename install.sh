#!/bin/sh

if [ -d "$HOME/.config/nvim" ]; then
    read -p "Neovim config detected are you sure you want to override it ? (Ctrl-C if no)" -n1 -s
    rm -r "$HOME/.config/nvim"
fi

echo ""

ln -s "$(pwd)/nvim" ~/.config/

echo "done"
