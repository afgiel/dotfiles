set -e 

# ctrl p 
cd ~/.vim
git clone https://github.com/ctrlpvim/ctrlp.vim.git bundle/ctrlp.vim

# ale 
mkdir -p ~/.vim/pack/git-plugins/start
git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
    # Or use package manager, e.g.
    # sudo apt-get install nodejs
fi

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

