#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

install_packages() {
  if command -v brew &>/dev/null; then
    brew install ripgrep fzf node tmux
  elif command -v apt-get &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y ripgrep fzf nodejs npm tmux
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y ripgrep fzf nodejs npm tmux
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm ripgrep fzf nodejs npm tmux
  else
    echo "No supported package manager found (brew, apt, dnf, pacman)" >&2
    exit 1
  fi
}

install_packages

npm install -g eslint_d

ln -sf "$DOTFILES_DIR/vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf

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
