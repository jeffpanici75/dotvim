let mapleader = ","

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

" Vundle configuration
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'elzr/vim-json'
Plugin 'justinmk/vim-sneak'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-unimpaired'
Plugin 'digitaltoad/vim-jade'
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/csapprox'
Plugin 'bling/vim-airline'
Plugin 'edkolev/promptline.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'moll/vim-node'
Plugin 'godlygeek/tabular'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'wincent/command-t'
Plugin 'airblade/vim-gitgutter'
Plugin 'marijnh/tern_for_vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'groenewege/vim-less'
Plugin 'othree/html5.vim'
Plugin 'mattn/webapi-vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'krisajenkins/vim-postgresql-syntax'
Plugin 'krisajenkins/vim-pipe'
Plugin 'junegunn/vader.vim'
Plugin 'vim-scripts/dbext.vim'
Plugin 'ryanss/vim-hackernews'
Plugin 'geekjuice/vim-mocha'
Plugin 'mustache/vim-mustache-handlebars'

call vundle#end()
" 
"

execute pathogen#infect()

set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set laststatus=2
set guifont=Ubuntu\ Mono\ derivative\ Powerline:h18
set ts=4 sts=4 sw=4 expandtab
"set lines=75
"set columns=90
"set noantialias

"set t_Co=256
"set term=xterm-256color


let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

syntax on

if has("autocmd")
	filetype plugin indent on
endif

set ignorecase
set smartcase
set nowrap
set nocompatible
set noequalalways
set diffopt+=vertical

" works in MacVim
set clipboard=unnamed

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

" YouCompleteMe
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" color scheme selection
"colorscheme seoul256
"colorscheme grb256
"colorscheme codeschool
"let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme sorcerer
colorscheme xoria256

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
