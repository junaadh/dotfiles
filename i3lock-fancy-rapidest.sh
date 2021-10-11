#!/bin/bash
image=$(mktemp --suffix=.png)
scrot -o "$image"
value="60" #brightness value to compare to
color=$(convert "$image" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

if [[ $color -gt $value ]]; then #white background image and black text
    param=("--inside-color=0000001c --ring-color=0000003e 
        --line-color=00000000 --keyhl-color=ffffff80 --ringver-color=ffffff00 
        --separator-color=22222260 --insidever-color=ffffff1c 
        --ringwrong-color=ffffff55 --insidewrong-color=ffffff1c 
        --verif-color=ffffff00 --wrong-color=ff000000 --time-color=ffffff00 
        --date-color=ffffff00 --layout-color=ffffff00 --greeter-color=000000ff")
else #black
    param=("--inside-color=ffffff1c --ring-color=ffffff3e 
        --line-color=ffffff00 --keyhl-color=00000080 --ringver-color=00000000 
        --separator-color=22222260 --insidever-color=0000001c 
        --ringwrong-color=00000055 --insidewrong-color=0000001c 
        --verif-color=00000000 --wrong-color=ff000000 --time-color=00000000 
        --date-color=00000000 --layout-color=00000000 --greeter-color=ffffffff")
fi
echo $param
i3lock-fancy-rapid 5 3 $param --greeter-font=Cantarell --indicator --greeter-text "Enter password to unlock"
