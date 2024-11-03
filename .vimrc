" vim:foldmethod=marker

" {{{1 Change Default Language
language en_US.utf8

" {{{1 Vim-Plug settings
set nocompatible
filetype off

if ! empty(globpath(&rtp, 'autoload/plug.vim'))
    " set the runtime path to include Vundle and initialize
    call plug#begin('~/.vim/plugged')

    " Git
    Plug 'tpope/vim-fugitive'

    " Tlist
    Plug 'majutsushi/tagbar', { 'on': ['TlistToggle', 'TlistOpen', 'TagbarToggle'] }
    " autoswitch fcitx-remote
    let g:fcitx5_remote = '/usr/bin/fcitx5-remote'
    Plug 'lilydjwg/fcitx.vim'
    " NERD_tree
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " Programming languages and Syntax highlights
    " Justfile
    Plug 'NoahTheDuke/vim-just'

    " Javascript Environment
    Plug 'pangloss/vim-javascript'
    Plug 'MaxMEllon/vim-jsx-pretty'
    "Plug 'mxw/vim-jsx'
    "Plug 'jparise/vim-graphql'
    " For Typescript
    "Plug 'leafgarland/typescript-vim'
    "Plug 'peitalin/vim-jsx-typescript'

    " Python Environment
    Plug 'Vimjas/vim-python-pep8-indent'

    " For toml
    Plug 'cespare/vim-toml'

    " For markdown
    Plug 'godlygeek/tabular'
    "Plug 'preservim/vim-markdown'
    Plug 'heyrict/vim-pandoc-syntax', { 'branch': 'allow-consecutive-heading' }
    Plug 'vim-pandoc/vim-pandoc'

    " Color Schema
    "Plug 'altercation/vim-colors-solarized'
    "Plug 'lifepillar/vim-solarized8'
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    "Plug 'edkolev/tmuxline.vim'
    Plug 'vim-airline/vim-airline-themes'

    " Folding
    Plug 'Konfekt/FastFold'

    " Pairing
    Plug 'tmsvg/pear-tree'

    " Folders
    " All of your Plugins must be added before the following line
    call plug#end()            " required
    filetype plugin indent on    " required
    " VUNDLE SETTINGS END
endif

" {{{1 fastfold configs
let g:fastfold_fold_command_suffixes = []

" {{{1 vim-markdown configs
"let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'tsx=typescript.tsx']
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_toc_autofit = 1
"let g:vim_markdown_anchorexpr = "'<<'.v:anchor.'>>'"

" {{{1 vim-pandoc configs
"let g:pandoc#filetypes#pandoc_markdown = 1
let g:pandoc#folding#fastfolds = 0
let g:pandoc#folding#fdc = 0
let g:pandoc#folding#fold_yaml = 1
let g:pandoc#folding#level = 1
let g:pandoc#folding#mode = 'syntax'
let g:pandoc#modules#disabled = ['bibliographies', 'completion', 'spell']
"let g:pandoc#spell#default_langs = ['en_us', 'cjk']

" Fix consecutive heading highlighting https://github.com/vim-pandoc/vim-pandoc-syntax/issues/391
augroup consecutive_heading
    au!
    au filetype pandoc syn clear pandocAtxHeader
    au filetype pandoc syn match pandocAtxHeader /\(\%^\|<.\+>.*\|^\s*\)\@<=#\{1,6}.*\n/ contains=pandocEmphasis,pandocStrong,pandocNoFormatted,pandocLaTeXInlineMath,pandocEscapedDollar,@Spell,pandocAmpersandEscape,pandocReferenceLabel,pandocReferenceURL display
augroup END

" Adding bullet support
autocmd filetype pandoc,markdown set comments+=b:*,b:-,b:+
autocmd filetype pandoc,markdown set formatoptions+=rmB
autocmd filetype pandoc,markdown set nolinebreak

" Update folding in nvim
if has('nvim')
    nnoremap zuz :PandocFolding syntax<CR>
endif

" {{{1 vim-typescript configs
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
"autocmd BufNewFile,BufRead /home/heyrict/Eric/MyPrograms/reactnativeproj/* set nowritebackup

" {{{1 pest grammar files
autocmd BufRead,BufNewFile "*.pest" set filetype=c
autocmd BufRead,BufNewFile "*.pest" let b:coc_enabled = 0

" {{{1 Color Scheme Configs

" {{{2 Solarized Color Scheme Configs
"let g:solarized_visibility="high"
"call togglebg#map("<F5>")
"syntax enable
"if $TERM=="xterm-256color"
"    let g:solarized_termtrans=1
"    colorscheme solarized8
"elseif $TERM=="xterm"
"    let g:solarized_termtrans=1
"    let g:solarized_termcolors=256
"    let g:solarized_contrast="high"
"    colorscheme solarized8
"elseif $TERM=="linux"
"    let g:solarized_termcolors=16
"    colorscheme solarized8
"elseif $TERM=="fbterm"
"    let g:solarized_termcolors=256
"    colorscheme solarized8
"elseif $TERM=="alacritty"
"    let g:solarized_termtrans=0
"    let g:solarized_termcolors=16
"    let g:solarized_termtrans=1
"    colorscheme solarized8
"else
"    colorscheme solarized8
"endif

