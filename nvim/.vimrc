" KEYBINDINGS

" general settings
set number        " Show linenumber
set ruler         " show ruler
set visualbell    " use visual bell (no beeping)

set wrap          " lines longer than the screen expand on the next line
set linebreak     " break lines at word
set showbreak=+++ " wrap-broken line prefix

set autoindent    " auto-intend new lines
set shiftwidth=4  " if tabstop not set tab = 2 spaces  
set smartindent   " enable smartindent
set smarttab      " enable smart tab
set softtabstop=4 " tab = 2 spaces

set hlsearch      " highlight all search results
set smartcase     " enable smart-case search
set ignorecase    " ignore case-sensitive
set incsearch     " searches for strings incrementally

set noswapfile	  " no more swap file (prefering git)

" coloscheme
" set t_Co=256
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized

" compile and run mapped to F5
map <F5> :w <CR> :!clear <CR> :make <CR> :!echo "--------------Running---------------"; ./%< <CR>

" press <esc> to hide search markup
" nnoremap <silent> <esc> :nohlsearch<esc>

call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-surround'
  Plug 'unblevable/quick-scope'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'matchit.zip'
  Plug 'othree/html5.vim'
call plug#end()

" airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'wombat'
let g:airline_powerline_fonts = 1
set t_Co=256 " show colors

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" quickscope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Coding
syntax enable			      " Syntax Highlighting
set makeprg=fpc\ -Mtp\ -Criot\ -gl\ % " set :make command

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
