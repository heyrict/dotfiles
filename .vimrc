" Change Default Language
language en_US.utf8

" VUNDLE SETTINGS
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
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'davidhalter/jedi-vim'
Plugin 'maralla/completor.vim'
"Plugin 'artur-shaik/vim-javacomplete2'
" Previm
Plugin 'kannokanno/previm'
" Tlist
Plugin 'taglist-plus'
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
Plugin 'mxw/vim-jsx'
Plugin 'jparise/vim-graphql'

" Color Schema
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-airline/vim-airline-themes'
"
" ALE
Plugin 'w0rp/ale'

" For htmldjango
"Plugin 'mjbrownie/vim-htmldjango_omnicomplete'
" For markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Orgmod
"Plugin 'jceb/vim-orgmode'
"Plugin 'tpope/vim-speeddating'


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

" Custom Commands
"
" Run Command
function RunFile()
    up
    if expand('%:e') == "py"
        :exec '! python3 ' . @%
    elseif expand('%:e') == "c"
        :exec '! gcc ' . @% . ' -o ' . expand('%:r') . ".out ;gdb " . expand('%:r') . ".out"
    elseif expand('%:e') == "cpp"
        :exec '! g++ -std=c++11 ' . @% . ' -o ' . expand('%:r') . ".out ;gdb " . expand('%:r') . ".out"
    elseif expand('%:e') == "kv"
        if filereadable("main.py")
            :exec "! python3 main.py"
        else
            :exec "! python3 " . expand('%:r') . "*.py"
        endif
    endif
endfunction
command R :call RunFile()

