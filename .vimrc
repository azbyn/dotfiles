"try pathogen
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'dag/vim-fish'

":PluginInstall
call vundle#end()
filetype plugin indent on
"redraw!
let base16colorspace=256
colorscheme selected
"colorscheme desert
"cobalt2 badwolf default desert molokai
syntax enable
set showcmd
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set list
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
"set listchars=eol:\ ,tab:→―,trail:·,extends:>,precedes:<
set listchars=eol:\ ,tab:→\ ,trail:·,extends:>,precedes:<
set showbreak=↪
set autoindent
set smartindent
set mouse=a
set linebreak
set breakat=\ ^I!@*-+;:./?\(\{,
set exrc
set secure
set modeline
set spell

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif


set splitbelow
set splitright
let mapleader = "\<Space>"
"airline
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme='base16_shell'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts=1
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

set ttimeoutlen=50

function! WindowNumber(...)
	let builder = a:1
	let context = a:2
	call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
	return 0
endfunction

"au InsertEnter * silent execute "!echo -en \<esc>[5 q"
"au InsertLeave * silent execute "!echo -en \<esc>[2 q"

"let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#checks = [ 'long' ]

call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')
let g:airline#extensions#tabline#buffer_min_count =2
set laststatus=2

highlight OverLength ctermbg=darkgray ctermfg=red
call matchadd('OverLength', '\%81v\+')

"highlight MixedSpaces ctermbg=red ctermfg=gray
"call matchadd('MixedSpaces', ' \+\t\+\|\t\+ \+')

"highlight BeginingSpaces ctermbg=darkgrey ctermfg=gray
"call matchadd('BeginingSpaces', '^ \+')

highlight TrailingSpaces ctermbg=red ctermfg=gray
call matchadd('TrailingSpaces', ' \+$')

let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermfg=darkgrey ctermbg=18
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermfg=darkgrey ctermbg=19

"let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

nmap <silent> <Leader>f :NERDTreeFind<CR>
nmap <Leader>n :NERDTreeToggle<CR>

inoremap <C-s> <C-o>:w<CR>
nnoremap <C-s> <Esc>:w<CR>
nnoremap <C-p> "+p
nnoremap <C-x> "+d
nnoremap <C-a> ggVG
vnoremap <C-y> "+y
vnoremap <C-d> "+d

vnoremap <C-v> x"+P
vnoremap <C-c> "+y
vnoremap <C-x> "+d
inoremap <C-v> <C-o>"+p
inoremap <C-z> <C-o>u
inoremap <C-y> <C-o> <C-r>

nnoremap <C-z> u
vnoremap <C-z> u

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

inoremap <C-J> <C-W><C-J>
inoremap <C-K> <C-W><C-K>
inoremap <C-L> <C-W><C-L>
inoremap <C-H> <C-W><C-H>

vnoremap <F2> >gv<
inoremap <F1> <NOP>
inoremap <F2> <NOP>
inoremap <F3> <NOP>
nnoremap <F04> <Esc>:w<CR>:make<CR>
inoremap <F04> <C-o>:w<CR>:make<CR>
inoremap <F5> <NOP>
nnoremap <F6> <Esc>:set spell!<CR>
inoremap <F6> <C-o>:set spell!<CR>
inoremap <F7> <NOP>
inoremap <F8> <NOP>
inoremap <F9> <NOP>
inoremap <F10> <NOP>
inoremap <F11> <NOP>
inoremap <F12> <NOP>

noremap <F1> <NOP>

nnoremap q: <Nop>
nnoremap Q <nop>
"hardcore mode
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>
