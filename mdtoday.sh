#!/bin/bash

editor="vim"
editorcmd=""
echo "$1"
case "$1" in
    (--editor=*) {
        editor=$(echo "$1" | awk -F '=' '{ print $2 }')
    } ;& # fallthrough
    ("") editorcmd='$editor "$file"' ;;
    (--help) {
        echo "$0"
        echo ""
        echo "Creates a markdown file in the current directory based on today's date."
        echo "Used for creating quick notes in the current directory which can be sorted by date."
        echo ""
        echo "ARGUMENTS:"
        echo "    --no-editor    Just create the file, don't open the editor"
        echo ""
        echo "    --editor=myeditor"
        echo "                   Use a specific editor to open the file"
        echo ""
        echo "    --help         Display this message"
        exit 0
    } ;;
    (--no-editor) echo "This creates a file in the current directory based on today's date" ;;
    (*) {
        echo "Unknown command '$1'"
        exit 1
    } ;;
esac

today="$(date +%Y%m%d)"
file="$today.md"
curdir="$(echo "$PWD" | awk -F '/' '{print $NF}')"

echo "Today: $today"
echo "File: $file"
echo "Dir: $curdir"
echo "Editor: $editor"

if [ ! -f "$file" ]
then
    touch "$file"
    {
        echo "# $curdir -- $today"
        echo ""
        echo ""
    } >> "$file"
fi

eval "$editorcmd"
