let mapleader = ","

call plug#begin('~/.vim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

Plug 'Shougo/denite.nvim'

Plug 'chemzqm/denite-extra'
Plug 'chemzqm/denite-git'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neomru.vim'
Plug 'Shougo/defx.nvim'

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

colorscheme xoria256

syntax on
filetype plugin indent on

" deoplete
let g:deoplete#enable_at_startup = 1

" denite
augroup deniteresize
  autocmd!
  autocmd VimResized,VimEnter * call denite#custom#option('default',
        \'winheight', winheight(0) / 2)
augroup end

call denite#custom#option('default', {
      \ 'prompt': '❯'
      \ })

call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-u', '-g', ''])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep',])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [''])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#map(
	\ 'insert',
	\ '<C-w>c',
	\ '<denite:quit>',
	\'noremap')
call denite#custom#map(
	\ 'insert',
	\ '<Esc>',
	\ '<denite:enter_mode:normal>',
	\'noremap')
call denite#custom#map(
	\ 'normal',
	\ '<Esc>',
	\ '<denite:leave_mode>',
	\'noremap')
call denite#custom#map(
	\ 'insert',
	\ '<C-v>',
	\ '<denite:do_action:vsplit>',
	\'noremap')
call denite#custom#map(
	\ 'normal',
	\ '<C-v>',
	\ '<denite:do_action:vsplit>',
	\'noremap')
call denite#custom#map(
	\ 'normal',
	\ 'dw',
	\ '<denite:delete_word_after_caret>',
	\'noremap')
call denite#custom#map(
	\ 'normal',
	\ '<Up>',
	\ '<denite:move_to_previous_line>',
	\'noremap')
call denite#custom#map(
	\ 'normal',
	\ '<Down>',
	\ '<denite:move_to_next_line>',
	\'noremap')
call denite#custom#map(
	\ 'normal',
	\ '<PageUp>',
	\ '<denite:scroll_page_backwards>',
	\'noremap')
call denite#custom#map(
	\ 'normal',
	\ '<PageDown>',
	\ '<denite:scroll_page_forwards>',
	\'noremap')

nnoremap <C-0> :DeniteProjectDir -buffer-name=git file/rec file_mru buffer<CR>
nnoremap <C-p> :DeniteProjectDir -buffer-name=files file_rec/git file_mru buffer<CR>

hi link deniteMatchedChar Special

" buffers
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>

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

