#!/usr/bin/env bash

file=$1

[[ -z "$file" ]] && {
  echo "usage: $0 {filename.mp4}"
  exit 1
}

[[ $file == *.mp4 ]] || {
  echo "ERROR: must be an '.mp4' file"
  exit 1
}

ffmpeg -i $file -f mp3 -ab 192000 -vn ${file/.mp4/.mp3}
