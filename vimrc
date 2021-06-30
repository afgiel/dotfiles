syntax on
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set number
set hlsearch
set ruler
set term=builtin_ansi
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhitespace /\s\+$/
colorscheme default
highlight Pmenu ctermfg=0 ctermbg=1
highlight PmenuSel ctermfg=0 ctermbg=3
highlight TabLine ctermfg=0 ctermbg=3
highlight CursorLine ctermfg=0 ctermbg=5
hi CursorLine ctermfg=white ctermbg=blue
hi StatusLine ctermbg=yellow ctermfg=blue
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
au BufNewFile,BufRead *.ts set syntax=javascript
au BufNewFile,BufRead *.tsx set syntax=javascript
au BufNewFile,BufRead *.jsonnet set syntax=javascript
au BufNewFile,BufRead *.libsonnet set syntax=javascript
set re=0
