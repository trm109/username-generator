#!/usr/bin/env bash

# Converts the /output/combinations.txt file to wav files using the Piper TTS program

# Remember the root directory
root_dir=$(pwd)

# Change to the output directory (Piper has a bug where it ignores the output directory flag)
cd "$(dirname "$0")/output/wav/" || exit

# Convert lines of file to array
mapfile -t combinations < "$root_dir"/output/combinations.txt

# Get the number of lines
num_lines=${#combinations[@]}

# Function to process a single line into a wav file
process_line() {
  line="$1"
  name=$(sed -E 's/^[^,]+, *//; s/ +/_/g' <<< "$line")
  # make sure name isn't empty
  if [ -z "$name" ]; then
    echo "Name is empty, skipping..."
  else
    echo "$line" | piper \
      -m ../../model/tts.onnx \
      -c ../../model/tts.onnx.json \
      -f "$name.wav" 2> /dev/null
  fi
}

export -f process_line

# Process each line in parallel
printf "%s\n" "${combinations[@]}" | xargs -I{} -P "$(nproc)" bash -c 'process_line "{}"' | pv -l -s "$num_lines" > /dev/null
