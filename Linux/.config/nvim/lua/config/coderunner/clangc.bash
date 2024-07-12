#!/bin/bash

# Parse the input arguments
while getopts "d:f:r:" opt; do
    case "$opt" in
        d) dir=$OPTARG ;;
        f) fileName=$OPTARG ;;
        r) runwith=$OPTARG ;;
    esac
done

# Remove the parsed options from the arguments list
shift $((OPTIND-1))

# Store any additional arguments to pass to the compiled program
program_args=("$@")

# Change to the specified directory
cd "$dir" || exit

# Join the directory and file name to create the new directory path
newDir="$dir/$fileName"

if [[ "$dir" == *src* ]]; then
    cd ..
fi

# Clear the screen
clear

# Color Codes
YELLOW='\033[1;33m'
NC='\033[0m'

# Determine the file name without extension
fileNameWithoutExt="${fileName%.*}"


case $runwith in
    r)
        echo -e "${YELLOW}[Running] \"${dir/src/build}/$fileNameWithoutExt\"\n$(printf '%*s' 75 | tr ' ' -)${NC}"
        "./build/$fileNameWithoutExt" "${program_args[@]}"
        ;;
    b)
        mkdir -p build
        echo -e "${YELLOW}[Rebuilding]\n$(printf '%*s' 75 | tr ' ' -)${NC}"
        if [ -f "./build/$fileNameWithoutExt" ]; then
            rm "./build/$fileNameWithoutExt"
        fi
        gcc "$newDir" -o "./build/$fileNameWithoutExt"
        echo "Compiled to: \"${dir/src/build}/$fileNameWithoutExt\""
        ;;
    c)
        mkdir -p build
        echo -e "${YELLOW}[Compiling]\n$(printf '%*s' 75 | tr ' ' -)${NC}"
        gcc "$newDir" -o "./build/$fileNameWithoutExt"
        echo "Compiled to: \"${dir/src/build}/$fileNameWithoutExt\""
        ;;
    *)
        mkdir -p build
        echo -e "${YELLOW}[Compiling and Running] \"${dir/src/build}/$fileNameWithoutExt\"\n$(printf '%*s' 75 | tr ' ' -)${NC}"
        if [ -f "./build/$fileNameWithoutExt" ]; then
            rm "./build/$fileNameWithoutExt"
        fi
        gcc "$newDir" -o "./build/$fileNameWithoutExt"
        "./build/$fileNameWithoutExt" "${program_args[@]}"
        ;;
esac