" {{{2 Gruvbox Color Scheme Configs
"let g:solarized_visibility="high"
"call togglebg#map("<F5>")

" Don't use syntax highlighting for nvim
if !has('nvim')
    syntax enable
endif

if $TERM=="xterm-256color"
    let g:gruvbox_transparent_bg=1
    colorscheme gruvbox
elseif exists('g:neovide')
    let g:gruvbox_transparent_bg=1
    let g:gruvbox_termcolors=256
    colorscheme gruvbox
elseif $TERM=="xterm"
    let g:gruvbox_transparent_bg=1
    let g:gruvbox_termcolors=256
    let g:gruvbox_contrast_dark="hard"
    let g:gruvbox_contrast_light="hard"
    colorscheme gruvbox
elseif $TERM=="linux"
    let g:gruvbox_termcolors=16
    colorscheme gruvbox
elseif $TERM=="fbterm"
    let g:gruvbox_termcolors=256
    colorscheme gruvbox
elseif $TERM=="alacritty"
    autocmd VimEnter * hi Normal ctermbg=NONE
    let g:gruvbox_termcolors=256
    let g:gruvbox_transparent_bg=1
    colorscheme gruvbox
else
    colorscheme gruvbox
endif

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
    let g:airline_theme='gruvbox'
else
    let g:airline_theme='gruvbox'
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

" {{{1 tmuxline Configs
"if $TERM == "linux"
"    let g:tmuxline_separators = {
"      \ 'left' : '>',
"      \ 'left_alt': '',
"      \ 'right' : '<',
"      \ 'right_alt' : '',
"      \ 'space' : ' '}
"else
"    let g:tmuxline_separators = {
"      \ 'left' : '»',
"      \ 'left_alt': '',
"      \ 'right' : '«',
"      \ 'right_alt' : '',
"      \ 'space' : ' '}
"endif

let g:tmuxline_preset = {
  \'a'       : '#S',
  \'b'       : '#W',
  \'win'     : '#I #W',
  \'cwin'    : '#I #W',
  \'x'       : "t=#(rg background_opacity ~/.config/alacritty/alacritty.yml | awk '{print $2}')",
  \'y'       : '#(cat /sys/class/backlight/intel_backlight/brightness)/#(cat /sys/class/backlight/intel_backlight/max_brightness)[#(cat /sys/class/power_supply/BAT1/capacity)%#(cat /sys/class/power_supply/BAT1/status | head -c 1)]{#(cat /sys/class/power_supply/BAT1/power_now | sed "s/0\\\\{1,3\\\\}$//")}',
  \'z'       : '%m-%d@%H:%M',
  \'options' : {'status-justify' : 'left'}}

" {{{1 tagbar Variables
nnoremap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'kinds' : [
        \ 'c:h1',
        \ 's:h2',
        \ 'S:h3',
        \ 't:h4',
        \ 'T:h5',
        \ 'u:h6',
    \ ],
\ }

let g:tagbar_type_rust = {
\ 'ctagstype' : 'rust',
\ 'kinds' : [
    \ 'n:modules',
    \ 's:structures:1',
    \ 'i:interfaces',
    \ 'c:implementations',
    \ 'f:functions:1',
    \ 'g:enumerations:1',
    \ 't:type aliases:1:0',
    \ 'v:constants:1:0',
    \ 'M:macros:1',
    \ 'm:fields:1:0',
    \ 'e:enum variants:1:0',
    \ 'P:methods:1',
\ ],
\ 'sro': '::',
\ 'kind2scope' : {
    \ 'n': 'module',
    \ 's': 'struct',
    \ 'i': 'interface',
    \ 'c': 'implementation',
    \ 'f': 'function',
    \ 'g': 'enum',
    \ 't': 'typedef',
    \ 'v': 'variable',
    \ 'M': 'macro',
    \ 'm': 'field',
    \ 'e': 'enumerator',
    \ 'P': 'method',
\ },
\ }

