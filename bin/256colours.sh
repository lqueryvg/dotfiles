#!/bin/bash
#
# Neatly display all 256 colours with their decimal
# codes in a color term.

testColFunc(){
    printf -v str "%3d" "$1"
    echo -ne "$str\e[48;5;${1}m   \e[0m"
}

for line in {0..35}
do
    if [[ line -le 15 ]]    # left column 16 ansi colors
    then testColFunc "$line"
    else echo -n "      "
    fi
    
    for col in {0..5}   # red
    do
        code=$((col * 36 + line + 16))
        testColFunc "$code"
    done
    if [[ line -le 23 ]]    # right column greys
    then testColFunc $((232 + line))
    fi
    echo
done
