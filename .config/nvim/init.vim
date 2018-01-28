"" Vim-Plug
set nocompatible
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'tpope/vim-speeddating'
Plug 'dhruvasagar/vim-table-mode'
Plug 'jceb/vim-orgmode'
Plug 'farmergreg/vim-lastplace'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'bronson/vim-trailing-whitespace'
"Plug 'vim-scripts/Smart-Tabs', {'for': ['c', 'cpp']}
Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-scripts/grep.vim'
Plug 'Raimondi/delimitMate'
"Plug 'scrooloose/syntastic'

"Plug 'Shougo/vimshell.vim'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"Plug 'junegunn/fzf.vim'

"Plug 'Shougo/vimproc.vim', {'do': 'make'}

"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'majutsushi/tagbar'

"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'


Plug 'xolox/vim-misc'

Plug 'sheerun/vim-polyglot'
Plug 'dag/vim-fish'

Plug 'rust-lang/rust.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ajh17/VimCompletesMe'
Plug 'racer-rust/vim-racer'

" c
Plug 'ericcurtin/CurtineIncSw.vim'
"Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
"Plug 'ludwig/split-manpage.vim'


" lua
"Plug 'xolox/vim-lua-ftplugin'
"Plug 'xolox/vim-lua-inspect'

" perl
Plug 'vim-perl/vim-perl'
Plug 'c9s/perlomni.vim'

" python
"Plug 'davidhalter/jedi-vim'
"Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}


call plug#end()

" Required:
filetype plugin indent on

" call PlugInstall install plugins

"" Basic config
syntax enable


set t_Co=256
let base16colorspace=256
colorscheme selected

"base00=0
"base01=18
"base02=19
"base03=8
"base04=20
"base05=07
"base06=21
"base07=15
"base08=01
"base09=16
"base0A=03
"base0B=02
"base0C=06
"base0D=04
"base0E=05
"base0F=17
hi Normal ctermbg=none
hi NonText ctermbg=none
hi perlRepeat ctermfg=05
hi perlVarPlain ctermfg=03
hi perlStatementStorage ctermfg=05
hi luaIn ctermfg=05
hi luaOperator ctermfg=05

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set number
set relativenumber


set tabstop=4
set shiftwidth=4
"set autoindent
"set smartindent

set noexpandtab  "tell vim to keep tabs instead of inserting spaces
"retab
"set softtabstop=0
"set smarttab
"set noexpandtab
"set cindent

set list
set listchars=eol:\ ,tab:→\ ,trail:·,extends:»,precedes:«
set showbreak=↪

set showcmd
"set nowrap
set spell
set splitbelow
set splitright
"set hidden
set ruler


set hlsearch
set incsearch
set ignorecase
set smartcase

set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

set scrolloff=3       " Show next 3 lines while scrolling.
"set sidescrolloff=5   " Show next 5 columns while side-scrolling.

set laststatus=2

set secure
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set confirm

set mouse=a

let mapleader = "\<Space>"

set cursorline
hi CursorLine ctermbg=18 ctermfg=None

hi OverLength ctermbg=darkgray ctermfg=red
call matchadd('OverLength', '\%81v\+')

"trailing whitespace after non-whitespace
hi TrailingSpaces1 ctermbg=red ctermfg=gray
call matchadd('TrailingSpaces1', '\S\zs\s\+$')
"trailing spaces (always)
hi TrailingSpaces2 ctermbg=red ctermfg=grey
call matchadd('TrailingSpaces1', '\ \+$')

	
  
"		
"	  
	  


"" Misc
let vimDir = '$HOME/.config/nvim'
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



"" Plugin config
"deoplete
autocmd Filetype {c,cpp,rust} call deoplete#enable()

" table-Mode slows down stuff
"autocmd BufRead,BufNewFile *.{org} TableModeEnable
" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermfg=darkgray ctermbg=18
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermfg=darkgray ctermbg=19

"airline
" vim-airline
let g:airline_theme = 'base16_shell'

let g:airline#extensions#whitespace#trailing_format = 'trail[%s]'
let g:airline#extensions#whitespace#long_format = 'long[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'mix[%s]'

let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#capslock#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1

let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

