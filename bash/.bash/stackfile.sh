#!/usr/bin/env bash

# pushf STACKFILE LINE
# Treat STACKFILE as a stack, pushing LINE onto the start of the file.
pushf() {
    local file="$1"; shift;
    [ -n "$file" ] || return 127
    declare -a stack;
    [ -f "$file" ] && mapfile -t stack < "$file"
    printf "%s\n" "$@" "${stack[@]}" > "$file"
}

# popf STACKFILE
# Treat STACKFILE as a stack, popping and printing the first line.
popf() {
    local file="$1";
    [ -f "$file" ] || return 127
    mapfile -t stack < "$file"
    printf "%s\n" "${stack[@]:1}" > "$file"
    printf "%s\n" "${stack[0]}"
}
