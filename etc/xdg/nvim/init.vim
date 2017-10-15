" vim:foldmethod=marker:foldlevel=0

let g:python3_host_prog = '/usr/bin/python3'
"let g:loaded_python_provider = 0


" vim-plug {{{

" set the runtime path to include plug and initialize
source /etc/xdg/nvim/plug.vim

"if empty(glob('~/.vim/autoload/plug.vim'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

call plug#begin('/etc/xdg/nvim/bundle')
  " git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'jreybert/vimagit'

  " editorconfig
  Plug 'editorconfig/editorconfig-vim'

  " autocomplete
  "Plug 'Valloric/YouCompleteMe', { 'on': [], 'do': './install.py --clang-completer --tern-completer' }
  "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
  "Plug 'SirVer/ultisnips', { 'on': [] }
  "Plug 'nvie/vim-flake8'
  "Plug 'davidhalter/jedi-vim'
  "Plug 'ervandew/supertab'
  "Plug 'honza/vim-snippets'
  "Plug 'fatih/vim-go'

  "augroup load_us_ycm
  "  autocmd!
  "  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
  "                     \| autocmd! load_us_ycm
  "augroup END

  " better statusline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " colorscheme
  Plug 'crusoexia/vim-monokai'
  "Plug 'chriskempson/base16-vim'
  Plug 'tomasr/molokai'
  "Plug 'while1eq1/vim-monokai-black'
  "Plug 'sickill/vim-monokai'

  " syntax highlighting
  "Plug 'peterhoeg/vim-qml'
  "Plug 'artoj/qmake-syntax-vim'
  "Plug 'octol/vim-cpp-enhanced-highlight'
  "Plug 'rust-lang/rust.vim'
  "Plug 'tikhomirov/vim-glsl'

  " markdown
  Plug 'gabrielelana/vim-markdown'
  "Plug 'plasticboy/vim-markdown'
  "Plug 'suan/vim-instant-markdown'

  " layout
  Plug 'vim-voom/VOoM'
  Plug 'zhaocai/GoldenView.Vim'

  " navigation/search file
  "Plug 'scrooloose/nerdtree'
  "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  "Plug 'rking/ag.vim'
  "Plug 'dkprice/vim-easygrep'

  " note
  "Plug 'xolox/vim-misc'
  "Plug 'xolox/vim-notes'

  " editing
  "Plug 'scrooloose/nerdcommenter'
  "Plug 'godlygeek/tabular'
  "Plug 'tpope/vim-surround'
  "Plug 'tpope/vim-repeat'
  "Plug 'reedes/vim-pencil'
call plug#end()

" }}} vim-plug

filetype plugin indent on


" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs


" Clipboard {{{
"set clipboard+=unnamedplus
" }}} Clipboard


" Undo {{{
set undodir=~/.config/nvim/undodir
set undofile
set undolevels=100
set undoreload=1000
" }}} Undo


" Colors {{{

" show resolutions:
"    hwinfo --framebuffer
"    cat /sys/class/graphics/fb0/virtual_size
"    tput colors

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
set termguicolors
syntax on
colorscheme monokai

let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
" }}} Colors


if has("autocmd")
  " jump to the last position when reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " load indentation rules and plugins according to the detected filetype
  filetype plugin indent on

  " detect .md as markdown instead of modula-2
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
endif


" Files {{{

" Always utf8
set termencoding=utf-8
" set encoding=utf-8
set fileencoding=utf-8

set noswapfile
"set autowrite              " Automatically save before commands like :next and :make

" }}} Files


" UI Config {{{
set hidden                  " hide instead of unload buffers when they are abandoned, allows to change buffers with unsaved changes
set nonumber                " don't show line numbers
set showcmd                 " show command in bottom bar
"set noshowmode             " hide showmode because of the powerline plugin
set ruler                   " show cursor position (could also use: set statusline+=%F\ %l\:%c)
set cursorline cursorcolumn " highlight line and column with cursor
set showmatch               " highlight matching brace

set colorcolumn=120

set so=5                    " scroll lines above/below cursor
set sidescrolloff=5

set lazyredraw              " make the cursor faster...

set splitright              " set up new vertical splits positions
set splitbelow              " set up new horizontal splits positions
" }}} UI Config


" Search {{{
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set ignorecase              " ignore case when searching
set smartcase               " ignore case if search pattern is lower case
                            " case-sensitive otherwise

" set Ag as the grep command
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif
" }}} Search

" Folding {{{
set foldenable
set foldlevelstart=10       " default folding level when buffer is opened
set foldnestmax=10          " maximum nested fold
set foldmethod=syntax       " fold based on indentation
" }}} Folding


set history=50       " keep 50 lines of command line history


"set linebreak              " Don't wrap words by default

"set textwidth=0

"set viminfo='20,\"50 " read/write a .viminfo file, don't store more than
                      " 50 lines of registers

" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

" Navigation durch die Puffer
map , :bn<CR>
map ; :bprev<CR>

" Ctrl-q == quit
nnoremap <C-q> :q<CR>