let g:airline_powerline_fonts = 1
let g:airline#extensions#virtualenv#enabled = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline#extensions#whitespace#checks = [ 'mixed-indent-file', 'trailing', 'long' ]
if !exists('g:airline_powerline_fonts')
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = '|'
	let g:airline_left_sep          = '▶'
	let g:airline_left_alt_sep      = '»'
	let g:airline_right_sep         = '◀'
	let g:airline_right_alt_sep     = '«'
	let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
	let g:airline#extensions#readonly#symbol   = '⊘'
	let g:airline#extensions#linecolumn#prefix = '¶'
	let g:airline#extensions#paste#symbol      = 'ρ'
	let g:airline_symbols.linenr    = '␊'
	let g:airline_symbols.branch    = '⎇'
	let g:airline_symbols.paste     = 'ρ'
	let g:airline_symbols.paste     = 'þ'
	let g:airline_symbols.paste     = '∥'
	let g:airline_symbols.whitespace = 'ξ'
else
	let g:airline#extensions#tabline#left_sep = ''
	let g:airline#extensions#tabline#left_alt_sep = ''

	" powerline symbols
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''


	let g:airline_symbols.whitespace = 'Ξ'
	let g:airline_symbols.notexists = ' '
endif

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

"Nerdtree
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"tagbar
let g:tagbar_autofocus = 1
" python
" vim-python
"augroup vimrc-python
"	autocmd!
"	autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
"	  \ formatoptions+=croq softtabstop=4
"	  \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
"augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" syntastic
let g:syntastic_python_checkers=['python', 'flake8']
" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let python_highlight_all = 1




"" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall



"" Keybindings
function IncludeSort()
	normal mfgg}
	let lineNumber = line('.') - 1
	execute '1,' . lineNumber . '!sort -u'
	normal 'f
endfunction

autocmd Filetype {c,cpp} nnoremap <leader><Tab> :call CurtineIncSw()<CR>

cnoremap <C-V> <nop>
noremap <Leader>i :call IncludeSort()<CR>
vnoremap <Leader>i :!sort -u<CR>

noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

nnoremap <silent> <leader>f :Rgrep<CR>

nmap <Leader>ww :set wrap!<CR>
nmap <Leader>s :set spell!<CR>
nmap <Leader>N :NERDTreeFind<CR>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>


"" Close buffer
noremap <leader>c :bd<CR>
"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

nmap <silent> <leader><space> :noh<cr>


"center on find
nnoremap n nzz
nnoremap N Nzz

"maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv
"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

inoremap <C-s> <C-o>:w<CR>
nnoremap <C-s> <Esc>:w<CR>
nnoremap <C-p> "+p
"nnoremap <C-x> "+d
"nnoremap <C-a> ggVG
vnoremap <C-y> "+y
vnoremap <C-d> "+d

"vnoremap <C-v> x"+P
vnoremap <C-c> "+y
"vnoremap <C-x> "+x
inoremap <C-v> <esc>"+pa
inoremap <C-z> <C-o>u
inoremap <C-y> <C-o> <C-r>
nnoremap <C-z> u
vnoremap <C-z> u

nnoremap q: <NOP>
nnoremap Q <NOP>


vnoremap <F2> >gv<
nnoremap <F4> <Esc>:w<CR>:make<CR>
inoremap <F4> <C-o>:w<CR>:make<CR>
noremap <F1> <NOP>

inoremap <F1> <NOP>
inoremap <F2> <NOP>
inoremap <F3> <NOP>
inoremap <F5> <NOP>
inoremap <F6> <NOP>
inoremap <F7> <NOP>
inoremap <F8> <NOP>
inoremap <F9> <NOP>
inoremap <F10> <NOP>
inoremap <F11> <NOP>
inoremap <F12> <NOP>

inoremap <F13> <C-n>
inoremap <C-F13> <C-p>


autocmd Filetype rust nnoremap <F4> :w<CR>:! cargo run<CR>
autocmd Filetype rust nnoremap <F5> :w<CR>:! cargo build<CR>

autocmd Filetype {c,cpp} nnoremap <F4> :w<CR>:! make run<CR>
autocmd Filetype {c,cpp} nnoremap <F5> :w<CR>:! make<CR>




"redraw screen after this
redraw!
redraw!
