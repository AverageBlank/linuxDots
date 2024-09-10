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
unset 'program_args[${#program_args[@]}-1]' 2>/dev/null

# Navigate to the specified directory
cd "$dir" || exit

# Making File executable if not already.
if [[ ! -x "$fileName" ]]; then
  chmod +x "$fileName"
fi

# Clear the screen
clear

# Yellow color code
YELLOW='\033[1;33m'
# No color code
NC='\033[0m'

# Print the running message
echo -e "${YELLOW}[Running] bash \"$dir/$fileName\"${NC}"
echo -e "${YELLOW}$(printf '%*s' 75 | tr ' ' -)${NC}"

# Run the shell scripting file
bash "$fileName" "${program_args[@]}"