"" {{{1 vim-jsx Configs
"let g:jsx_ext_required = 0

" vim-jsx-pretty Configs
let g:vim_jsx_pretty_colorful_config = 1

" {{{1 TMUX Configs
":if $TMUX
": set term=screen
":endif

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

" {{{1 Rust Configs
let g:rust_fold = 1

" {{{1 Custom Commands
"
" Run Command
command -nargs=* CargoRun update | execute "!cargo run" <q-args>

function RunFile()
    up
    if &ft == "python"
        :exec '! python3 ' . @%
    elseif &ft == "c"
        :exec '! gcc ' . @% . ' -o ' . expand('%:r') . ".out ;gdb " . expand('%:r') . ".out"
    elseif &ft == "cpp"
        :exec '! g++ -std=c++11 ' . @% . ' -o ' . expand('%:r') . ".out ;gdb " . expand('%:r') . ".out"
    elseif &ft == "rust"
        :exec '! cargo run'
    elseif &ft == "tex"
        if filereadable("justfile")
            :exec "! just"
		else
			:exec '! xelatex ' . @%
		endif
	elseif &ft == "pandoc" || &ft == "markdown"
        if filereadable("justfile")
            :exec "! just"
		else
			:exec '! pandoc ' . @% . ' -o ' . expand('%:r') . ".html"
		endif
    elseif expand('%:e') == "kv"  "python kivy template file
        if filereadable("main.py")
            :exec "! python3 main.py"
        else
            :exec "! python3 " . expand('%:r') . "*.py"
        endif
    endif
endfunction
command Run :call RunFile()
nnoremap g<C-R> :call RunFile()<cr>

"function FMTHTML()
"    w
"    %s/%20/ /g
"    %s/%7D/}/g
"    %s/%7B/{/g
"    %s/&quot\;/'/g
"endfunction
"command FMTHTML :call FMTHTML()

function FMTTable()
    let l:pos = getpos('.')
    normal! {
    " Search instead of `normal! j` because of the table at beginning of file edge case.
    call search('|')
    normal! j
    " Remove everything that is not a pipe, colon or hyphen next to a colon othewise
    " well formated tables would grow because of addition of 2 spaces on the separator
    " line by Tabularize /|.
    let l:flags = (&gdefault ? '' : 'g')
    if match(getline('.'), "^[ |:-]\\+$") == -1
        normal! kyyp
    endif
    execute 's/\(:\@<!-:\@!\|[^|:-]\)//e' . l:flags
    execute 's/--/-/e' . l:flags
    Tabularize /|
    " Move colons for alignment to left or right side of the cell.
    execute 's/:\( \+\)|/\1:|/e' . l:flags
    execute 's/|\( \+\):/|:\1/e' . l:flags
    execute 's/ /-/' . l:flags
    normal! 0
    if matchstr(getline('.'), '\%'.col('.').'c.') == '-'
        normal! vt|r
    endif
    call setpos('.', l:pos)
endfunction
command FT :call FMTTable()

" {{{1 Clean up white spaces before saving
autocmd BufWritePre *.puml,*.tex %s/\s\+$//e
set lcs+=space:·

" {{{1 auto pairs
"au Filetype rust let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`', '```':'```'}
" {{{1 pear-tree
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ '"': {'closer': '"'},
            \ "'": {'closer': "'"},
            \ "`": {'closer': "`"},
            \ }

let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 1
let g:pear_tree_repeatable_expand = 0

autocmd Filetype markdown exe "let b:pear_tree_smart_openers = 0"

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
vnoremap _" <esc>`>a"<esc>`<i"<esc>
vnoremap _' <esc>`>a'<esc>`<i'<esc>
vnoremap _` <esc>`>a`<esc>`<i`<esc>
vnoremap _c <esc>`>a}}<esc>`<i{{c1::<esc>hh
autocmd filetype pandoc,markdown,html vnoremap _! <esc>`>a --><esc>`<i<!-- <esc>

" Anki related
autocmd filetype yaml vnoremap _1 <esc>`>a}}<esc>`<i{{c1::<esc>
autocmd filetype yaml vnoremap _2 <esc>`>a}}<esc>`<i{{c2::<esc>
autocmd filetype yaml vnoremap _3 <esc>`>a}}<esc>`<i{{c3::<esc>

" Wayland clipboard support
" https://github.com/vim/vim/issues/5157
if getenv("NOCOMPL") != v:null
    xnoremap "+y y:call system("wl-copy", @")<cr>
    nnoremap "+p :let @+=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>"+p
    nnoremap "*p :let @*=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>"*p
endif

" {{{1 General Configs
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set number relativenumber
set timeout ttimeoutlen=10
set backspace=indent,eol,start
set title

autocmd Filetype html,htmldjango,json,javascript,typescript,typescript.tsx,css,yaml,dart setlocal tabstop=2 shiftwidth=2
autocmd Filetype just setlocal noexpandtab
autocmd Filetype markdown,csv,pandoc setlocal keywordprg=sdcv\ -n
"autocmd Filetype markdown,csv,pandoc setlocal keywordprg=dict
"autocmd Filetype markdown,csv set keywordprg=trans\ -d\ -no-ansi\ :zh
autocmd Filetype javascript,typescript,javascript.tsx,typescript.tsx setlocal foldmethod=syntax

set encoding=utf-8 fileencodings=ucs-bom,utf-8,shift-jis,cp932,cp936

" {{{1 Custom filetype autocommands
autocmd filetype typescript,javascript,typescript.jsx,javascript.jsx,python setlocal foldmethod=marker
autocmd BufNewFile,BufRead *.ERH,*.ERB set filetype=freebasic
"autocmd BufNewFile,BufRead *.md set syntax=markdown

" {{{1 Netrw
let g:netrw_browsex_viewer= "xdg-open"
