" vim:foldmethod=marker

" {{{1 Change Default Language
language en_US.utf8

" {{{1 VUNDLE SETTINGS
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/ericx/.vim/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"
" Customized Plugins
"
" Auto Complete
if getenv("NOCOMPL") == v:null
  "Plugin 'Valloric/YouCompleteMe'
  "Plugin 'Shougo/deoplete.nvim'
  "Plugin 'tbodt/deoplete-tabnine'
  Plugin 'neoclide/coc.nvim'
endif

"Plugin 'zxqfl/tabnine-vim'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'maralla/completor.vim'
"Plugin 'artur-shaik/vim-javacomplete2'
" Previm
Plugin 'kannokanno/previm'
" Tlist
"Plugin 'taglist-plus'
Plugin 'majutsushi/tagbar'
" STL references
"Plugin 'stlrefvim'
" autoswitch fcitx-remote
Plugin 'fcitx.vim'
" syntax highlight for .qml files
Plugin 'peterhoeg/vim-qml'
" NERD_tree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
" kivy syntax highlight
"Plugin 'farfanoide/vim-kivy'
Plugin 'file://home/ericx/.vim/bundle/custom_vim_kivy'

" Javascript Environment
Plugin 'pangloss/vim-javascript'
Plugin 'MaxMEllon/vim-jsx-pretty'
"Plugin 'mxw/vim-jsx'
Plugin 'jparise/vim-graphql'
" For Typescript
"Plugin 'leafgarland/typescript-vim'
"Plugin 'peitalin/vim-jsx-typescript'

"Plugin 'alvan/vim-closetag'

" Python Environment
Plugin 'Vimjas/vim-python-pep8-indent'

" For htmldjango
"Plugin 'mjbrownie/vim-htmldjango_omnicomplete'

" Julia Environment
"Plugin 'JuliaEditorSupport/julia-vim'

" Flutter Environment
Plugin 'dart-lang/dart-vim-plugin'

" Color Schema
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-airline/vim-airline-themes'
"
" ALE
"Plugin 'w0rp/ale'

" For markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'vim-pandoc/vim-pandoc-syntax'
"Plugin 'vim-pandoc/vim-pandoc'
" For toml
Plugin 'cespare/vim-toml'

" Orgmod
"Plugin 'jceb/vim-orgmode'
"Plugin 'tpope/vim-speeddating'
" Organized Text
Plugin 'vimoutliner/vimoutliner'
" Task warrior
"Plugin 'farseer90718/vim-taskwarrior'

" Pairing
"Plugin 'jiangmiao/auto-pairs'
Plugin 'tmsvg/pear-tree'

" Folders
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" VUNDLE SETTINGS END

" {{{1 vim-markdown configs
let g:vim_markdown_folding_level = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'tsx=typescript.tsx']
let g:vim_markdown_follow_anchor = 1

" {{{1 vim-pandoc configs
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#folding#fold_yaml = 1
let g:pandoc#folding#mode = 'relative'

" {{{1 vim-typescript configs
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
"autocmd BufNewFile,BufRead /home/heyrict/Eric/MyPrograms/reactnativeproj/* set nowritebackup

" {{{1 pest grammar files
autocmd BufRead,BufNewFile "*.pest" set filetype=c
autocmd BufRead,BufNewFile "*.pest" let b:coc_enabled = 0

