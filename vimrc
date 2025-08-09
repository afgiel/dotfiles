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

" highlights
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhitespace /\s\+$/
highlight TabLine ctermfg=0 ctermbg=3
highlight CursorLine ctermfg=0 ctermbg=5
hi CursorLine ctermfg=white ctermbg=blue
hi StatusLine ctermbg=yellow ctermfg=blue
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight clear ALEWarningSign
highlight Pmenu ctermfg=blue ctermbg=yellow guifg=blue guibg=yellow
highlight PmenuSel ctermfg=white ctermbg=blue guifg=white guibg=blue
highlight CocMenu ctermfg=blue ctermbg=yellow guifg=blue guibg=yellow
highlight CocMenuSel ctermfg=white ctermbg=blue guifg=white guibg=blue
highlight CocSearch ctermfg=red ctermbg=yellow guifg=red guibg=yellow
highlight CocFloating ctermfg=blue ctermbg=yellow guifg=blue guibg=yellow

" gb is 'go back'
nmap <silent> gb :b#<cr>

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
\   'python': ['flake8'],
\}

" Disable Automatic Typing Acquisition for quicker startup
let g:ale_typescript_tsserver_options = '--disableAutomaticTypingAcquisition'

" ESLint setup for faster linting with eslint_d
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_options = '--ext .tsx,.ts'

" Configure flake8 to ignore line length (E501) and other common style issues
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8 --ignore=E501,W503,E266 --max-line-length=999'

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

" ALE navigation
nmap <silent> gd :vsplit<cr>:ALEGoToDefinition<cr>
nmap <silent> gt :ALEGoToDefinition<cr>
nmap <silent> gy :ALEGoToTypeDefinition<cr>
nmap <silent> gr :ALEFindReferences<cr>
nmap <silent> gh :ALEHover<cr>

" Key mappings for ALE error navigation
nnoremap <C-j> :ALEPreviousWrap<cr>
nnoremap <C-k> :ALENextWrap<cr>

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

" Use Tab for completion trigger and navigation
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make Enter auto-select the first completion item and format on Enter
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Other CoC related mappings for format, code actions, etc.
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" ALE Status function
function! ALEStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  " Show loading status
	if ale#engine#IsCheckingBuffer(bufnr(''))
    let l:frames = ['🐌', '.🐌', '..🐌', '...🐌', '.....🐌', '......🐌']
    let l:frame_idx = str2nr(strftime('%S')) % 6
    return l:frames[l:frame_idx]
  endif

  " Show results
  if l:counts.total == 0
    return '✅'
  else
    return printf('%d⚠ %d🚨', l:all_non_errors, l:all_errors)
  endif
endfunction

" Set statusline with ALE status
set laststatus=2
set statusline=%f\ %m%r%h%w\ %{ALEStatus()}%=%l,%c\ %p%%
