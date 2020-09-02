let mapleader = ","
let maplocalleader = ","

call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'

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

Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

Plug 'trevordmiller/nova-vim'

Plug 'whatyouhide/vim-lengthmatters'

Plug 'edkolev/promptline.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'xolox/vim-misc'

Plug 'majutsushi/tagbar'

Plug 'vhdirk/vim-cmake'
Plug 'skywind3000/asyncrun.vim'

Plug 'derekwyatt/vim-fswitch'

Plug 'ludovicchabant/vim-gutentags'

Plug 'mg979/vim-visual-multi'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'kien/rainbow_parentheses.vim'
Plug 'jpalardy/vim-slime'
Plug 'wlangstroth/vim-racket'

Plug 'christoomey/vim-tmux-navigator'
" Plug 'vim-scripts/paredit.vim'

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

"set switchbuf=usetab
nnoremap <C-Right> :bnext<cr>
nnoremap <C-Left> :bprevious<cr>

nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<cr>

nmap <leader>bn :enew<cr>
nmap <leader>bq :bp <bar> bd #<cr>
nmap <leader>bl :ls<cr>

" editing
nnoremap <silent> oo :<C-u>call append(line("."),   repeat([""], v:count1))<cr>
nnoremap <silent> OO :<C-u>call append(line(".")-1, repeat([""], v:count1))<cr>
nnoremap <silent> k i<cr><esc>

" deoplete
let g:deoplete#enable_at_startup = 1

" gutentags
" ctags --language-force=scheme *.rkt
let g:gutentags_cache_dir = $HOME . '/.cache/ctags'
"let g:gutentags_ctags_extra_args = ['--language-force=scheme', '*.rkt']

" ctrlp
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:trlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir',
                          \ 'undo', 'line', 'changes', 'bookmarkdir']
let g:ctrlp_buftag_types = {
\ 'racket'     : '--language-force=scheme --kinds-scheme=fs',
\ }
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --path-to-ignore ~/.ignore -g ""'
endif

nmap <F12> :CtrlPBufTag<cr>

" better-whitespace
"map <leader>W :ToggleWhitespace<CR>
let g:better_whitespace_enabled = 1

" lengthmatters
" map <leader>L :LengthmattersToggle<CR>
let g:lengthmatters_on_by_default = 0
let g:lengthmatters_start_at_column = 130

" tagbar
let g:tagbar_autoclose = 1
"nnoremap <F12> :TagbarToggle<cr>

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

" terminal settings
nnoremap <F11> :edit term://bash<cr>
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" vim-slime
let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

" rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['green',       'RoyalBlue3'],
    \ ['cyan',        'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" moving lines
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" paredit
" let g:paredit_smartjump = 1
" let g:paredit_matchlines = 200
