"set termguicolors

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Nvim specific config
set mouse=""

" Lua configuration
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,

    -- list of language that will be disabled
    disable = { "markdown" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
require('tree-sitter-just').setup{}
EOF

if exists("g:neovide")
    let g:neovide_transparency=0.7
endif
