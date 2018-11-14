#!/bin/bash
#
# Set sensible defaults for macOS power users
#

function CFPreferencesAppSynchronize() {
    python - <<END
from Foundation import CFPreferencesAppSynchronize
CFPreferencesAppSynchronize('$1')
END
}


# set the scroll direction to be old school, down for down.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Never sleep when connected to the Power Adapter
sudo pmset -c sleep 0



# ==============================================
# Files and folders
# ==============================================

# Show the ~/Library directory
chflags nohidden "${HOME}/Library"

# Don't show the ~/bin directory
chflags nohidden "${HOME}/bin"


# ==============================================
# NSGlobalDomain settings
# ==============================================
echo "Setting NSGlobalDomain preferences"

# Disable smart quotes and dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Correct spelling automatically
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# ==============================================
# Desktop & Screen Saver
# ==============================================
echo "Setting Desktop & Screen Saver preferences"

# No translucent menu bar
defaults write NSGlobalDomain "AppleEnableMenuBarTransparency" -bool false

# Ask for password after 5 seconds
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Screen Saver: Flurry
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName -string "Flurry" path -string "/System/Library/Screen Savers/Flurry.saver" type -int 0

# ==============================================
# Trackpad
# ==============================================
echo "Setting Trackpad preferences"

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Tap with two fingers to emulate right click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# ==============================================
# Finder
# ==============================================
echo "Setting Finder preferences"

# Expand the "Open with" and "Sharing & Permissions" panes
defaults write com.apple.finder FXInfoPanesExpanded -dict OpenWith -bool true Privileges -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# New window points to home
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show all filename extensions
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Use column view
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

CFPreferencesAppSynchronize "com.apple.finder"

# ==============================================
# Dock
# ==============================================
echo "Setting Dock preferences"

# Position (left, bottom, right)
defaults write com.apple.dock orientation -string "left"


# ==============================================
# Safari & WebKit
# ==============================================
echo "Setting Safari & WebKit preferences"

# Appearance

# Show status bar
defaults write com.apple.Safari ShowStatusBar -bool true

# Show favorites bar
defaults write com.apple.Safari ShowFavoritesBar -bool true

# Show tab bar
defaults write com.apple.Safari AlwaysShowTabBar -bool true


# General settings

# Safari opens with: A new window
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool false

# New windows open with: Empty Page
defaults write com.apple.Safari NewWindowBehavior -int 1

# New tabs open with: Empty Page
defaults write com.apple.Safari NewTabBehavior -int 1

# Homepage
defaults write com.apple.Safari HomePage -string "about:blank"

# Don't open "safe" files after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false


# Tabs settings

# Open pages in tabs instead of windows: automatically
defaults write com.apple.Safari TabCreationPolicy -int 1

# Don't make new tabs active
defaults write com.apple.Safari OpenNewTabsInFront -bool false

# Command-clicking a link creates tabs
defaults write com.apple.Safari CommandClickMakesTabs -bool true


# Autofill settings

# Don't remember passwords
defaults write com.apple.Safari AutoFillPasswords -bool false


# Security settings

# Warn About Fraudulent Websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Privacy settings

# Do not track
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true


# Extensions settings

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

CFPreferencesAppSynchronize "com.apple.Safari"



# ==============================================
# Kill affected applications
# ==============================================

function killallApps() {
    killall "Finder" > /dev/null 2>&1
    killall "SystemUIServer" > /dev/null 2>&1
    killall "Dock" > /dev/null 2>&1

    appsToKill=(
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
