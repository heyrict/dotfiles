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
" Previm
Plugin 'kannokanno/previm'
" Tlist
Plugin 'taglist-plus'
" STL references
Plugin 'stlrefvim'
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
"
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
nnoremap <silent> <F8> :TlistToggle<CR>

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
"
" Completor.vim Configs
let g:completor_python_binary = 'python3'
"let g:completor_auto_close_doc = 0
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" TMUX Configs
:if $TMUX
: set term=screen
:endif

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set timeout ttimeoutlen=50

execute pathogen#infect()

set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

" Previm Variables
"
let g:previm_open_cmd='firefox'
let g:previm_enable_realtime = 10
"let g:previm_disable_default_css = 1
"let g:previm_custom_css_path = '~/.vim/bundle/previm/preview/css/origin.css'

" NERDTree Configs
"
command F w | NERDTree
command T TlistOpen
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

" Clean up white spaces before saving
autocmd BufWritePre *.c,*.cpp,*.py,*.md,*.markdown,*.mkd,*.tex %s/\s\+$//e

" Run Command
function RunFile()
    wa
    if expand('%:e') == "py"
        :exec '! python3 ' . @%
    elseif expand('%:e') == "c"
        :exec '! gcc ' . @% . ' -o ' . expand('%:r') . ".out ;gdb " . expand('%:r') . ".out"
    elseif expand('%:e') == "cpp"
        :exec '! g++ ' . @% . ' -o ' . expand('%:r') . ".out ;gdb " . expand('%:r') . ".out"
    elseif expand('%:e') == "kv"
        if filereadable("main.py")
            :exec "! python3 main.py"
        else
            :exec "! python3 " . expand('%:r') . "*.py"
        endif
    endif
endfunction
command R :call RunFile()
