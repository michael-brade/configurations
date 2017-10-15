"set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let $NVIM_PYTHON_LOG_FILE="~/.nvimlog-python"
"let g:python3_host_prog = '/usr/bin/python3'
"let g:loaded_python_provider = 0

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.

set noignorecase	" Do case sensitive matching

set smartcase		" Do smart case matching
set incsearch		" Incremental search

set mouse=n
"set mouse=a		" Enable mouse usage (all modes)

set noexpandtab
set shiftwidth=4
set tabstop=4

set esckeys		" Cursortasten in insertmode
set ruler		" show the cursor position all the time

set hlsearch		" kein HL bei Search
set hidden		" Hide buffers when they are abandoned
set noinsertmode	" do not stay in insertmode
set magic		" RegExp's bei Search
set nonumber		" keine Zeilennummern

set cursorline

set report=0		" show all changes
set shortmess=tI
set nostartofline


set splitbelow
set textwidth=0

set ttyfast
 
set directory=/var/tmp

set cpoptions="aABceFs<"


if has("autocmd")
  filetype plugin indent on
endif

"set autowrite		" Automatically save before commands like :next and :make

"set linebreak		" Don't wrap words by default

"set autoindent
"set backspace=indent,eol,start	" more powerful backspacing
"set textwidth=0

"set viminfo='20,\"50	" read/write a .viminfo file, don't store more than
			" 50 lines of registers
"set history=50		" keep 50 lines of command line history


" Navigation durch die Puffer
map , :bn
map ; :bprev
 
" Tastaturbelegung
map [H 0
map [F $

" copy from/to klipper
imap <F5> <ESC>"*p
nmap <F5> "*y
vmap <F5> "*y

" Emacs Style
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
" cnoremap <C-B>      <Del>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <End>
cnoremap <C-P>      <Up>
cnoremap <ESC>b     <S-Left>
cnoremap <ESC><C-B> <S-Left>
cnoremap <ESC>f     <S-Right>
cnoremap <ESC><C-F> <S-Right>
cnoremap <ESC><C-H> <C-W>
		      

" Tips aus dem Netz
map , :bn
map ; :bprev
map =i :r $HOME/.include.headers
map =dd :!rm %:n
map =f !}fmt
map =s :r ~/.Signatur
map =w :w:n
map =c >>d0:co.k:s/./x/g40A x0791D:s/x//gJ
map V :w:!ispell -x %:e!



syntax on

colorscheme molokai
"colorscheme monokai

" monokai config

let g:monokai_italic = 1

" Use thick window border:

let g:monokai_thick_border = 1

" Use zen tree:

let g:monokai_zentree = 1


execute pathogen#infect()


" syntastic plugin config

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

highlight SyntasticErrorSign guifg=white guibg=red
highlight SyntasticErrorLine guibg=#2f0000

"let g:syntastic_quiet_messages = {                                                                                                                                                                                  
"        \ "regex":   'Use ` to begin quotation',
"        \ "file:p":  '.tex$' } 



" spellchecking with vimchant

highlight SpellBad cterm=underline ctermbg=bg ctermfg=Red gui=undercurl guisp=Red
