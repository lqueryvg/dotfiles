filename=$1
[[ -z $filename ]] && {
  echo "No filename given."
  exit 1
}

artist=$(exiftool -s -s -s -Artist "$filename")

if [[ $artist != Various ]]
then
  title=$(exiftool -s -s -s -Title "$filename")
  set -x
  #exiftool -title="$artist - $title" "$filename"
  #exiftool -artist="Various" "$filename"
  id3v2 -t "$artist - $title" "$filename"
  id3v2 -a "Various" "$filename"
fi
