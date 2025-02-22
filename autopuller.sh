#!/bin/bash

# Check if root_folder.txt exists
if [ ! -f "root_folder.txt" ]; then
    echo "Error: root_folder.txt not found!"
    exit 1
fi

# Read the root folder path from root_folder.txt
root_folder=$(<root_folder.txt)

# Check if root folder exists
if [ ! -d "$root_folder" ]; then
    echo "Error: Root folder '$root_folder' does not exist!"
    exit 1
fi

# Create logs directory if it doesn't exist
mkdir -p "logs"
log_file="logs/autopuller_$(date +%Y%m%d_%H%M%S).log"

# Function to log messages
log_message() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $1" | tee -a "$log_file"
}

log_message "Starting repository updates..."
log_message "Root folder: $root_folder"

# Iterate over each directory within the root folder
for dir in "$root_folder"/*/; do
    if [ -d "$dir/.git" ]; then
        log_message "Processing repository: ${dir}"
        cd "$dir" || continue
        
        # Fetch and pull changes
        if git fetch origin; then
            pull_result=$(git pull 2>&1)
            if [ $? -eq 0 ]; then
                log_message "Successfully updated: ${dir}"
                log_message "Pull result: ${pull_result}"
            else
                log_message "Error pulling repository: ${dir}"
                log_message "Error message: ${pull_result}"
            fi
        else
            log_message "Error fetching repository: ${dir}"
        fi
        
        cd - > /dev/null
    else
        log_message "Skipping non-git directory: ${dir}"
    fi
done

log_message "Finished processing all repositories"