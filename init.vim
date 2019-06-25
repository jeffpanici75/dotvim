let mapleader = ","

call plug#begin('~/.vim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree'

Plug 'airblade/vim-gitgutter'

Plug 'craigemery/vim-autotag'

Plug 'benizi/vim-automkdir'

Plug 'easymotion/vim-easymotion'

Plug 'editorconfig/editorconfig-vim'

Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'

Plug 'justinmk/vim-dirvish'

Plug 'matze/vim-move'

Plug 'ntpeters/vim-better-whitespace'

Plug 'rhysd/conflict-marker.vim'

Plug 'sbdchd/neoformat'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'trevordmiller/nova-vim'

Plug 'whatyouhide/vim-lengthmatters'

Plug 'edkolev/promptline.vim'

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

call plug#end()

"
" common vim settings
"
set nocompatible
set encoding=utf-8
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undofile
set undodir=~/.vim/undo
set noerrorbells
set splitbelow
set splitright
set exrc
set secure
set nojoinspaces
set clipboard+=unnamed
set completeopt=preview
set number
set ruler
set smartcase
set infercase
set ignorecase
set diffopt+=filler,vertical
set breakindent
set t_Co=256
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

colorscheme xoria256

syntax on
filetype plugin indent on

" deoplete
let g:deoplete#enable_at_startup = 1

" better-whitespace
map ,W :ToggleWhitespace<CR>
let g:better_whitespace_enabled = 0

" lengthmatters
map ,L :LengthmattersToggle<CR>
let g:lengthmatters_on_by_default = 0
let g:lengthmatters_start_at_column = 130

" buffers
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>

" NERDTree
nnoremap <C-[> :NERDTreeToggle<cr>
nnoremap <C-]> :NERDTreeVCS<cr>

" vim-airline
let g:airline_theme = 'kolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" gitgutter
let g:gitgutter_max_signs = 100000

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
	\ 'cpp': ['/usr/local/Cellar/cquery/20180718/bin/cquery',
	\ '--log-file=/tmp/cq.log',
	\ '--init={"cacheDirectory":"/tmp/cquery/",
	\ 		"blacklist": ["./build", "./ext"]}']
	\ }
let g:LanguageClient_autoStart = 1

" autotag
let g:autotagTagsFile=".tags"

" cscope
if has("cscope")
    set csprg=/usr/local/bin/cscope
    set csto=0
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif
