let mapleader = ","

call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree'

Plug 'airblade/vim-gitgutter'

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
Plug 'tpope/vim-obsession'

Plug 'trevordmiller/nova-vim'

Plug 'whatyouhide/vim-lengthmatters'

Plug 'edkolev/promptline.vim'

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'xolox/vim-misc'

Plug 'majutsushi/tagbar'

Plug 'vhdirk/vim-cmake'
Plug 'skywind3000/asyncrun.vim'

Plug 'derekwyatt/vim-fswitch'

Plug 'ludovicchabant/vim-gutentags'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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

" buffers & tabs
set hidden

nnoremap <Tab> :tabnext<cr>
nnoremap <S-Tab> :tabprev<cr>

set switchbuf=usetab
nnoremap <C-Right> :sbnext<cr>
nnoremap <C-Left> :sbprevious<cr>

nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<cr>

nmap <leader>bn :enew<cr>
nmap <leader>bq :bp <bar> bd #<cr>
nmap <leader>bl :ls<cr>

" deoplete
let g:deoplete#enable_at_startup = 1

" gutentags
let g:gutentags_cache_dir = $HOME . '/.cache/ctags'

" ctrlp
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --path-to-ignore ~/.ignore -g ""'
endif

nmap <C-N> :CtrlPTag<cr>
nmap <C-K> :CtrlPBuffer<cr>

" better-whitespace
map <leader>W :ToggleWhitespace<CR>
let g:better_whitespace_enabled = 0

" lengthmatters
map <leader>L :LengthmattersToggle<CR>
let g:lengthmatters_on_by_default = 0
let g:lengthmatters_start_at_column = 130

" NERDTree
nnoremap <F11> :NERDTreeToggle<cr>

" tagbar
let g:tagbar_autoclose = 1
nnoremap <F12> :TagbarToggle<cr>

" vim-airline/buffers
let g:airline_theme = 'kolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" gitgutter
if exists('&signcolumn')
    set signcolumn="yes"
else
    let g:gitgutter_sign_column_always = 1
endif
let g:gitgutter_max_signs = 250

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

" vim-fugitive
map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>gl :Glog<cr>

" config helpers
command! InitEdit :e ~/.config/nvim/init.vim
command! InitSource :source ~/.config/nvim/init.vim

" project level customization
let g:project_file_name = 'project.vim'
if !empty(glob(expand(g:project_file_name)))
    exec 'source' fnameescape(g:project_file_name)
endif

