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

# Navigate to the specified directory
cd "$dir" || exit

# Clear the screen
clear

# Yellow color code
YELLOW='\033[1;33m'
# No color code
NC='\033[0m'

# Print the running message
echo -e "${YELLOW}[Running] python -u \"$dir/$fileName\"${NC}"
echo -e "${YELLOW}$(printf '%*s' 75 | tr ' ' -)${NC}"

# Run the Python script
python3 -u "$fileName"
