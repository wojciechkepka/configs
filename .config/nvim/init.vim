set shell=/bin/bash

"################################################################################
"				PLUGINS

call plug#begin()
" Git
Plug 'tpope/vim-fugitive'

" ColorSchemes
Plug 'sainnhe/edge'
Plug 'wojciechkepka/tequila-sunrise.vim'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'arzg/vim-colors-xcode'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'ayu-theme/ayu-vim'

" GUI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'machakann/vim-highlightedyank'

" Nerdtree
Plug 'scrooloose/nerdtree'

" Comments
Plug 'preservim/nerdcommenter'

" File structure
Plug 'majutsushi/tagbar'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'plasticboy/vim-markdown'
Plug 'baskerville/vim-sxhkdrc'
Plug 'itchyny/vim-haskell-indent'

" Distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'Chiel92/vim-autoformat'
call plug#end()

"################################################################################
"				COLORSCHEME

"truecolor
if (has("termguicolors"))
    set termguicolors
endif
set t_Co=256
"Sometimes setting 'termguicolors' is not enough and one has to set the t_8f and t_8b options explicitly
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
"set background=light
let ayucolor="dark"
syntax on

colorscheme ayu
"colorscheme tequila-sunrise
"colorscheme edge
"colorscheme gruvbox
"colorscheme solarized8
"colorscheme challenger_deep
"colorscheme xcodedark

" Make airline use powerline fonts
" remember to install powerline-fonts
let g:airline_powerline_fonts = 1

set guifont=Fira\ Code:h11

"################################################################################
"				CODE

" Autocomplete
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_options = '--edition 2018'
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

"C#
let g:OmniSharp_server_use_mono = 1

"################################################################################
"				BASIC SETTINGS

" Better display for messages
set cmdheight=2

" Permanent undo
set undodir=~/.vimdid
set undofile

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Use wide tabs
set shiftwidth=8
set softtabstop=8
set tabstop=8
set noexpandtab

set ttyfast

" Use short tabs for html and css
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab

" Display line number
set nu
set splitright

" Fold code
set foldmethod=indent
set foldnestmax=2
set foldlevel=1

" Use system clipboard for yanks
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

"################################################################################
"				KEYBINDINGS

" Switch between tabs
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" Toggle nerdtree
map <C-k> :NERDTreeToggle<CR>

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Use Ctrl + hjkl in input mode for arrows
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

" Quick 80 char text divider
inoremap <F2> ################################################################################
inoremap <F3> --------------------------------------------------------------------------------

" Coc keybindings
nmap <F1> <Plug>(coc-diagnostic-prev-error)
nmap <F2> <Plug>(coc-diagnostic-next-error)
nmap <F3> <Plug>(coc-diagnostic-next)
nmap <F4> <ESC>:w<CR>:vsplit<CR> <Plug>(coc-definition)

" Toggle code navigation
" remember to install rusty-tags with it
" cargo install rusty-tags
nmap <F8> :TagbarToggle<CR>

" Run rust and python
noremap <F5> <ESC>:w<CR>:!python %<CR>
noremap <F6> <ESC>:w<CR>:vsplit term://cargo run<CR>

" Toggle comments
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" Toggle fuzzy search current file ctags
nmap <C-t> <ESC>:BTags<CR>

" Toggle fuzzy search for current buffer
nmap <C-l> <ESC>:BLines<CR>
