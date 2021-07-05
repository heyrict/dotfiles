_scr=$(xrandr -q | rg current | sed 's/^.*current \([0-9]\+\) x \([0-9]\+\).*$/\1 \2/')
_scr_w=$(echo $_scr | awk '{print $1}')
_scr_h=$(echo $_scr | awk '{print $2}')
_sw=${_scr_w:-1366}
_sh=${_scr_h:-768}

_wh=$(i3-msg -t get_tree |\
    sed 's/^.\+"id":\([0-9]\+\),[^}]\+"focused":true,[^}]\+"width":\([0-9]\+\),"height":\([0-9]\+\).\+$/\1 \2 \3/');
_w=$(echo $_wh | cut -d" " -f 2);
_h=$(echo $_wh | cut -d" " -f 3);

case "$1" in
    *y)
        i3-msg move position 0 0;;
    *u)
        _xp=$(echo "$_sw - $_w" | bc);
        i3-msg move position $_xp 0;;
    *b)
        _yp=$(echo "$_sh - $_h" | bc);
        i3-msg move position 0 $_yp;;
    *n)
        _xp=$(echo "$_sw - $_w" | bc);
        _yp=$(echo "$_sh - $_h" | bc);
        i3-msg move position $_xp $_yp;;
esac
