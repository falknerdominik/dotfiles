" KEYBINDINGS

" general settings
set number        " Show linenumber
set ruler         " show ruler
set visualbell    " use visual bell (no beeping)

set wrap          " lines longer than the screen expand on the next line
set linebreak     " break lines at word
set showbreak=+++ " wrap-broken line prefix

set autoindent    " auto-intend new lines
set shiftwidth=2  " if tabstop not set tab = 2 spaces  
set smartindent   " enable smartindent
set smarttab      " enable smart tab
set softtabstop=2 " tab = 2 spaces

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

" Coding
syntax enable			      " Syntax Highlighting
set makeprg=fpc\ -Mtp\ -Criot\ -gl\ % " set :make command

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
