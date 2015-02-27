#!/bin/bash

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Set scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
