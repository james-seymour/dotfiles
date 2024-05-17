" Keymaps
let mapleader="\<Space>"
let maplocalleader=","

" Switch to previous file 
nnoremap <leader><leader> <c-^>

" NVIM plugins
call plug#begin('~/.local/share/nvim/plugged')

" VIM enhancements
Plug 'tpope/vim-commentary' " Comment things out easily
Plug 'tpope/vim-surround' " Change surrounding quotes with cs{old}{new}
Plug 'google/vim-codefmt' " A nice formatter!
Plug 'google/vim-glaive' " Config for codefmt
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ggandor/leap.nvim'

" Git integration
Plug 'tpope/vim-fugitive' " Git integration using :G
Plug 'airblade/vim-gitgutter' " Git diff visualiser
Plug 'APZelos/blamer.nvim' " Git blame
Plug 'stsewd/fzf-checkout.vim' " Fuzzy search branches

" Support
Plug 'google/vim-maktaba' " codefmt dependency
Plug 'nvim-lua/plenary.nvim' " Telescope dependency
Plug 'nvim-treesitter/nvim-treesitter' " Telescope dependency
Plug 'nvim-lua/popup.nvim' " Telescope zoxide dependency
Plug 'jremmen/vim-ripgrep' " More cracked grep

" Directory movement and search
" Plug 'guns/vim-sexp' " Slurping
Plug 'airblade/vim-rooter' " Move to root dir automatically
Plug 'nvim-telescope/telescope.nvim' " Having a look
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'fannheyward/telescope-coc.nvim'
Plug 'dhruvmanila/telescope-bookmarks.nvim', { 'tag': '*' }
Plug 'cljoly/telescope-repo.nvim'
Plug 'jvgrootveld/telescope-zoxide'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'preservim/nerdtree' " A nice folder tree setup
Plug 'Xuyuanp/nerdtree-git-plugin' " Git integration for nerdtree

Plug 'github/copilot.vim'

" Themes
" Plug 'arcticicestudio/nord-vim'
Plug 'shaunsingh/nord.nvim'
Plug 'sainnhe/everforest'
Plug 'lambdalisue/nerdfont.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'gko/vim-coloresque'

" Lightline
Plug 'itchyny/lightline.vim' " Customizable status bar
Plug 'sainnhe/artify.vim'
Plug 'albertomontesg/lightline-asyncrun' " Integration of https://github.com/skywind3000/asyncrun.vim
Plug 'edkolev/tmuxline.vim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Olical/conjure' " REPL support
" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } " Extra syntax highlighting for python
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
" Latex
" Plug 'lervag/vimtex'
" Plug 'sirver/ultisnips' " Snippets

call plug#end()


nmap <leader>cd :Copilot disable<CR>

" Leap config
lua require('leap').add_default_mappings()

" Coc config
let g:coc_global_extensions = ['coc-clojure', 'coc-docker', 'coc-git', 'coc-json', 'coc-pyright', 'coc-rust-analyzer', 'coc-tsserver', 'coc-yaml', 'coc-go']

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Coc trigger completion early
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(0) : "\<C-n>"
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(2) : "\<C-n>"

" Coc Hover
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Colooooourrrrss! (maybe)
set background=dark
let g:everforest_background = 'soft'
colorscheme everforest

" Fzf cant figure out colours on its own
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Vim builtin config
syntax on
filetype plugin indent on
set number relativenumber
set undodir=~/.vimdid
set undofile
set cursorline
set encoding=UTF-8
set termguicolors
set smartcase
set ignorecase
set expandtab
set autoindent
set tabstop=2
set showmatch
set showtabline=2
set softtabstop=2
set shiftwidth=2
set signcolumn=yes
" Use + as the default register
set clipboard+=unnamedplus

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Code format
call glaive#Install() " Load glaive
" Zprint
" !This is symlinked to cubiko-manage zprint!
Glaive codefmt zprint_executable="/usr/bin/zprint" 

" JS / TS / CSS / etc.
Glaive codefmt prettier_executable="/usr/bin/prettier" 


augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer black
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue,typescript AutoFormatBuffer prettier
  autocmd FileType ocaml AutoFormatBuffer ocamlformat
augroup END

nnoremap <leader>i :FormatCode<CR>

map <leader>s :w<CR>
map <leader>q :w<CR><C-Z>
map <leader>ra :&&<CR>

" Random code snippets
map <leader>cht :-1read $HOME/clickhouse-template<CR>


" Nerdtree config
nnoremap <C-f> :NERDTreeFind<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif " Quit vim if nerd tree is the last open

" Rooter config
let g:rooter_patterns = ['=cubiko-manage', '.git']

" Comment out like VSCode
nnoremap <C-c> :Commentary<CR>
vnoremap <C-c> :Commentary<CR>

" Make brackets make sense
nnoremap { }
nnoremap } {
vnoremap { }
vnoremap } {

" TMUX prefix key shouldn't map
nnoremap <C-s> <nop>

" VSCode like working tree
nnoremap <leader>wt :Gdiffsplit<CR>

" Git gutter
let g:gitgutter_realtime=1
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
set updatetime=1000 " gitgutter not responding fast enough

" Git fugitive
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        G | resize 15 " Don't want it to take up half of the page!
    endif
endfunction

set diffopt+=vertical

command ToggleGStatus :call ToggleGStatus()

nnoremap <leader>gs :ToggleGStatus<CR>

let g:fzf_checkout_git_options = '--sort=-committerdate'

" Git blame
nnoremap <leader>bl :BlamerToggle<CR>

" Lightline config
 function! LightlineFullFilename()
     return expand('%')
 endfunction

 function! LightlineGitStatus()
   let [a,m,r] = GitGutterGetHunkSummary()
   return printf('+%d ~%d -%d', a, m, r)
 endfunction

 let g:lightline = {
       \ 'colorscheme': 'everforest',
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified'] ]
       \ },
       \ 'component_function': {
	     \   'cocstatus': 'coc#status',
       \   'filename': 'LightlineFullFilename',
       \   'gitbranch': 'FugitiveHead',
       \   'gitmodified': 'LightlineGitStatus',
       \ },
       \ }
let g:lightline#extensions#tmuxline#enabled = 0

" Resize splits
nnoremap <M-,> <c-w>5<<CR>
nnoremap <M-.> <c-w>5><CR>
nnoremap <M-j> <C-W>+<CR>
nnoremap <M-k> <C-W>-<CR>


" Autoclose brackets
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

" Telescope config

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fr <cmd>Telescope oldfiles<CR><ESC>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope git_branches<CR>
nnoremap <leader>fs <cmd>Telescope grep_string<CR><ESC>
nnoremap <leader>/  <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>fd <cmd>Telescope coc document_symbols<CR>
nnoremap <leader>fw <cmd>Telescope coc workspace_symbols<CR>
nnoremap <leader>fe <cmd>Telescope coc diagnostics<CR><ESC>
nnoremap <silent>gr <cmd>Telescope coc references<CR><ESC>
nnoremap <leader>z  <cmd>Telescope zoxide list<CR>
nnoremap <leader>rr <cmd>Telescope neoclip plus<CR><ESC>
nnoremap <leader>gg <cmd>lua require('telescope').extensions.repo.list{fd_opts=[[--ignore-file=/home/jamesseymour/.fdignore]]}<CR>

lua << EOF
require("telescope").setup({
  extensions = {
    coc = {
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    },
  },
})
require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')
require('telescope').load_extension('bookmarks')
require('telescope').load_extension('zoxide')
require('telescope').load_extension('repo')
require('neoclip').setup()
require('telescope').load_extension('neoclip')
EOF

