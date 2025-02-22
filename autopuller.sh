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

echo "Starting repository updates..."
echo "Root folder: $root_folder"

# Iterate over each directory within the root folder
for dir in "$root_folder"/*/; do
    if [ -d "$dir/.git" ]; then
        echo "Processing repository: ${dir}"
        cd "$dir" || continue
        
        # Fetch and pull changes
        if git fetch origin; then
            if git pull; then
                echo "Successfully updated: ${dir}"
            else
                echo "Error pulling repository: ${dir}"
            fi
        else
            echo "Error fetching repository: ${dir}"
        fi
        
        cd - > /dev/null
    else
        echo "Skipping non-git directory: ${dir}"
    fi
done

echo "Finished processing all repositories"