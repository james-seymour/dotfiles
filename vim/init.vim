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
Plug 'voldikss/vim-floaterm' " Open a floating terminal
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " Markdown preview
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'SmiteshP/nvim-gps' " Status bar for where im at

" Git integration
Plug 'tpope/vim-fugitive' " Git integration using :G
Plug 'airblade/vim-gitgutter' " Git diff visualiser
Plug 'APZelos/blamer.nvim' " Git blame
Plug 'stsewd/fzf-checkout.vim' " Fuzzy search branches

" Support
Plug 'google/vim-maktaba' " codefmt dependency
Plug 'nvim-lua/plenary.nvim' " Telescope dependency
Plug 'nvim-treesitter/nvim-treesitter' " Telescope dependency
Plug 'jremmen/vim-ripgrep' " More cracked grep

" Directory movement and search
" Plug 'guns/vim-sexp' " Slurping
Plug 'airblade/vim-rooter' " Move to root dir automatically
Plug 'nvim-telescope/telescope.nvim' " Having a look
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'preservim/nerdtree' " A nice folder tree setup
Plug 'Xuyuanp/nerdtree-git-plugin' " Git integration for nerdtree

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
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'Olical/conjure' " REPL support
" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } " Extra syntax highlighting for python

" Latex
" Plug 'lervag/vimtex'
" Plug 'sirver/ultisnips' " Snippets

call plug#end()

call mkdp#util#install() " Install markdown preview properly

" Colooooourrrrss!
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

" Vim builtins
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

nnoremap H 0 
" nnoremap L $ 

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
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

nnoremap <leader>i :FormatCode<CR>

map <leader>s :w<CR>
map <leader>q :wq<CR>
map <leader>rr :&&<CR>


function! SaveAndQuit()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        G | resize 15 " Don't want it to take up half of the page!
    endif
endfunction


" Telescope config
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fr <cmd>Telescope oldfiles<CR><ESC>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>

" Nerdtree confi
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif " Quit vim if nerd tree is the last open

" Rooter config
let g:rooter_patterns = ['.git', '=src', '=cubiko']

" Comment out like VSCode
nnoremap <C-_> :Commentary<CR>
inoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>

" Make brackets make sense
nnoremap { }
nnoremap } {
vnoremap { }
vnoremap } {

" NO ARROWS
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
" TMUX prefix key shouldn't map
nnoremap <C-a> <nop>

" VSCode like working tree
nnoremap <leader>wt :Gdiffsplit<CR>

" Markdown preview
nnoremap <leader>mp :MarkdownPreview<CR>
let g:mkdp_auto_start = 0

" Git gutter
let g:gitgutter_realtime=1
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
set updatetime=1000 " gitgutter not responding fast enough
nnoremap ]c :GitGutterNextHunk<CR>
nnoremap [c :GitGutterPrevHunk<CR>

" Git fugitive
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        G | resize 20 " Don't want it to take up half of the page!
    endif
endfunction

set diffopt+=vertical

command ToggleGStatus :call ToggleGStatus()

nnoremap <leader>gs :ToggleGStatus<CR>

let g:fzf_checkout_git_options = '--sort=-committerdate'
nnoremap <leader>gb :GBranches<CR>

" Git blame
nnoremap <leader>bl :BlamerToggle<CR>

" Coc config
nmap gd <Plug>(coc-definition)
nmap gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Floaterm
let g:floaterm_shell="zsh"
let g:floaterm_title="floatyboi"
let g:floaterm_width=0.7
let g:floaterm_height=0.9
nnoremap tt :FloatermToggle<CR>
tnoremap tt <C-\><C-n> :FloatermToggle<CR>

" Lightline config
 function! LightlineFullFilename()
     return expand('%')
 endfunction

 function! LightlineGitStatus()
   let [a,m,r] = GitGutterGetHunkSummary()
   return printf('+%d ~%d -%d', a, m, r)
 endfunction

 lua require("nvim-gps").setup()

 function! NvimGps()
 	return luaeval("require('nvim-gps').is_available()") ?
 		\ luaeval("require('nvim-gps').get_location()") : ''
 endfunction

 let g:lightline = {
       \ 'colorscheme': 'everforest',
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'gps' ] ]
       \ },
       \ 'component_function': {
       \   'filename': 'LightlineFullFilename',
       \   'gitbranch': 'FugitiveHead',
       \   'gitmodified': 'LightlineGitStatus',
       \   'gps': 'NvimGps'
       \ },
       \ }
let g:lightline#extensions#tmuxline#enabled = 0