function FMTHTML()
    w
    %s/%20/ /g
    %s/%7D/}/g
    %s/%7B/{/g
    %s/&quot\;/'/g
endfunction
command FMTHTML :call FMTHTML()

function FMTSYM()
    w
    " :exec "!symexchange -s -x ', ，' -x '. 。' %"
    :exec "!symexchange -s %"
endfunction
command FMTSYM :call FMTSYM()

function ModifyTable()
    w
    :exec "!tableutils -Ppnr %"
endfunction
command M :call ModifyTable()

au FileType c,c++ inoremap { {}<left>
au FileType c,c++ inoremap [ []<left>

" omni complete functions
au FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
let g:htmldjangocomplete_html_flavour = 'html5'
au FileType htmldjango inoremap {% {%  %}<left><left><left>
au FileType htmldjango inoremap {{ {{  }}<left><left><left>

" vim-markdown configs
let g:vim_markdown_folding_level = 3
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
"let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'python=py']

set foldmethod=marker

" Ale Configs
if $LAPTOP_MODE==0
    let g:ale_lint_on_save=1
    let g:ale_fix_on_save=1
    let g:ale_enabled=1
else
    let g:ale_enabled=0
endif

let g:ale_java_javac_classpath='/opt/jdk1.8.0_144/bin/javac'
let g:ale_python_pylint_executable='pylint3'
let g:ale_python_pylint_use_global=1
let g:ale_python_yapf_use_global=1
let g:ale_javascript_prettier_use_global=1
let g:ale_javascript_prettier_use_local_config=1
let g:ale_html_tidy_executable='tidy'
let g:ale_linters = {
\   'javascript': [ 'eslint' ],
\   'typescript': [ 'eslint' ],
\}
let g:ale_fixers = {
\   'javascript': [ 'prettier' ],
\   'typescript': [ 'prettier' ],
\   'json': [ 'prettier' ],
\   'python': [ 'isort' , 'yapf' ],
\   'css': [ 'prettier' ],
\}

" Solarized Color Scheme Configs
let g:solarized_visibility="high"
call togglebg#map("<F5>")
syntax enable
if $TERM=="screen-256color"
    let g:solarized_termcolors=256
    colorscheme solarized
elseif $TERM=="xterm-256color"
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
set background=dark

" Airline Configs
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_modified=1
"let g:airline_section_c = airline#section#create_right(['ffenc','bat'])
"let g:airline_section_b = '%-0.10{getcwd()}'
"let g:airline_section_c = '%t'
"let g:airline_section_c = airline#section#create(['%{cat /sys/class/power_supply/BAT1/capacity}'])
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmuxline.snapshot"
let g:airline#extensions#wordcount#enabled = 0
"let g:airline#extensions#wordcount#format = '%d words'
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

if $TERM=="linux"
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = '>'
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = '<'
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '@'
    let g:airline_symbols.readonly = '[ro]'
    let g:airline_symbols.linenr = '|'
    let g:airline_symbols.crypt = '[l]'
    let g:airline_symbols.maxlinenr = ' {ln}'
    let g:airline_symbols.paste = '[p]'
    let g:airline_symbols.spell = '[s]'
    let g:airline_symbols.notexists = '[ne]'
    let g:airline_symbols.whitespace = ''
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
endif

" tmuxline Configs
if $TERM == "linux"
    let g:tmuxline_separators = {
      \ 'left' : '>',
      \ 'left_alt': '',
      \ 'right' : '<',
      \ 'right_alt' : '',
      \ 'space' : ' '}
else
    let g:tmuxline_separators = {
      \ 'left' : '»',
      \ 'left_alt': '',
      \ 'right' : '«',
      \ 'right_alt' : '',
      \ 'space' : ' '}
endif

let g:tmuxline_preset = {
  \'a'       : '#S',
  \'b'       : '#W',
  \'win'     : '#I #W',
  \'cwin'    : '#I #W',
  \'y'       : '#(cat /sys/class/backlight/intel_backlight/brightness)/#(cat /sys/class/backlight/intel_backlight/max_brightness)[#(cat /sys/class/power_supply/BAT1/capacity)%%]{#(cat /sys/class/power_supply/BAT1/power_now)}',
  \'z'       : '%Y-%m-%d %H:%M',
  \'options' : {'status-justify' : 'left'}}

" Tlist Variables
"
let Tlist_Auto_Highlight_Tag=1
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1
let Tlist_Close_On_Select=1
let Tlist_Display_Tag_Scope=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Enable_Dold_Column=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_Use_Right_Window=1
let Tlist_Use_SingleClick=1
command T TlistOpen
nnoremap <silent> <F8> :TlistToggle<CR>

" vim-jsx Configs
let g:jsx_ext_required = 0

" Jedi-vim Configs
"
"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<Tab>"
"let g:jedi#rename_command = "<leader>r"

" YCM Variables
"
"let g:ycm_global_ycm_extra_conf='~/Eric/backup/.ycm_global_ycm_extra_conf'
"let g:ycm_confirm_extra_conf=0
"let g:ycm_python_binary_path= '/usr/bin/python3.5'
"filetype plugin on
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascrīpt set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete


" Completor.vim Configs
let g:completor_python_binary = 'python3'
let g:completor_node_binary = 'node'
let g:completor_auto_close_doc = 1
let g:completor_doc_position = 'top'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" TMUX Configs
":if $TMUX
": set term=screen
":endif

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set timeout ttimeoutlen=50

autocmd Filetype html,htmldjango,json,javascript,typescript set tabstop=2 shiftwidth=2
autocmd Filetype markdown set keywordprg=dict

execute pathogen#infect()

set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

" Previm Variables
"
let g:previm_open_cmd='xdg-open'
let g:previm_enable_realtime = 10
"let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '~/Templates/solarized-light.min.css'

" NERDTree Configs
"
command F up | NERDTree
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

"" OrgMode Configs
"let g:org_indent = 0
"let g:org_agenda_files = ['~/org/*.org']
""let g:org_todo_keywords = [
"" \ ['TODO(t)', '|', 'DONE(d)'],
"" \ ['REPORT(r)', 'BUG(b)', 'KNOWNCAUSE(k)', '|', 'FIXED(f)'],
"" \ ['CANCELED(c)']]

" Clean up white spaces before saving
autocmd BufWritePre *.c,*.cpp,*.py,*.md,*.markdown,*.mkd,*.tex %s/\s\+$//e

" remap keys
map <S-PageDown> :tabnext<cr>
map <S-PageUp> :tabprevious<cr>
