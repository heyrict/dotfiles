set termguicolors

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists("g:neovide")
    let g:neovide_transparency=0.7
endif
