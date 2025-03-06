#!/bin/bash

# Get the current working directory (CWD)
CWD=$(pwd)

# List of source files (relative to the current directory)
SOURCE_FILES=(
    "$CWD/exfil"
    "$CWD/mimis"
    "$CWD/persist"
    "$CWD/pivot"
    "$CWD/privesc"
    "$CWD/revshells"
    "$CWD/machine/machine"
    "$CWD/scripts/listen"
    "$CWD/scripts/serve"
    "$CWD/scripts/tunip"
    "$CWD/termlog/termlog"
    "$CWD/pshell.py"

    # Add more files as needed
)

# Destination directory
DEST_DIR="$HOME/.local/bin"

# Create the destination directory if it does not exist
mkdir -p "$DEST_DIR"

# Iterate over each source file
for SOURCE_FILE in "${SOURCE_FILES[@]}"; do
    # Check if the source file exists
    if [ ! -f "$SOURCE_FILE" ]; then
        echo "Source file $SOURCE_FILE does not exist. Skipping."
        continue
    fi

    # Define the full destination path
    DEST_PATH="$DEST_DIR/$(basename "$SOURCE_FILE")"

    # Check if a symlink or file already exists at the destination
    if [ -e "$DEST_PATH" ]; then
        echo "Destination $DEST_PATH already exists. Removing it."
        rm -f "$DEST_PATH"
    fi

    # Create the symlink
    ln -s "$SOURCE_FILE" "$DEST_PATH"
    echo "Symlink created for $SOURCE_FILE at $DEST_PATH."
done
