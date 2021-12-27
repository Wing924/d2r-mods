#!/bin/bash

set -eu

file=$1
tmp_file=$1.new

cleanup() {
    rm -f "$tmp_file"
}

trap cleanup EXIT

printf "$file "

if ! jq . "$file" > "$tmp_file" 2>/dev/null; then
    printf '\e[1;31m(error)\e[0m\n'
    jq . "$file" >/dev/null
    exit
fi

if diff -q "$file" "$tmp_file" >/dev/null; then
    printf '\e[1;30m(up-to-date)\e[0m\n'
else
    printf '\e[0;32m(done)\e[0m\n'
    mv "$tmp_file" "$file"
fi
