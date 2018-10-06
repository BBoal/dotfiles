#! /bin/zsh

# Update homebrew
brew update
brew upgrade

# update oh-my-zsh
zsh $ZSH/tools/upgrade.sh

# update vim plugins
nvim +PlugUpgrade +PlugUpdate +qall

# update mail
offlineimap

# update rust build tools
rustup update stable
rustup update nightly

# update alacritty
cd ~/Documents/Projects/others/clones/alacritty && git pull origin master && make app && cp -r target/release/osx/Alacritty.app /Applications/ && cd -
