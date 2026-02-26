nvim folder should be in ~/.config/ (using simlink for instance)

add simlink with (from root of this repo):
    ln -s "$(pwd)/nvim" ./config/

dependencies:
    neovim
    fd
    ripgrep

dependencies(heavyweight):
    bear
    clangd
    golang

    
========   ARCHIVED    ========

This repository has been archived because I switched to nixos and transfered all configuration to a private nixos repository.
