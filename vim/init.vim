"Keymaps
let mapleader="\<Space>"

" Switch tabs with space space
nnoremap <leader><leader> <c-^>

" NVIM plugins
call plug#begin('~/.local/share/nvim/plugged')

" VIM enhancements
Plug 'justinmk/vim-sneak' " use s{char}{char} to find 2 letter combos
Plug 'tpope/vim-commentary' " Comment things out easily
Plug 'tpope/vim-surround' " Change surrounding quotes with cs{old}{new}
Plug 'google/vim-codefmt' " A nice formatter!
Plug 'google/vim-glaive' " Config for codefmt

" Git integration
Plug 'tpope/vim-fugitive' " Git integration using :G
Plug 'airblade/vim-gitgutter' " Git diff visualiser

" Support
Plug 'google/vim-maktaba' " codefmt dependency
Plug 'nvim-lua/plenary.nvim' " Telescope dependency
Plug 'nvim-treesitter/nvim-treesitter' " Telescope dependency
Plug 'jremmen/vim-ripgrep' " More cracked grep
" Plug 'dense-analysis/ale' " LSP

" Directory movement and search
Plug 'airblade/vim-rooter' " Move to root dir automatically
Plug 'nvim-telescope/telescope.nvim' " Having a look
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'preservim/nerdtree' " A nice folder tree setup
Plug 'Xuyuanp/nerdtree-git-plugin' " Git integration for nerdtree
" Plug 'ryanoasis/vim-devicons' Not keeping this for now as icons dont work :(

" Themes
Plug 'arcticicestudio/nord-vim'
" Plug 'shaunsingh/nord.nvim' 

Plug 'itchyny/lightline.vim' " Customizable status bar

" Autocomplete setup
Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }

Plug 'ncm2/ncm2' 
Plug 'roxma/nvim-yarp'

" Autocompletes
Plug 'ncm2/ncm2-path' " General purpose
Plug 'ncm2/ncm2-bufword' " General purpose
Plug 'ncm2/ncm2-github' " General purpose 
" Plug 'ncm2/ncm2-tern' " Javascript
" Plug 'ncm2/ncm2-jedi' " Python
Plug 'HiPhish/ncm2-vlime' " Clojure
Plug 'ncm2/ncm2-racer' " Rust

call plug#end()


autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Colooooourrrrss!

" Get rid of vimsneak colours
highlight link Sneak None
autocmd User SneakLeave highlight clear Sneak
set encoding=UTF-8
colorscheme nord

syntax on
filetype plugin indent on
set termguicolors

" lightline config
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LitghtlineGitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'gitmodified': 'LightlineGitStatus'
      \ },
      \ }


" Python

" set pythonhome=/home/jamesseymour/.venv/uni3.10/bin/python


" QOL

syntax enable
set number relativenumber
set undodir=~/.vimdid
set undofile
set cursorline

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Cubiko shortcuts!
command Vdata cd /home/jamesseymour/Git-Cubiko/data-pipeline
command Vcube cd /home/jamesseymour/Git-Cubiko/cube-snowflake-poc
command Vman cd /home/jamesseymour/Git-Cubiko/cubiko-manage

" Formatters 

call glaive#Install() " Load glaive
nnoremap <leader>i :FormatCode<CR>

" Zprint
" !This is symlinked to cubiko-manage zprint!
Glaive codefmt zprint_executable="/usr/bin/zprint" 

" JS / TS / CSS / etc.
Glaive codefmt prettier_executable="/usr/bin/prettier" 

" Telescope config
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fr <cmd>Telescope oldfiles<CR><ESC>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>


" Nerdtree config
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif " Quit vim if nerd tree is the last open

" Rooter config
let g:rooter_patterns = ['.git', '=src', '=cubiko']

" Comment out like VSCode
nnoremap <C-_> :Commentary<CR>
inoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>

" NO ARROWS
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" TMUX prefix key should'nt map
nnoremap <C-a> <nop>

" Autoclose brackets
" Trying these out - I can see these getting annoying
"
" Cancel out autoclose with a tab
inoremap '<tab> '
inoremap `<tab> `
inoremap "<tab> "
inoremap (<tab> (
inoremap [<tab> [
inoremap {<tab> {

" Pretty sure we wanna ignore it if we backspace
inoremap '<BS> <nop>
inoremap `<BS> <nop>
inoremap "<BS> <nop>
inoremap (<BS> <nop>
inoremap [<BS> <nop>
inoremap {<BS> <nop>

" By default, we just chuck in the closing paren and move back inside 
inoremap ' ''<left>
inoremap ` ``<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" When we execute the full bracket close in time then leave it
inoremap '' ''<left>
inoremap `` ``<left>
inoremap "" ""<left>
inoremap () ()<left>
inoremap [] []<left>
inoremap {} {}<left>

" When we press enter after a paren, then we do the classic newline
inoremap '<CR> '<CR>'<ESC>O
inoremap `<CR> `<CR>`<ESC>O
inoremap "<CR> "<CR>"<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap {<CR> {<CR>}<ESC>O

" Change some tab settings?
filetype plugin indent on
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" VSCode like working tree
nnoremap <leader>wt :Gdiffsplit<CR>

" Git gutter
let g:gitgutter_realtime=0
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
set updatetime=1000 " First use case for this was gitgutter not responding fast enough
nnoremap ]c :GitGutterNextHunk<CR>
nnoremap [c :GitGutterPrevHunk<CR>
nnoremap <leader>hh :GitGutterLineHighlightsToggle<CR>

