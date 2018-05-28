let mapleader = ","

function! GenerateUUID()
python << EOF
  import uuid
  import vim

  # output a uuid to the vim variable for insertion below
  vim.command("let generatedUUID = \"%s\"" % str(uuid.uuid4()))
EOF
endfunction

function! s:FindFile(file)
    let curdir = getcwd()
    let found = curdir
    while !filereadable(a:file) && found != "/"
        cd ..
        let found = getcwd()
    endwhile
    execute "cd " . curdir
    return found
endfunction

function! UpdateCtags()
    let found = s:FindFile("tags")
    if !empty(found)
        execute "cd " . found
    endif
    silent execute "!ctags -R --exclude=.git --exclude=.hg"
    redraw!
    echo "ctags index updated."
endfunction

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

function! MakeToSplit()
  silent! execute "botright vs new | 0read ! make"
  silent! execute "wincmd l<CR>"
  setlocal buftype=nofile bufhidden=delete nomodifiable nobuflisted noswapfile nowrap number
endfunction

function! UseSpaces()
  set tabstop=4
  set shiftwidth=4
  set expandtab
  set softtabstop=0
  set autoindent
  set smarttab
endfunction

call plug#begin('~/.vim/plugged')

" frequently used plugins, keep!
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'yssl/QFEnter'
Plug 'mhinz/vim-grepper'
Plug 'junegunn/gv.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jasoncodes/ctrlp-modified.vim'
Plug 'lucidstack/ctrlp-tmux.vim'
Plug 'benmills/vimux'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/taglist.vim'
Plug 'dkprice/vim-easygrep'
Plug 'qpkorr/vim-bufkill'
Plug 'kburdett/vim-nuuid'

call plug#end()

"
" common vim settings
"
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set laststatus=2
set guifont=Ubuntu\ Mono\ derivative\ Powerline:h18
set ignorecase
set smartcase
set nowrap
set nocompatible
set noequalalways
set diffopt+=vertical

"set lines=75
"set columns=90
"set noantialias

set t_Co=256
"set term=screen-256color
"set term=xterm-256color
"color scheme selection
"colorscheme seoul256
"colorscheme grb256
"colorscheme codeschool
"let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme sorcerer
colorscheme xoria256

let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

syntax on

if has("autocmd")
	filetype plugin indent on
endif

" clang_complete
let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-3.8.so.1'

" basic clipboard configuration
set clipboard=unnamed
vnoremap <C-c> "+y

"initialize the GenerateUUID function here and map it to a local
"command
noremap <Leader>r :call GenerateUUID()<CR>

" workaround for copy paste in regular vim
nmap <F2> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F2> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F3> :.w !pbcopy<CR><CR>
vmap <F3> :w !pbcopy<CR><CR>

" general editing configuration
set number
set ruler

" ctrlp setup
nnoremap <C-r> :CtrlPMRU<cr>
nnoremap <leader>. :CtrlPTag<cr>
set wildignore +=*/tmp/*,*.so,*.swp,*.zip,*.tar.gz
let g:ctrlp_extensions = ['tmux']

" ctags
set tags=./tags;~/Projects
nnoremap <leader>c :UpdateCtags()<cr>

" tagbar
nnoremap <F8> :TagbarToggle<cr>

" buffer navigation
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>

" nerdtree
nnoremap <silent> <leader>p :NERDTreeMirrorToggle<cr>

" vim-airline configuration
let g:airline_theme = 'kolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" vim-session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'

" vim-jsbeautify
map <c-f> :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" vim-pipe configuration
"
autocmd FileType sql :let b:vimpipe_command="psql jeff"
autocmd FileType sql :let b:vimpipe_filetype="postgresql"

" SQLComplete configuration
let g:ftplugin_sql_omni_key = '<C-C>'

" vim-mocha configuration
let g:mocha_js_command = "enew | silent r ! mocha --require es6_mocha.js --no-colors {spec}"

map <Leader><Leader>m :call RunCurrentSpecFile()<CR>

" grep fun
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  let g:ctrlp_use_caching = 0
endif

" gitgutter
let g:gitgutter_max_signs = 100000

" neocomplete
let g:neocomplete#enable_at_startup = 1

" arm assembly syntax setup
"au! BufNewFile,BufRead *.s,*.S set filetype=arm

" make setup
nnoremap <silent> <C-a> :call MakeToSplit()<CR>

" file type configuration
autocmd FileType asm :call UseSpaces()
