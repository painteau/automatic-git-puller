#!/bin/bash
# Read the root folder path from root_folder.txt
root_folder=$(<root_folder.txt)

# Iterate over each directory within the root folder
for dir in "$root_folder"/*/; do
  echo "Traitement du dossier ${dir}..."
  cd "$dir" || continue
  git pull
  cd - > /dev/null
done

# Pause to wait for the user to press a key before closing
read -p "Press any key to continue..."
