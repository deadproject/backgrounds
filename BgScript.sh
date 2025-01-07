#!/bin/bash

# Directory to store downloaded backgrounds
BACKGROUND_DIR="$HOME/.backgrounds"

# GitHub repository URL
REPO_URL="https://github.com/deadproject/backgrounds"

# Create the background directory if it doesn't exist
mkdir -p "$BACKGROUND_DIR"

# Function to download the latest backgrounds
download_backgrounds() {
    rsync -av --ignore-existing "$REPO_URL/" "$BACKGROUND_DIR/"
}

# Function to change the background
change_background() {
    while true; do
        for img in "$BACKGROUND_DIR"/*; do
            gsettings set org.gnome.desktop.background picture-uri "file://$img"
            sleep 5
        done
    done
}

# Download the latest backgrounds
download_backgrounds

# Change the background every 5 seconds
change_background
