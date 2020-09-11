syntax on

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre *.c :normal gg=G

set expandtab
set autoindent
set smartindent
set nowrap
set number relativenumber

" Autocompletion in lower menu
set wildmenu
set wildmode=longest:list,full

" Indentation rules
autocmd Filetype c setlocal shiftwidth=4 tabstop=4

set shiftwidth=2
set tabstop=2

" Automatically change directory to open file (buffer)
set autochdir

if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

" Plugged
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'sirver/UltiSnips' | Plug 'honza/vim-snippets'
Plug 'bdebyl/clang_complete'

call plug#end()

nnoremap <silent> <C-o> :Buffers<CR>
nnoremap <silent> <C-p> :let $FZF_DEFAULT_COMMAND='find . -type f -not -path "*.git*"' <bar> Files<CR>
nnoremap <silent> <C-f> :let $FZF_DEFAULT_COMMAND='find ~ -type f -not -path "*.git*"' <bar> Files<CR>
execute "set <M-r>=\er"
nnoremap <silent> <M-r> :browse oldfiles<CR>
nnoremap tn :tabnew<Space>
nnoremap te :tabe<Space>

colorscheme onedark
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0

" Clang Complete Settings
let g:clang_use_library=1
" if there's an error, allow us to see it
let g:clang_periodic_quickfix=0
let g:clang_complete_copen=1
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
" Limit memory use
let g:clang_memory_percent=70
" Remove -std=c++11 if you don't use C++ for everything like I do.
let g:clang_user_options=' -std=c++11 || exit 0'
" Set this to 0 if you don't want autoselect, 1 if you want autohighlight,
" and 2 if you want autoselect. 0 will make you arrow down to select the first
" option, 1 will select the first option for you, but won't insert it unless you
" press enter. 2 will automatically insert what it thinks is right. 1 is the most
" convenient IMO, and it defaults to 0.
let g:clang_auto_select=1

set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
" The single one that works with clang_complete
let g:clang_snippets_engine='ultisnips'

" Allow Ctrl-Tab to go to next snippet completion field or argument
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:terraform_align=1

let g:AutoPairsShortcutFastWrap = '<c-e>'
let g:AutoPairsShortcutBackInsert = '<c-b>'
