#!/bin/bash

# set the scroll direction to be old school, down for down.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Never sleep when connected to the Power Adapter
sudo pmset -c sleep 0



#
# Set sensible defaults for macOS power users
#

function CFPreferencesAppSynchronize() {
    python - <<END
from Foundation import CFPreferencesAppSynchronize
CFPreferencesAppSynchronize('$1')
END
}


# ==============================================
# Files and folders
# ==============================================

# Show the ~/Library directory
chflags nohidden "${HOME}/Library"

# Show the ~/bin directory
[[ ! -d "${HOME}/bin" ]] && mkdir -p "${HOME}/bin"
chflags nohidden "${HOME}/bin"


#
# NSGlobalDomain settings
#
echo "Setting NSGlobalDomain preferences"

# Disable smart quotes and dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Correct spelling automatically
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# No translucent menu bar
defaults write NSGlobalDomain "AppleEnableMenuBarTransparency" -bool false

# Ask for password after 5 seconds
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5


# Trackpad
echo "Setting Trackpad preferences"

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Tap with two fingers to emulate right click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true



# Dock
echo "Setting Dock preferences"

# Position (left, bottom, right)
defaults write com.apple.dock orientation -string "left"


# ==============================================
# Kill affected applications
# ==============================================

function killallApps() {
    killall "Finder" > /dev/null 2>&1
    killall "SystemUIServer" > /dev/null 2>&1
    killall "Dock" > /dev/null 2>&1

    appsToKill=(
    "Activity Monitor"
    "System Preferences"
    "Safari"
    )

    for app in "${appsToKill[@]}"
    do
        killall "${app}" > /dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            # We just killed an app so restart it
            open -a "${app}"
        fi
    done

    echo "Note that some of these changes require a logout/restart to take effect."
}

printf "Restart the affected applications? (y/n): "
read killallReply
if [[ $killallReply =~ ^[Yy]$ ]]; then
    killallApps
fi

exit 0
