if exists('g:GtkGuiLoaded')
    colorscheme darkblue
    call rpcnotify(1, 'Gui', 'Font', 'Fira Code Retina 10')
    call NGTransparency .8
endif

set guifont=Fira\ Code,WenQuanYi\ Micro\ Hei\ Mono:h15
set guifontwide=:h15

" neovide options
let g:neovide_refresh_rate=60
let g:neovide_transparency=0.8
let g:neovide_cursor_vfx_mode = "ripple"
