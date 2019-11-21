#!/bin/bash

# ==============================================
# Mouse
# ==============================================
echo "Setting Mouse preferences"

# Set scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Secondary click:
# Possible values: OneButton, TwoButton, TwoButtonSwapped
#defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton

# Smart zoom enabled, double-tap with one finger (set to 0 to disable)
#defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture -int 1

# Double-tap with two fingers to Mission Control (set to 0 to disable)
#defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerDoubleTapGesture -int 3

# Two finger horizontal swipe
# 0 = Swipe between pages with one finger
# 1 = Swipe between pages
# 2 = Swipe between full screen apps with two fingers, swipe between pages with one finger (Default Mode)
defaults read com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerHorizSwipeGesture 
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerHorizSwipeGesture -int 2

defaults read com.apple.driver.AppleBluetoothMultitouch.mouse MouseVerticalScroll 
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseVerticalScroll -int 1

defaults read com.apple.driver.AppleBluetoothMultitouch.mouse MouseMomentumScroll 
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseMomentumScroll -int 1

defaults read com.apple.driver.AppleBluetoothMultitouch.mouse MouseHorizontalScroll 
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseHorizontalScroll -int 1


# ==============================================
# Trackpad
# ==============================================
echo "Setting Trackpad preferences"

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Tap with two fingers to emulate right click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Rotate
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true

# Notification Center
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
