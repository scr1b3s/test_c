#!/bin/bash

# Ensure both source and target directories are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <target_directory>"
    exit 1
fi

SOURCE_DIR=$1
TARGET_DIR=$2

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Check if the target directory exists, if not create it
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory does not exist. Creating: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Find all .c files in the source directory and copy them to the target directory
echo "Copying .c files from $SOURCE_DIR to $TARGET_DIR..."
find "$SOURCE_DIR" -name "*.c" -exec cp -f {} "$TARGET_DIR" \;

# Check the result
if [ $? -eq 0 ]; then
    echo "All .c files copied successfully."
else
    echo "Error copying .c files."
fi
