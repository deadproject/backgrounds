#!/bin/bash

# Directory to store downloaded backgrounds
BACKGROUND_DIR="$HOME/.backgrounds"

# GitHub repository URL
REPO_URL="https://github.com/deadproject/backgrounds.git"
git clone "$REPO_URL"
chmod +x BgScript.sh
./BgScript.sh

# Create the background directory if it doesn't exist
mkdir -p "$BACKGROUND_DIR"

# Function to download the latest backgrounds
download_backgrounds() {
    git clone "$REPO_URL" "$BACKGROUND_DIR" || (cd "$BACKGROUND_DIR" && git pull)
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
