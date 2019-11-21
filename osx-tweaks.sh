#!/bin/bash

# set the scroll direction to be old school, down for down.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Never sleep when connected to the Power Adapter
sudo pmset -c sleep 0
