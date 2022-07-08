set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.config/nvim/plugged')

" Display
"Plug 'jacoborus/tender.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" nvim-spectre
" nvim-bqf

" Utilities
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
"Plug 'scrooloose/nerdtree'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'mbbill/undotree'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'vuciv/vim-bujo'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Syntax
"Plug 'tweekmonster/gofmt.vim'
Plug 'sheerun/vim-polyglot'
"Plug 'ray-x/go.nvim'
"Plug 'sebdah/vim-delve'
"Plug 'puremourning/vimspector'
"Plug 'mfussenegger/nvim-dap'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hashivim/vim-terraform'
Plug 'towolf/vim-helm'

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

" Gruvbox
let g:gruvbox_contrast_dark = 'hard'

" Terraform
let g:terraform_fmt_on_save = 1


" End of plugin configuration
""""""""""""""

lua require("geckosplinter")

" Color scheme
if (has("termguicolors"))
  set termguicolors
endif
colorscheme gruvbox      "Theme color selection
set background=dark

" General config
syntax on               " Coloration

set updatetime=100      " Add for git gutter
set fileformats=unix    " format des fichier en unix
set number              " Line number
set relativenumber
set ignorecase          " case unsensible search
set autoread            " Auto reload file changed from outside
set encoding=utf-8      " Force encoding
set cursorline          " Highlight curent line
"highlight iCursor guifg=white guibg=steelblue
set colorcolumn=120               " color colonne 120

highlight ColorColumn ctermbg=0 guibg=grey
hi Normal guibg=NONE ctermbg=NONE
"set tw=79               " set text width 79
"set linebreak           " set auto return for 80
set list
" set listchars=tab:»-,trail:¬
set incsearch
set fillchars+=stl:\ ,stlnc:\
set noswapfile
set mouse=a             " activation of the mouse
set cmdheight=2
set updatetime=50
set undodir=~/.vim/undodir
set undofile
set shortmess+=c        " Avoid showing message extra message when using completion

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

" Indent lines
highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine

" yaml fix ident trigger on :
augroup yaml-filetype
    autocmd!
    autocmd FileType yaml setl indentkeys-=<:>
augroup END

highlight Comment cterm=italic gui=italic
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

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Paste replace without modifying register
vnoremap <leader>p "_dP

" delete without modifying register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Visual Search and replace
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Sweet Sweet FuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :Git<CR>
nmap <leader>gp :Git -c push.default=current push<CR>
nmap <leader>gpf :Git -c push.default=current push -f<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

if executable('rg')
    let g:rg_derive_root='true'
endif

nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <F8> :UndotreeToggle<cr>

" nvim completion LSP
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
let g:completion_enable_auto_popup = 0
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" Nvim tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Golang
"autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
"lua require('go').setup()
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)

"" NERDTree configuration
"let NERDTreeIgnore = ['\.pyc$','\.o$','\.so$','\.a$','\.so$','\.o\.fpic$','\.d$']
"let NERDTreeQuitOnOpen = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
"let NERDTreeAutoDeleteBuffer = 1
"nnoremap <Leader>f :NERDTreeToggle<Enter>
"nnoremap <silent> <Leader>v :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
