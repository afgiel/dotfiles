#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

brew install ripgrep
brew install fzf
brew install node

ln -sf "$DOTFILES_DIR/vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/screenrc" ~/.screenrc

if [[ "$(uname)" == "Darwin" ]]; then
  GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
else
  GHOSTTY_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
fi
mkdir -p "$GHOSTTY_DIR"
ln -sf "$DOTFILES_DIR/ghostty-config" "$GHOSTTY_DIR/config"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]; then
  echo '{"dependencies":{}}' > package.json
fi
npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --omit=dev
