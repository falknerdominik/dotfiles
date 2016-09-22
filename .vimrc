" general settings
set number        " Show linenumber
set relativenumber " show number relative to current one
set ruler         " show ruler
set visualbell    " use visual bell (no beeping)
set novb
set so=20         " scroll page bevore coursair reaches the bottom
syntax enable   " Syntax Highlighting

set wrap          " lines longer than the screen expand on the next line
set linebreak     " break lines at word
set showbreak=<++> " wrap-broken line prefix

set autoindent    " auto-intend new lines
set expandtab
set shiftwidth=4  " if tabstop not set tab = 2 spaces
set smartindent   " enable smartindent
set smarttab      " enable smart tab
set softtabstop=4 " tab = 2 spaces

set hlsearch      " highlight all search results
set smartcase     " enable smart-case search
set ignorecase    " ignore case-sensitive
set incsearch     " searches for strings incrementally

set noswapfile          " no more swap file (prefering git)
set encoding=utf-8      " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
set timeoutlen=400

let mapleader=','
let maplocalleader=','
set pastetoggle=<F2>

" vim-PLUG
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" AIRLINE for the status bar
Plug 'vim-airline/vim-airline'          " airline
Plug 'vim-airline/vim-airline-themes'   " airline-theme
Plug 'unblevable/quick-scope'           " highlight when pressing f in normal mode
Plug 'SirVer/ultisnips'                 " snippet management
Plug 'airblade/vim-gitgutter'           " show git status on left of line
Plug 'tpope/vim-surround'

call plug#end()

" Keybindings
" compile and run mapped to F5
map <F5> :w <CR> :!clear <CR> :make <CR> :!echo "--------------Running---------------"; ./%< <CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Coding
set makeprg=fpc\ -Mtp\ -Criot\ -gl\ % " set :make command

" LaTeX (rubber) macro for compiling
noremap <leader>c :w<CR>:!rubber --pdf --warn all %<CR>

" View PDF macro; '%:r' is current file's root (base) name.
noremap <leader>v :!evince %:r.pdf 2> /dev/null &<CR><CR>


" PLUGIN CONFIG

" AIRLINE config
set t_Co=256 " set terminal colors for airline
set background=dark " set background for airline
let g:airline_powerline_fonts = 1

" the separator used on the right side is none
let g:airline_right_sep=''

" set theme
let g:airline_theme='wombat'

" Always show statusline
set laststatus=2

" UltiSnips config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" make :UltiSnipsEdit split your window.
let g:UltiSnipsEditSplit="vertical"

" Quick Scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" general settings
set number        " Show linenumber
set relativenumber " show number relative to current one
set ruler         " show ruler
set visualbell    " use visual bell (no beeping)
set novb
syntax enable   " Syntax Highlighting

set wrap          " lines longer than the screen expand on the next line
set linebreak     " break lines at word
set showbreak=<++> " wrap-broken line prefix

set autoindent    " auto-intend new lines
set expandtab
set shiftwidth=2  " if tabstop not set tab = 2 spaces
set smartindent   " enable smartindent
set smarttab      " enable smart tab
set softtabstop=2 " tab = 2 spaces

set hlsearch      " highlight all search results
set smartcase     " enable smart-case search
set ignorecase    " ignore case-sensitive
set incsearch     " searches for strings incrementally

set noswapfile          " no more swap file (prefering git)
set encoding=utf-8      " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
set timeoutlen=400

let mapleader=','
let maplocalleader=','
set pastetoggle=<F2>

" vim-PLUG
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" AIRLINE for the status bar
Plug 'vim-airline/vim-airline'          " airline
Plug 'vim-airline/vim-airline-themes'   " airline-theme
Plug 'unblevable/quick-scope'           " highlight when pressing f in normal mode
Plug 'SirVer/ultisnips'                 " snippet management
Plug 'airblade/vim-gitgutter'           " show git status on left of line

call plug#end()

" Keybindings
" compile and run mapped to F5
map <F5> :w <CR> :!clear <CR> :make <CR> :!echo "--------------Running---------------"; ./%< <CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Coding
set makeprg=fpc\ -Mtp\ -Criot\ -gl\ % " set :make command

" LaTeX (rubber) macro for compiling
noremap <leader>c :w<CR>:!rubber --pdf --warn all %<CR>

" View PDF macro; '%:r' is current file's root (base) name.
noremap <leader>v :!evince %:r.pdf 2> /dev/null &<CR><CR>


" PLUGIN CONFIG

" AIRLINE config
set t_Co=256 " set terminal colors for airline
set background=dark " set background for airline
let g:airline_powerline_fonts = 1

" the separator used on the right side is none
let g:airline_right_sep=''

" set theme
let g:airline_theme='wombat'

" Always show statusline
set laststatus=2

" UltiSnips config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" make :UltiSnipsEdit split your window.
let g:UltiSnipsEditSplit="vertical"

" Quick Scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
