#!/usr/bin/env sh
case "$1" in
	*.png|*.jpg|*.jpeg|*.mkv|*.mp4) mediainfo "$1";;
	*.md) glow -s dark "$1";;
	# *.pdf) pdftotext "$1" -;;
	*.pdf) ls "$1" -;;
	*.zip) zipinfo "$1";;
	*.tar.gz) tar -ztvf "$1";;
	*.tar.bz2) tar -jtvf "$1";;
	*.tar) tar -tvf "$1";;
	*.rar) unrar l "$1";;
	*.7z) 7z l "$1";;
	# *.html|*.xml) w3m -dump "$1";;
	*) highlight -O xterm256 -s dante -t 4 "$1" || cat "$1";;
esac
