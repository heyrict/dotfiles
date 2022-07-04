" vim:foldmethod=marker

" {{{1 Change Default Language
language en_US.utf8

" {{{1 Vim-Plug settings
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

" NERD_tree
Plug 'scrooloose/nerdtree'

" Color Schema
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
"Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline-themes'

" Pairing
"Plug 'jiangmiao/auto-pairs'
Plug 'tmsvg/pear-tree'

" Folders
" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required
" VUNDLE SETTINGS END

" {{{1 Solarized Color Scheme Configs
"let g:solarized_visibility="high"
"call togglebg#map("<F5>")
"syntax enable
"if $TERM=="xterm-256color"
"    let g:solarized_termtrans=1
"    colorscheme solarized
"elseif $TERM=="xterm"
"    let g:solarized_termtrans=1
"    let g:solarized_termcolors=256
"    let g:solarized_contrast="high"
"    colorscheme solarized
"elseif $TERM=="linux"
"    let g:solarized_termcolors=16
"    colorscheme solarized
"elseif $TERM=="fbterm"
"    let g:solarized_termcolors=256
"    colorscheme solarized
"elseif $TERM=="alacritty"
"    let g:solarized_termtrans=0
"    let g:solarized_termcolors=16
"    colorscheme solarized
"endif

colorscheme delek

if $BACKLIGHT=="light"
    set background=light
else
    set background=dark
endif

" {{{1 Airline Configs
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_modified=1
"let g:airline_section_c = airline#section#create_right(['ffenc','bat'])
"let g:airline_section_b = '%-0.10{getcwd()}'
"let g:airline_section_c = '%t'
"let g:airline_section_c = airline#section#create(['%{cat /sys/class/power_supply/BAT1/capacity}'])
let g:airline_powerline_fonts = 1
let g:airline#extensions#wordcount#enabled = 0
"let g:airline#extensions#wordcount#format = '%d words'
if $TMUX!=""
    let g:airline#extensions#tmuxline#enabled = 1
    let airline#extensions#tmuxline#snapshot_file = "~/.tmuxline.snapshot"
endif
"if g:ale_enabled==1
"    let g:airline#extensions#ale#enabled = 1
"endif
if $TERM=="linux"
    set t_Co=16
    let g:airline_theme='wombat'
elseif $TERM=="xterm"
    set t_Co=16
    set t_BE=
    let g:airline_theme='solarized'
else
    let g:airline_theme='solarized'
endif

"if $TERM=="linux"
"    if !exists('g:airline_symbols')
"        let g:airline_symbols = {}
"    endif
"    let g:airline_left_sep = '>'
"    let g:airline_left_alt_sep = ''
"    let g:airline_right_sep = '<'
"    let g:airline_right_alt_sep = ''
"    let g:airline_symbols.branch = '@'
"    let g:airline_symbols.readonly = '[ro]'
"    let g:airline_symbols.linenr = '|'
"    let g:airline_symbols.crypt = '[l]'
"    let g:airline_symbols.maxlinenr = ' {ln}'
"    let g:airline_symbols.paste = '[p]'
"    let g:airline_symbols.spell = '[s]'
"    let g:airline_symbols.notexists = '[ne]'
"    let g:airline_symbols.whitespace = ''
"else
"    let g:airline_left_sep = '»'
"    let g:airline_right_sep = '«'
"    let g:airline_symbols.crypt = '🔒'
"    let g:airline_symbols.linenr = '¶'
"    let g:airline_symbols.maxlinenr = '㏑'
"    let g:airline_symbols.branch = 'ᚠ'
"    let g:airline_symbols.paste = 'ρ'
"    let g:airline_symbols.spell = 'Ꞩ'
"    let g:airline_symbols.notexists = '∄'
"    let g:airline_symbols.whitespace = 'Ξ'
"endif

" {{{1 NERDTree Configs
"
nnoremap <silent> <F9> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "!",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "▸",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "x",
    \ "Dirty"     : "%",
    \ "Clean"     : "O",
    \ 'Ignored'   : '-',
    \ "Unknown"   : "?"
    \ }

" {{{1 Justfile
autocmd BufNewFile,BufRead justfile set filetype=make

" {{{1 Clean up white spaces before saving
autocmd BufWritePre *.md,*.puml,*.tex %s/\s\+$//e

" {{{1 auto pairs
"au Filetype rust let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`', '```':'```'}
" {{{1 remap keys
map <S-PageDown> :tabnext<cr>
map <S-PageUp> :tabprevious<cr>

nnoremap gh :nohlsearch<CR>

"au FileType c,c++,rust,javascript,json,graphql inoremap {<cr> {<cr>}<up><end><cr>
"au FileType c,c++,rust,javascript,json,graphql inoremap { {}<left>
"au FileType c,c++,rust,python,javascript,graphql inoremap {<esc> {<esc>
"au FileType c,c++,rust,javascript,json,graphql inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<right>" : "}"
"
"au FileType c,c++,rust,javascript,json,graphql inoremap [<cr> [<cr>]<up><end><cr>
"au FileType c,c++,rust,javascript,json,graphql inoremap [ []<left>
"au FileType c,c++,rust,python,javascript,graphql inoremap [<esc> [<esc>
"au FileType c,c++,rust,javascript,json,graphql inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<right>" : "]"
"
"au FileType c,c++,rust,python,javascript,graphql inoremap (<cr> (<cr>)<up><end><cr>
"au FileType c,c++,rust,python,javascript,graphql inoremap ( ()<left>
"au FileType c,c++,rust,python,javascript,graphql inoremap (<esc> (<esc>
"au FileType c,c++,rust,python,javascript,graphql inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<right>" : ")"
"
"" html tags
"au FileType javascript,html inoremap < <><left>
"au FileType javascript,html inoremap <<space> <<space>
""au FileType javascript,html inoremap </ < /><left><left><left>
"au FileType javascript,html inoremap <expr> > strpart(getline('.'), col('.')-1, 1) == ">" ? "\<right>" : ">"
"au FileType javascript,html inoremap <expr> <cr> match(getline('.'), '<[^/ ]\+>') >= 0 ? '<cr>/<esc>O' : '<cr>'

" wrapping
vnoremap _( <esc>`>a)<esc>`<i(<esc>
vnoremap _[ <esc>`>a]<esc>`<i[<esc>
vnoremap _{ <esc>`>a}<esc>`<i{<esc>
vnoremap _* <esc>`>a**<esc>`<i**<esc>
vnoremap _+ <esc>`>a*<esc>`<i*<esc>

" {{{1 General Configs
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set timeout ttimeoutlen=10
set backspace=indent,eol,start
set title

autocmd Filetype html,htmldjango,json,javascript,typescript,typescript.tsx,css,yaml,dart setlocal tabstop=2 shiftwidth=2
autocmd Filetype markdown,csv,pandoc setlocal keywordprg=dict
"autocmd Filetype markdown,csv set keywordprg=trans\ -d\ -no-ansi\ :zh
autocmd Filetype javascript,typescript,javascript.tsx,typescript.tsx setlocal foldmethod=syntax

set encoding=utf-8 fileencodings=ucs-bom,utf-8,shift-jis,cp936

" {{{1 Custom filetype autocommands
autocmd filetype typescript,javascript,typescript.jsx,javascript.jsx,python setlocal foldmethod=marker

" {{{1 Netrw
let g:netrw_browsex_viewer= "xdg-open"
