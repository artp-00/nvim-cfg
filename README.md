nvim folder should be in ~/.config/ (using simlink for instance)
add simlink with (from root of this repo):
    ln -s "$(pwd)/nvim" ./config/

this light version doesnt implement lsp support

dependencies:
    neovim
    fd
    ripgrep
