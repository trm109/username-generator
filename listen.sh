#!/usr/bin/env bash

# max args of 3
# $ ./listen.sh <number of files to listen to> (r)
# $ ./listen.sh 0 r # Listen to all files in random order
delay=.5
# get the number of files to listen to
if [ -z "$1" ]; then
  echo "Usage: ./listen.sh [number of files to listen to] (r)"
  exit 1
fi
# if 0, listen to all files
if [ "$1" -eq 0 ]; then
  num_files=$(find ./output/wav/ -type f | wc -l)
else
  num_files=$1
fi
# Get the random flag
if [ -z "$2" ]; then
  random=0
else
  random=1
fi

# Get the list of wav files in ../output/wav/
files=$(ls ./output/wav/)

# Shuffle the files
if [ $random -eq 1 ]; then
  files=$(echo "$files" | shuf)
fi

# Listen to the files
# for i < num_files
for i in $(seq 0 $((num_files-1))); do
  file=$(echo "$files" | head -n $((i+1)) | tail -n 1)
  aplay "./output/wav/$file" >/dev/null 2>&1 &
  # [2/5] Listening to file_name.wav
  echo "[$((i+1))/$num_files] Listening to $file"
  # delay + soxi -D ./output/wav/$file using bc
  sleep "$(echo "$delay + $(soxi -D ./output/wav/"$file")" | bc)"
done