"" {{{lightline.vim
" let g:lightline = {}
" let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
" let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
" let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
" let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
" let g:lightline#asyncrun#indicator_none = ''
" let g:lightline#asyncrun#indicator_run = 'Running...'
" let g:vim_lightline_artify = 0
" if g:vim_lightline_artify == 0
"   let g:lightline.active = {
"         \ 'left': [ [ 'mode', 'paste' ],
"         \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
"         \ 'right': [ [ 'lineinfo' ],
"         \            [ 'linter_errors', 'linter_warnings', 'linter_ok'],
"         \           [ 'asyncrun_status', 'coc_status' ] ]
"         \ }
"   let g:lightline.inactive = {
"         \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
"         \ 'right': [ [ 'lineinfo' ] ]
"         \ }
"   let g:lightline.tabline = {
"         \ 'left': [ [ 'vim_logo', 'tabs' ] ],
"         \ 'right': [ [ 'git_global' ],
"         \ [ 'git_buffer' ] ]
"         \ }
"   let g:lightline.tab = {
"         \ 'active': [ 'tabnum', 'filename', 'modified' ],
"         \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
" else
"   let g:lightline.active = {
"         \ 'left': [ [ 'artify_mode', 'paste' ],
"         \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
"         \ 'right': [ [ 'artify_lineinfo' ],
"         \            [ 'linter_errors', 'linter_warnings', 'linter_ok'],
"         \           [ 'asyncrun_status', 'coc_status' ] ]
"         \ }
"   let g:lightline.inactive = {
"         \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
"         \ 'right': [ [ 'artify_lineinfo' ] ]
"         \ }
"   let g:lightline.tabline = {
"         \ 'left': [ [ 'vim_logo', 'tabs' ] ],
"         \ 'right': [ [ 'git_global' ],
"         \ [ 'git_buffer' ] ]
"         \ }
"   let g:lightline.tab = {
"         \ 'active': [ 'artify_activetabnum', 'artify_filename', 'modified' ],
"         \ 'inactive': [ 'artify_inactivetabnum', 'filename', 'modified' ] }
" endif
" let g:lightline.tab_component_function = {
"       \ 'artify_activetabnum': 'custom#lightline#artify_active_tabnum',
"       \ 'artify_inactivetabnum': 'custom#lightline#artify_inactive_tabnum',
"       \ 'artify_filename': 'custom#lightline#artify_tabname',
"       \ 'tabnum': 'custom#lightline#tabnum',
"       \ 'filename': 'lightline#tab#filename',
"       \ 'modified': 'lightline#tab#modified',
"       \ 'readonly': 'lightline#tab#readonly'
"       \ }
" let g:lightline.component = {
"       \ 'git_buffer' : '%{get(b:, "coc_git_status", "")}',
"       \ 'git_global' : '%{custom#lightline#git_global()}',
"       \ 'artify_mode': '%{custom#lightline#artify_mode()}',
"       \ 'artify_lineinfo': "%2{custom#lightline#artify_line_percent()}\uf295 %3{custom#lightline#artify_line_num()}:%-2{custom#lightline#artify_column_num()}",
"       \ 'vim_logo': "\ue7c5",
"       \ 'mode': '%{lightline#mode()}',
"       \ 'filename': '%t',
"       \ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
"       \ 'modified': '%M',
"       \ 'paste': '%{&paste?"PASTE":""}',
"       \ 'readonly': '%R',
"       \ 'lineinfo': '%2p%% %3l:%-2v'
"       \ }
" let g:lightline.component_function = {
"       \ 'devicons_filetype': 'custom#lightline#devicons',
"       \ 'coc_status': 'custom#lightline#coc_status'
"       \ }
" let g:lightline.component_expand = {
"       \ 'linter_warnings': 'custom#lightline#coc_diagnostic_warning',
"       \ 'linter_errors': 'custom#lightline#coc_diagnostic_error',
"       \ 'linter_ok': 'custom#lightline#coc_diagnostic_ok',
"       \ 'asyncrun_status': 'lightline#asyncrun#status'
"       \ }
" let g:lightline.component_type = {
"       \ 'linter_warnings': 'warning',
"       \ 'linter_errors': 'error'
"       \ }
" " }}}

" VimTex
" set nocompatible
" let &rtp = '~/.local/share/nvim/plugged' . &rtp
" let &rtp .= '~/.local/share/nvim/plugged'
" let g:vimtex_latexmk_continuous=1
" let g:tex_flavor='latex'
" let g:Tex_DefaultTargetFormat='pdf'
" let g:vimtex_view_enabled=1
" let g:vimtex_view_automatic=1
" let g:vimtex_view_general_viewer='zathura'
" let g:vimtex_view_method='zathura'
" let g:vimtex_quickfix_mode=0
" let g:vimtex_compiler_latexmk = {
"   \  'callback' : 0,
"   \ }

" " UltiSnips
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" let g:UltiSnipsSnippetsDir = "~/.local/share/nvim/UltiSnips"
" let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]
" set rtp+=~/.local/share/nvim/plugged/UltiSnips/greek

" nnoremap <leader>l <cmd>VimtexCompile<CR>


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



