let mapleader = ","
let maplocalleader = ","
let g:python3_host_prog = "c:/tools/python39/python.exe"

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }" Plug 'ctrlpvim/ctrlp.vim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'benizi/vim-automkdir'

Plug 'easymotion/vim-easymotion'

Plug 'editorconfig/editorconfig-vim'

Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'

Plug 'matze/vim-move'

Plug 'ntpeters/vim-better-whitespace'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'

Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

Plug 'whatyouhide/vim-lengthmatters'

Plug 'edkolev/promptline.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'vhdirk/vim-cmake'
Plug 'skywind3000/asyncrun.vim'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'kien/rainbow_parentheses.vim'
Plug 'wlangstroth/vim-racket'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kalvinpearce/ShaderHighlight'

call plug#end()

"
" common vim settings
"
set nocompatible
set encoding=utf-8
set backupdir=c:/users/jeff/.config/nvim/backups
set directory=c:/users/jeff/.config/nvim/swaps
set undofile
set undodir=c:/users/jeff/.config/nvim/undo
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

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" shift+insert in neovim-qt
inoremap <silent> <S-Insert> <C-R>+

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
nmap <leader>bq :bp<bar>sp<bar>bn<bar>bd<cr>
nmap <leader>bl :ls<CR>

" editing
nnoremap <silent> oo :<C-u>call append(line("."),   repeat([""], v:count1))<cr>
nnoremap <silent> OO :<C-u>call append(line(".")-1, repeat([""], v:count1))<cr>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" better-whitespace
map <leader>bw :ToggleWhitespace<cr>
let g:better_whitespace_enabled = 1

" lengthmatters
map <leader>lm :LengthmattersToggle<cr>
let g:lengthmatters_on_by_default = 0
let g:lengthmatters_start_at_column = 260

" vim-airline/buffers
let g:airline_theme = 'kolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" vim-fugitive
" map <leader>gs :Gstatus<cr>
" map <leader>gc :Gcommit<cr>
" map <leader>gl :Glog<cr>

" directory helpers
command! GoHome :cd C:/Users/jeff
command! GoDownloads :cd C:/Users/jeff/Downloads

" config helpers
command! InitEdit :e C:/users/jeff/AppData/Local/nvim/init.vim
command! GinitEdit :e C:/users/jeff/AppData/Local/nvim/ginit.vim
command! InitSource :source C:/users/jeff/AppData/Local/nvim/init.vim

" project level customization
let g:project_file_name = 'project.vim'
if !empty(glob(expand(g:project_file_name)))
    exec 'source' fnameescape(g:project_file_name)
endif

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

" CoC configuration

set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<cr>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<cr>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<cr>

"" coc-explorer configuration
nnoremap <space>e :CocCommand explorer<cr>
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>

" fix floating window background color
hi Quote ctermbg=109 guifg=#83a598

