" general settings
set number        " Show linenumber
set relativenumber " show number relative to current one
set ruler         " show ruler
set visualbell    " use visual bell (no beeping)
set t_vb=           " set no visual bell effect
set so=20         " scroll page before coursair reaches the bottom
set sidescrolloff=20 " horizontal scroll offset
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
set timeoutlen=500      " set timeout for command (for example leader)

let mapleader=','       " set leader
let maplocalleader=','

set showcmd             " show command in lower righthand corner
set pastetoggle=<F2>    " toggle paste mode with F2


" Keybindings
    " compile and run mapped to F5
    map <F5> :w <CR> :!clear <CR> :make <CR> :!echo '--------------Running---------------'; :!make.sh\ run <CR>

    " Allow saving of files as sudo when I forgot to start vim using sudo.
    cmap w!! w !sudo tee > /dev/null %

    " Make
      set makeprg=./make.sh\ build

    " LaTeX (rubber) macro for compiling
    nmap <leader>c :w<CR>:!rubber --warn all --pdf %<CR>

    " View PDF macro; '%:r' is current file's root (base) name.
    nmap <leader>v :!evince %:r.pdf 2> /dev/null &<CR><CR>

" vim-PLUG
call plug#begin('~/.vim/plugged')

    Plug 'vim-airline/vim-airline'          " airline
    Plug 'vim-airline/vim-airline-themes'   " airline-theme
    Plug 'unblevable/quick-scope'           " highlight when pressing f in normal mode
    Plug 'SirVer/ultisnips'                 " snippet management
    Plug 'airblade/vim-gitgutter'           " show git status on left of line
    Plug 'tpope/vim-surround'               " change surroundings of anything
    Plug 'kien/ctrlp.vim'                   " fuzzy search
    Plug 'tomtom/tcomment_vim'              " comment everywhere
    Plug 'rust-lang/rust.vim'               " support for rust language
    Plug 'scrooloose/syntastic'             " syntax checker

call plug#end()


" PLUGIN CONFIG

    " AIRLINE config
    set t_Co=256 " set terminal colors for airline
    set background=dark " set background for airline
    let g:airline_powerline_fonts = 1
    let g:airline_right_sep='' " the separator used on the right side is none
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='wombat' " set theme
    set laststatus=2 " Alwayr show statusline


    " UltiSnips config
    "let g:UltiSnipsExpandTrigger="<tab>"
    "let g:UltiSnipsJumpForwardTrigger="<c-b>"
    "let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " make :UltiSnipsEdit split your window.
    "let g:UltiSnipsEditSplit="vertical"

    " Quick Scope
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    
    " ctrlp - fuzzy search
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'

    " syntastic config
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
