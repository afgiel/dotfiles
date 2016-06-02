set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'davidhalter/jedi-vim'

"All Plugins here"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set number
set hlsearch
set ruler
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhitespace /\s\+$/
colorscheme default
highlight Pmenu ctermfg=0 ctermbg=1
highlight PmenuSel ctermfg=0 ctermbg=3
highlight TabLine ctermfg=0 ctermbg=3
highlight CursorLine ctermfg=0 ctermbg=5
