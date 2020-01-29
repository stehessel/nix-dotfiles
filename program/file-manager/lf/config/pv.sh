#!/bin/env sh

case "$1" in
	*.md) glow "$1";;
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *) highlight -O ansi -s dante "$1" || cat "$1";;
esac
