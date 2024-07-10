#!/bin/bash

# Parse the input arguments
while getopts "d:f:" opt; do
    case "$opt" in
        d) dir=$OPTARG ;;
        f) fileName=$OPTARG ;;
        *) echo "Usage: $0 -d <directory> -f <file name>"
           exit 1 ;;
    esac
done

# Check if both arguments were provided
if [ -z "$dir" ] || [ -z "$fileName" ]; then
    echo "Usage: $0 -d <directory> -f <file name>"
    exit 1
fi

# Change to the specified directory
cd "$dir" || exit

# Join the directory and file name to create the new directory path
newDir="$dir/$fileName"

if [[ "$dir" == *src* ]]; then
    cd ..
fi

# Check if the "build" directory exists, if not, create it
if [ ! -d "build" ]; then
    mkdir build
fi

# Clear the screen
clear

# Color Codes
YELLOW='\033[1;33m'
NC='\033[0m'

# Determine the file name without extension
fileNameWithoutExt="${fileName%.*}"

# Print the running message based on the directory structure
if [[ "$dir" == *src* ]]; then
    echo -e "${YELLOW}[Running] gcc \"$dir/$fileName\" -o \"${dir/src/build}/$fileNameWithoutExt\"\n$(printf '%*s' 75 | tr ' ' -)${NC}"
else
    echo -e "${YELLOW}[Running] gcc \"$dir/$fileName\" -o \"$dir/build/$fileNameWithoutExt\"\n$(printf '%*s' 75 | tr ' ' -)${NC}"
fi

if [ -f "./build/$fileNameWithoutExt" ]; then
    rm "./build/$fileNameWithoutExt"
fi

gcc "$newDir" -o "./build/$fileNameWithoutExt"
if [ $? -ne 0 ]; then
    exit 1
else
    "./build/$fileNameWithoutExt"
fi


