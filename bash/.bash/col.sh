#!/usr/bin/env bash
# colorful prompt hostnames
# by apathor

# ord - ordinal value of given character
ord() { LC_CTYPE=C printf '%d' "'$1"; }

# chk - tiny checksums owo
chk() {
    local t=0
    while read -rN1 c; do (( t += $(ord "$c") )); done <<< "$@"
    printf "%s\n" "$(( t % 256 ))"
}

# chkcolor - print a string colorized with its checksum
chkcolor() {
    local inp="$1"
    local sum=$(chk "$inp")
    if [ "$sum" -eq 0 ]; then sum=1; fi
    color=$(tput setaf "$sum")
    reset="$(tput sgr0)"
    printf "%s%s%s\n" "$color" "$inp" "$reset"
}
