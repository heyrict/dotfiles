_i3run=$(pgrep i3 2>/dev/null) # Use i3 and Xorg
# Get w&h for focused window
if [ $_i3run ]; then
    msgcmd="i3-msg"
    _wh=$(i3-msg -t get_tree |\
        sed 's/^.\+"id":\([0-9]\+\),[^}]\+"focused":true,[^}]\+"width":\([0-9]\+\),"height":\([0-9]\+\).\+$/\1 \2 \3/');
    _w=$(echo $_wh | cut -d" " -f 2);
    _h=$(echo $_wh | cut -d" " -f 3);
else
    msgcmd="swaymsg"
    _wh=$(swaymsg -t get_tree | jq '.nodes[] | select(.active == true) | .nodes[] | .floating_nodes[] | select(.focused == true) | .rect')
    _w=$(echo $_wh | jq .width)
    _h=$(echo $_wh | jq .height)
fi

# Get screen w&h
if [ $_i3run ]; then
    _scr=$(xrandr -q | rg current | sed 's/^.*current \([0-9]\+\) x \([0-9]\+\).*$/\1 \2/')
    _scr_w=$(echo $_scr | awk '{print $1}')
    _scr_h=$(echo $_scr | awk '{print $2}')
else
    _scr=$(swaymsg -t get_tree | jq '.nodes[] | select(.active == true) | .nodes[0].rect')
    _scr_w=$(echo $_scr | jq .width)
    _scr_h=$(echo $_scr | jq .height)
fi

_sw=${_scr_w:-1366}
_sh=${_scr_h:-768}

echo $_scr $_scr_w $_scr_h .. $_wh $_w $_h > /tmp/temp.log

case "$1" in
    *y)
        $msgcmd move position 0 0;;
    *u)
        _xp=$(echo "$_sw - $_w" | bc);
        $msgcmd move position $_xp 0;;
    *b)
        _yp=$(echo "$_sh - $_h" | bc);
        $msgcmd move position 0 $_yp;;
    *n)
        _xp=$(echo "$_sw - $_w" | bc);
        _yp=$(echo "$_sh - $_h" | bc);
        $msgcmd move position $_xp $_yp;;
esac
