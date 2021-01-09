syntax on
set nocompatible
filetype plugin on

" Plugged
call plug#begin('~/.vim/plugged')
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'bdebyl/clang_complete'
Plug 'bfrg/vim-cpp-modern'
Plug 'chr4/nginx.vim'
Plug 'davidhalter/jedi-vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'farmergreg/vim-lastplace'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'nvie/vim-flake8'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/nerdcommenter'
Plug 'qpkorr/vim-bufkill'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/syntastic'
Plug 'sirver/UltiSnips' | Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'
call plug#end()

" Indentation rules
autocmd Filetype c setlocal shiftwidth=4 tabstop=4
" clang-format
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType c ClangFormatAutoEnable
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
" Auto-wrap markdown files after 80 chars
autocmd BufNewFile,BufRead *.md,*.wiki set tw=79
" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" pep-8 spacing/width
autocmd BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix

set hlsearch
set autoindent
set expandtab
set nowrap
set number relativenumber
set smartindent
" Autocompletion in lower menu
set wildmenu
set wildmode=longest:list,full
set shiftwidth=2
set tabstop=2
" Automatically change directory to open file (buffer)
set autochdir
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

execute "set <M-r>=\er"
nnoremap <silent> <C-f> :let $FZF_DEFAULT_COMMAND='find ~ -type f -not -path "*.git*"' <bar> Files<CR>
nnoremap <silent> <C-o> :Buffers<CR>
nnoremap <silent> <C-p> :let $FZF_DEFAULT_COMMAND='find . -type f -not -path "*.git*"' <bar> Files<CR>
nnoremap <silent> <M-r> :browse oldfiles<CR>
nnoremap te :tabe<Space>
nnoremap tn :tabnew<Space>
nnoremap <Leader>tf :TableFormat<CR>
" d[elete] (/)search ; clears highlighting
nnoremap d/ :let @/ = ""<CR>
nnoremap <Leader>ic i/* Copyright <C-R>=strftime('%Y')<C-M> Bastian de Byl*/<CR><ESC>

nmap ga <Plug>(EasyAlign)
imap <C-c> <plug>NERDCommenterInsert
xmap ga <Plug>(EasyAlign)

" Requires vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0

" Clang Complete Settings
let g:clang_use_library=1
let g:clang_use_quickfix=0
let g:clang_periodic_quickfix=0
let g:clang_complete_copen=0
let g:clang_close_preview=1
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
let g:clang_memory_percent=70
let g:clang_user_options=' -std=c99 || exit 0'
let g:clang_auto_select=0
" set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='ultisnips'

" Allow Ctrl-Tab to go to next snippet completion field or argument
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:terraform_align=1

let g:AutoPairsShortcutFastWrap = '<c-e>'
let g:AutoPairsShortcutBackInsert = '<c-b>'
let g:AutoPairsMapCR = 0

let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_include_dirs = ['/usr/arm-none-eabi/include/libopencm3']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ["python"], 'passive_filetypes': ["c"] }

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

let g:vimwiki_list = [{'auto_diary_index': 1, 'template_default': 'default', 'template_ext': 'html', 'template_path': '$HOME/vimwiki/templates'}]

colorscheme onedark
