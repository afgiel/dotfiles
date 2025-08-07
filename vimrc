set nocompatible
filetype plugin indent on
syntax enable
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set number
set hlsearch
set ruler
set term=builtin_ansi
set re=0
set nobackup
set nowritebackup
set noswapfile
set noundofile

" Set encoding
set encoding=utf-8

" Colors and highlighting
colorscheme default
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhitespace /\s\+$/
highlight Pmenu ctermfg=0 ctermbg=1
highlight PmenuSel ctermfg=0 ctermbg=3
highlight TabLine ctermfg=0 ctermbg=3
highlight CursorLine ctermfg=0 ctermbg=5
hi CursorLine ctermfg=white ctermbg=blue
hi StatusLine ctermbg=yellow ctermfg=blue

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Install Plug if not already installed
call plug#begin('~/.vim/plugged')

" Install ALE plugin
Plug 'dense-analysis/ale'

" Call plug#end to complete plugin installation
call plug#end()

" Enable ALE for linting
let g:ale_enabled = 1

" Use ESLint for linting TypeScript files
let g:ale_linters = {
\   'typescript': ['tsserver', 'eslint'],
\   'typescriptreact': ['tsserver', 'eslint'],
\}

" Disable Automatic Typing Acquisition for quicker startup
let g:ale_typescript_tsserver_options = '--disableAutomaticTypingAcquisition'

" ESLint setup for faster linting with eslint_d
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_options = '--ext .tsx,.ts'

" ALE options
let g:ale_history_log_output=1
let g:ale_log_to_file=1
let g:ale_log_file_path = $HOME . '/ale.log'
let g:ale_sign_error = '▻'
let g:ale_sign_warning = '•'
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 100
let g:ale_virtualtext_cursor = 'disabled'

" ALE fixers
let g:ale_fix_on_save = 1
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint', 'prettier']
let g:ale_fixers.css = ['prettier']

" Key mappings for ALE error navigation
nnoremap <C-j> :ALEPreviousWrap<cr>
nnoremap <C-k> :ALENextWrap<cr>
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight clear ALEWarningSign

" Text and auto-save settings
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c

" Always show the signcolumn, so it doesn't shift text
set signcolumn=number

" Configure `CtrlP` for fuzzy file finding
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Custom filetype handling (TypeScript, etc.)
au BufNewFile,BufRead *.ts set syntax=typescript
au BufNewFile,BufRead *.tsx set syntax=typescriptreact

" Additional CoC configuration (optional, based on old vimrc)
let $TSC_WATCHFILE = 'PriorityPollingInterval'

" Key mappings for CoC
" Define key mappings for navigating and applying code actions (optional)
nmap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nmap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nmap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" Use Tab for completion trigger and navigation
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make Enter auto-select the first completion item and format on Enter
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the CoC floating dialog and selected item
highlight CocMenuSel ctermfg=white ctermbg=blue guifg=white guibg=blue
highlight CocMenu ctermfg=black ctermbg=grey guifg=black guibg=grey

" Other CoC related mappings for format, code actions, etc.
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')
