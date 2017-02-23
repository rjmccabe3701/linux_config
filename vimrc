"""" FROM https://github.com/VundleVim/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'powerline/fonts'
"Look into this: Plugin 'xolox/vim-session'
Plugin 'sudo.vim'
"TODO: might be vim-airline/vim-airline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'easymotion/vim-easymotion'
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'shougo/neocomplete.vim'
Plugin 'tpope/vim-markdown'
Plugin 'chazy/cscope_maps'
Plugin 'nvie/vim-flake8'
"Look into these:
"Plugin 'xolox/vim-session'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'tpope/vim-abolish'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""""""""""""""""""""""""

scriptencoding utf-8
set encoding=utf-8
let mapleader = ','

"Pretty tabbing thru files
let g:airline#extensions#tabline#enabled = 1

set nobackup
set noswapfile

"Easy opening of directories
" From:
" http://stackoverflow.com/questions/1708623/opening-files-in-the-same-folder-as-the-current-file-in-vim
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

"let g:NERDTreeDirArrows=0

"Fix C++ indentation
" g0 -- public and private now are not indented;
" +0 -- *mostly* fixes the unwanted template indentation, it still
"       gets messed up when inside a namespace and if the template
"       args span more than 1 line ... grrrr.  It looks like this is
"       a known issue:
"       https://github.com/vim-scripts/google.vim/blob/master/indent/google.vim
"
" N-s -- don't intent inside namespaces
set cino=g0,+0,N-s

"Don't let the surround plugin re-format code
" This is annoying when trying to block comment stuff
let g:surround_indent=0

"Dont create ~ files
set nobackup
"
""Dont create swap files
set noswapfile"

autocmd FileType make setlocal noexpandtab
autocmd FileType cpp setlocal expandtab shiftwidth=3 softtabstop=3
autocmd FileType c setlocal noexpandtab shiftwidth=3 softtabstop=3


"Control-C copies visual selection
vmap <C-C> "+y
"Control-V pastes in control and insert mode
map <C-V>               "+gP
imap <C-V>  <ESC>"+gpa

"from http://vim.wikia.com/wiki/Show_current_function_name_in_C_programs
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

map <F2> :call ShowFuncName() <CR>

noremap \ ,

" Allow Tab toggling between linux and Rockwell Standards
function! TabToggle()
  if &expandtab
    set shiftwidth=4
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=3
    set softtabstop=3
    set expandtab
  endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z

"Disable the annoying tab colors
let g:indent_guides_enable_on_vim_startup = 0

"Enable vim-airline status line (without having to split)
set laststatus=2

"source ~/scripts/cscope_maps.vim

"Regenerate cscope database
nmap <F11> :!find $(pwd) -iname '*.c' -o -iname '*.cpp' -o -iname '*.cc' -o -iname '*.h' -o -iname '*.hpp' -o -iname '*.inl' > cscope.files<CR>
  \:!cscope -b -i cscope.files -f cscope.out<CR>
  \:cs reset<CR>


"Disables auto completions ( you can still use TAB to autocomplete )
"let g:neocomplcache_disable_auto_complete = 1
":call NeoCompleteLock()
"NOTE: to select an item hit <TAB> again
let g:neocomplete#disable_auto_complete = 1

"Escape no longer undoes the selection we just made ...
inoremap <expr> <Esc>  pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"

"Now Shift-Tab inserts a tab
inoremap <S-Tab> <S-Tab>

"The Status bar is too busy, this fixes that
let g:airline_extensions = []
let g:airline_theme = "wombat"


syntax enable
let g:solarized_termcolors=256
colorscheme solarized

"Block comment code in C/C++
autocmd FileType cpp,c let b:surround_45 = "#if 0\n\r\n#endif\n"

let NERDSpaceDelims = 1

set diffopt=filler,vertical

"MUCH better mouse control of the terminal
"  from http://usevim.com/2012/05/16/mouse/
"  and
"  http://stackoverflow.com/questions/7000960/in-vim-why-doesnt-my-mouse-work-past-the-220th-column
set ttyfast
set mouse=a
set ttymouse=sgr

"Use Space/Shift-Tab key to switch between tabs
nmap <space> gt
nmap <S-Tab> gT

"from http://vimawesome.com/plugin/easymotion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
""""""""""""""""""""""""

"Stops vim from hiding quotes in json files
set conceallevel=0

let g:airline_powerline_fonts = 1
set mouse=a                 " Automatically enable mouse usage
set history=1000                    " Store a ton of history (default is 20)
set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set tabstop=3                   " An indentation every three columns

function! StripTrailingWhitespace()
   " Preparation: save last search, and cursor position.
   let _s=@/
   let l = line(".")
   let c = col(".")
   " do the business:
   %s/\s\+$//e
   " clean up: restore previous search history, and cursor position
   let @/=_s
   call cursor(l, c)
endfunction

autocmd FileType c,cpp,java,python,bash,zsh autocmd BufWritePre <buffer> call StripTrailingWhitespace()
set background=dark
