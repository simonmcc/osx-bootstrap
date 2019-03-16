#!/bin/bash

sudo -v # ask for the administrator password

DIR_SCREENSHOTS=$HOME/Screenshots

echo "Adjusting Dock."
defaults write com.apple.Dock autohide-delay -float 0
killall Dock

echo "Adjusting Finder."
defaults write com.apple.finder AppleShowAllFiles -bool true # always display hidden files and directories
defaults write com.apple.finder ShowStatusBar -bool true # show Finder status bar
defaults write com.apple.finder ShowPathbar -bool true # show Finder path bar
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # no warning prompt when changing file extension
/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user # remove duplicates from right click "Open With…" menu
killall Finder

echo "Adjusting Keyboard."
#defaults write NSGlobalDomain KeyRepeat -int 0 # key repeat speed looks botched on OS X El Capitan and newer
defaults write com.apple.BezelServices kDimTime -int 60 # turn off keyboard illumination after X second(s) of idle state

echo "Adjusting Mission Control."
defaults write com.apple.dock expose-animation-duration -float 0.1 # reduce animation duration

echo "Adjusting screenshot settings."
mkdir -p $DIR_SCREENSHOTS
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture location "$DIR_SCREENSHOTS"
defaults write com.apple.screencapture disable-shadow -bool true # no shadow on image borders
killall SystemUIServer

echo "Adjusting System Update."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # always show extensions for all files
chflags nohidden $HOME/Library/
sudo chflags nohidden /Volumes
defaults write NSGlobalDomain AppleShowScrollBars -string "Always" # always show scrollbars
                                                                   # other possible options are:
                                                                   # - WhenScrolling
                                                                   # - Automatic
                                                                   # - Always

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true # expand "Save & Print" panels by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores true # don't create .DS_Store files on external volumes

echo "Adjusting System itself."
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1 # check for updates daily
sudo nvram SystemAudioVolume=%80 # disable startup sound (works in macOS Sierra 10.12.1)
                                 # other possible options are:
                                 # - sudo nvram SystemAudioVolume=%01
                                 # - sudo nvram SystemAudioVolume=%00
                                 # - sudo nvram SystemAudioVolume=" "

echo "Adjusting Trackpad."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # enable "Tap To Click" feature
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "Adjusting Windows Behavior in OS X / macOS."
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false # disable window opening and closing animation

echo "All done!"
