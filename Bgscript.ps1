# Directory to store downloaded backgrounds
$BACKGROUND_DIR = "$env:USERPROFILE\.backgrounds"

# GitHub repository URL
$REPO_URL = "https://github.com/deadproject/backgrounds.git"

# Clone the GitHub repository
git clone $REPO_URL

# Create the background directory if it doesn't exist
if (-Not (Test-Path -Path $BACKGROUND_DIR)) {
    New-Item -ItemType Directory -Path $BACKGROUND_DIR
}

# Function to download the latest backgrounds
function Download-Backgrounds {
    robocopy "$REPO_URL" "$BACKGROUND_DIR" /E /XO
}

# Function to change the background
function Change-Background {
    while ($true) {
        $images = Get-ChildItem -Path $BACKGROUND_DIR -File
        foreach ($img in $images) {
            $imgPath = $img.FullName
            Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
            [Wallpaper]::SystemParametersInfo(0x0014, 0, $imgPath, 0x0001)
            Start-Sleep -Seconds 1800  # 30 minutes
        }
    }
}

# Download the latest backgrounds
Download-Backgrounds

# Change the background every 30 minutes
Change-Background
