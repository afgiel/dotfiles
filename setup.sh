set -e

brew install ripgrep
brew install fzf
brew install node

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~/.vim

# ale
mkdir -p ~/.vim/pack/git-plugins/start
git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale

mkdir -p ~/.vim/pack/coc/start
cd ~/.vim/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi

npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# elixir
git clone https://github.com/elixir-editors/vim-elixir.git ~/.vim/pack/my-packages/start/vim-elixir
