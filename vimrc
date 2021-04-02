"""""""""""""""""""""""""""""""""""""""""""""""""""
"   $$$$$$\ $$$$$$$$\ $$$$$$\ $$\   $$\ $$$$$$\
"   $$  __$$\$$  _____$$  __$$\$$ | $$  $$  __$$\
"   $$ /  \__$$ |     $$ /  \__$$ |$$  /$$ /  $$ |
"   $$ |$$$$\$$$$$\   $$ |     $$$$$  / $$ |  $$ |
"   $$ |\_$$ $$  __|  $$ |     $$  $$<  $$ |  $$ |
"   $$ |  $$ $$ |     $$ |  $$\$$ |\$$\ $$ |  $$ |
"   \$$$$$$  $$$$$$$$\\$$$$$$  $$ | \$$\ $$$$$$  |
"    \______/\________|\______/\__|  \__|\______/
"
"                 Configuration Vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

" Display
Plug 'jacoborus/tender.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Utilities
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vuciv/vim-bujo'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pearofducks/ansible-vim'

call plug#end()

set laststatus=2        " Required for powerline


""""""""""""""""""""""""""""""""""""""""""""
"
" Plugin configuration
"
""""""""""""""""""""""""""""""""""""""""""""

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_solarized_dark='dark'
let g:airline_theme = 'gruvbox'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" indent guide
let g:indent_guides_start_level=2

" Golang plugin config
let g:go_fmt_command = "goimports"

" Gruvbox
let g:gruvbox_contrast_dark = 'hard'

" End of plugin configuration
""""""""""""""

" Color scheme
if (has("termguicolors"))
  set termguicolors
endif
colorscheme gruvbox      "Theme color selection
set background=dark
set t_Co=256

" General config
syntax on               " Coloration

set fileformats=unix    " format des fichier en unix
set number              " Line number
set relativenumber
set ignorecase          " case unsensible search
set autoread            " Auto reload file changed from outside
set encoding=utf-8      " Force encoding
set cursorline          " Highlight curent line
set cc=120               " color colonne 120
highlight ColorColumn ctermbg=0 guibg=lightgrey
"set tw=79               " set text width 79
"set linebreak           " set auto return for 80
set list
set listchars=tab:»-,trail:¬     " show $ for space on line end
set incsearch
set fillchars+=stl:\ ,stlnc:\
set noswapfile
set mouse=a             " activation of the mouse
set cmdheight=2
set updatetime=50
set undodir=~/.vim/undodir
set undofile
set shortmess+=c

" Indentation
set tabstop=2           " The lengh of a tab (do not change)
set softtabstop=4       " the number of space for tab
set backspace=2         " set remove 2 carac with backspace
set smarttab
set expandtab           " space instead of tab
set autoindent          " set autoindent
set smartindent
set shiftwidth=2        " nomber of space with < or >

" Plugin vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" yaml fix ident trigger on :
augroup yaml-filetype
    autocmd!
    autocmd FileType yaml setl indentkeys-=<:>
augroup END

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" unactive arrows
map <right> <esc>
map <left> <esc>
map <up> <esc>
map <down> <esc>
imap <right> <esc>
imap <left> <esc>
imap <up> <esc>
imap <down> <esc>

" Sweet Sweet FuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif

nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>

nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <F8> :UndotreeToggle<cr>

" NERDTree configuration
let NERDTreeIgnore = ['\.pyc$','\.o$','\.so$','\.a$','\.so$','\.o\.fpic$','\.d$']
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Go back to previous line from last edit
if has("autocmd")
    filetype plugin indent on
    autocmd FileType text setlocal textwidth=79
    " always jump to last edit position when opening a file
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
endif
