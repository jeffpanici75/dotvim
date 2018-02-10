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

call plug#begin('~/.vim/plugged')

Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdtree'
Plug 'elzr/vim-json'
Plug 'justinmk/vim-sneak'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/csapprox'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'
Plug 'xolox/vim-misc'
Plug 'moll/vim-node'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/vim-easymotion'
Plug 'groenewege/vim-less'
Plug 'othree/html5.vim'
Plug 'mattn/webapi-vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'krisajenkins/vim-pipe'
Plug 'junegunn/vader.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'dkprice/vim-easygrep'
Plug 'qpkorr/vim-bufkill'
Plug 'kburdett/vim-nuuid'
Plug 'thaerkh/vim-workspace'
Plug 'benmills/vimux'
Plug 'ARM9/arm-syntax-vim'

call plug#end()

"
" common vim settings
"
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set laststatus=2
set guifont=Ubuntu\ Mono\ derivative\ Powerline:h18
set ts=4 sts=4 sw=4 expandtab
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
set term=screen-256color
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

" Vader configuration
nnoremap <leader>1 :Vader<cr>
nnoremap <leader>2 :Vader tests/*<cr>

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
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