"" {{{1 Ale Configs
"function! OnBattery()
"    return readfile('/sys/class/power_supply/ACAD/online') == ['0']
"endfunction
"if OnBattery()
"    let g:ale_lint_on_save=1
"    let g:ale_fix_on_save=1
"    let g:ale_enabled=1
"else
"    let g:ale_lint_on_text_changed=0
"    let g:ale_lint_on_insert_leave=0
"    let g:ale_lint_on_enter=0
"    let g:ale_lint_on_save=1
"    let g:ale_fix_on_save=1
"    let g:ale_enabled=1
"endif
"
"set omnifunc=ale#completion#OmniFunc
""inoremap jk <C-X><C-O>
"imap jk <Plug>(ale_complete)
"nnoremap <silent> <F2> :ALEHover<CR>
"nnoremap <silent> <F3> :ALEDocumentation<CR>
"nnoremap <silent> <F4> :if &mod \| :ALEGoToDefinitionInSplit \| else \| :ALEGoToDefinition \| endif<CR>
"
"" Tab to complete
"inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"
"let g:ale_completion_enabled = 1
"let g:ale_completion_tsserver_autoimport = 1
"let g:ale_linters = {
"\   'javascript': [ 'eslint' ],
"\   'typescript': [ 'tsserver' ],
"\   'rust': [ 'rls' ],
"\   'html': [ 'tidy' ],
"\   'python': [ 'pyls' ]
"\}
"
""let g:ale_java_javac_classpath='/opt/jdk1.8.0_181/bin/javac'
"let g:ale_python_pylint_use_global=1
"let g:ale_python_pylint_options = '--rcfile /home/heyrict/.pylintrc'
"let g:ale_python_yapf_use_global=1
""let g:ale_javascript_prettier_use_global=1
""let g:ale_javascript_eslint_use_global=1
"let g:ale_fixers = {
"\   'javascript': [ 'prettier' ],
"\   'typescript': [ 'prettier' ],
"\   'json': [ 'prettier' ],
"\   'rust': [ 'rustfmt' ],
"\   'python': [ 'isort' , 'yapf' ],
"\   'css': [ 'prettier' ],
"\}

" {{{1 Coc Configs
"inoremap jk <C-X><C-O>
nnoremap <silent> <F3> :ALEDocumentation<CR>
nnoremap <silent> <F4> :if &mod \| <Plug>(coc-definition) \| else \| :ALEGoToDefinition \| endif<CR>
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>ca <Plug>(coc-codeaction)
nmap <silent> <Leader>fj <Plug>(coc-float-jump)
nmap <silent> <Leader>rf <Plug>(coc-refactor)
nmap <Leader>fi <Plug>(coc-fix-current)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (index(['css','text', 'markdown'], &filetype) >= 0)
        execute '! trans -d -no-ansi :zh '.expand("'<cword>'")
    else
        call CocAction('doHover')
    endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Tab to complete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Formatting
command! -nargs=0 Fix :CocFix
command! -nargs=0 Fmt :call CocAction('format')
command! -nargs=0 Organize   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Diagnostics navigation
nmap <silent> <space>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <space>] <Plug>(coc-diagnostic-next)

" Maybe related to signature
augroup coc_group
  autocmd!
  " Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" {{{1 Solarized Color Scheme Configs
let g:solarized_visibility="high"
call togglebg#map("<F5>")
syntax enable
if $TERM=="xterm-256color"
    let g:solarized_termtrans=1
    colorscheme solarized
elseif $TERM=="xterm"
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    let g:solarized_contrast="high"
    colorscheme solarized
elseif $TERM=="linux"
    let g:solarized_termcolors=16
    colorscheme solarized
elseif $TERM=="fbterm"
    let g:solarized_termcolors=256
    colorscheme solarized
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

"" {{{1 taglist Variables
""
"let Tlist_Auto_Highlight_Tag=1
"let Tlist_Auto_Open=0
"let Tlist_Auto_Update=1
"let Tlist_Close_On_Select=1
"let Tlist_Display_Tag_Scope=1
"let Tlist_Exit_OnlyWindow=1
"let Tlist_Enable_Dold_Column=1
"let Tlist_File_Fold_Auto_Close=1
"let Tlist_Show_One_File=1
"let Tlist_Use_Right_Window=1
"let Tlist_Use_SingleClick=1
"let tlist_markdown_settings = 'markdown;h:h1;i:h2;j:h3;k:h4'
"let tlist_javascript_settings = 'javascript;s:const;c:class;l:let'
""command T TlistOpen
"nnoremap <silent> <F8> :TlistToggle<CR>

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

" {{{1 Jedi-vim Configs
"
"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<Tab>"
"let g:jedi#rename_command = "<leader>r"

"" {{{1 YCM Variables
""let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_key_invoke_completion = 'jk'
"let g:ycm_seed_identifiers_with_syntax=1
""let g:ycm_confirm_extra_conf=0
""set completeopt=longest,menu
"set completeopt=menu
"
"nnoremap <silent> <F2> :YcmCompleter GetDoc<CR>
"nnoremap <silent> <F3> :YcmCompleter GetType<CR>
"nnoremap <silent> <F4> :YcmCompleter GoTo<CR>
"command Fix :YcmCompleter FixIt
"
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
""let g:ycm_min_num_of_chars_for_completion = 2

"" {{{1 Deoplete Variables
"if has('nvim')
"  let g:deoplete#enable_at_startup=1
"
"  " Tab to complete
"  inoremap <silent><expr> <TAB>
"              \ pumvisible() ? "\<C-n>" :
"              \ <SID>check_back_space() ? "\<TAB>" :
"              \ deoplete#mappings#manual_complete()
"  function! s:check_back_space() abort "{{{
"      let col = col('.') - 1
"      return !col || getline('.')[col - 1]  =~ '\s'
"  endfunction"}}}
"endif


" {{{1 Completor.vim Configs
"let g:completor_python_binary = 'python3'
"let g:completor_node_binary = 'node'
"let g:completor_auto_close_doc = 1
"let g:completor_doc_position = 'top'
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" {{{1 TMUX Configs
":if $TMUX
": set term=screen
":endif

" {{{1 General Configs
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set timeout ttimeoutlen=50
set backspace=indent,eol,start

autocmd Filetype html,htmldjango,json,javascript,typescript,typescript.tsx,css,yaml,dart set tabstop=2 shiftwidth=2
autocmd Filetype markdown,csv set keywordprg=dict
"autocmd Filetype markdown,csv set keywordprg=trans\ -d\ -no-ansi\ :zh
autocmd Filetype javascript,typescript,javascript.tsx,typescript.tsx set foldmethod=syntax

set encoding=utf-8 fileencodings=ucs-bom,utf-8,shift-jis,cp936

" {{{1 Previm Variables
"
let g:previm_open_cmd='xdg-open'
let g:previm_enable_realtime = 10
"let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '~/assets/css/solarized-light.min.css'

" {{{1 NERDTree Configs
"
nnoremap <silent> <F9> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeIndicatorMapCustom = {
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

"" {{{1 OrgMode Configs
"let g:org_indent = 0
"let g:org_agenda_files = ['~/org/*.org']
""let g:org_todo_keywords = [
"" \ ['TODO(t)', '|', 'DONE(d)'],
"" \ ['REPORT(r)', 'BUG(b)', 'KNOWNCAUSE(k)', '|', 'FIXED(f)'],
"" \ ['CANCELED(c)']]

"" {{{1 vim-closetag Configs
"let g:closetag_filenames = "*.html,*.xhtml,*.jsx,*.js,*.tsx,*.ts"
"let g:closetag_regions = {
"\ 'typescript': 'jsxRegion,tsxRegion',
"\ 'javascript': 'jsxRegion',
"\ }
"let g:closetag_xhtml_filetypes = 'xhtml,javascript,typescript'

" {{{1 Rust Configs
let g:rust_fold = 1

" {{{1 Justfile
autocmd BufNewFile,BufRead justfile set filetype=make

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
        :exec '! xelatex ' . @% . ";evince " . expand('%:r') . ".pdf"
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
autocmd BufWritePre *.md,*.puml,*.tex %s/\s\+$//e

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

" {{{1 Custom filetype autocommands
autocmd filetype typescript,javascript,typescript.jsx,javascript.jsx,python set foldmethod=marker

" {{{1 Netrw
let g:netrw_browsex_viewer= "xdg-open"
