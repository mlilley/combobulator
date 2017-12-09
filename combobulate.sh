#!/bin/bash

hostname="bender"

# Machine Name
sudo scutil --set HostName $hostname
sudo scutil --set LocalHostName $hostname
sudo scutil --set ComputerName $hostname
sudo dscacheutil -flushcache

# General
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
# TODO: recent items -> none
# TODO: default web browser -> chrome

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
# killall Dock

# Displays
# TODO: show mirroring -> false

# Energy Saver
# TODO: turn display off after -> 10 mins
# TODO: prevent computer from sleeping -> true
# TODO: wake from ethernet -> false
# TODO: enable power nap -> false

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Mouse
# TODO: Scroll direction -> Natural
# TODO: Tracking speed -> (bit up)

# Trackpad
# TODO: silent click, tracking speed
defaults write NSGLobalDomain com.apple.swipescrolldirection -bool false

# Sound
# TODO: show volume in menu bar -> true

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder ShowStatusBar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# TODO: validate: defaults write com.apple.finder FXPreferredViewStyle -string "lst"

CFPreferencesAppSynchronize "com.apple.finder"

# Disk Utility
defaults write com.apple.DiskUtility SidebarShowAllDevices -bool true
# defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
# defaults write com.apple.DiskUtility advanced-image-options -bool true

CFPreferencesAppSynchronize "com.apple.DiskUtility"

# Misc

# Restart Apps
# adapted from 

function killApps() {
  killall "Finder" > /dev/null 2>&1
  killall "SystemUIServer" > /dev/null 2>&1
  killall "Dock" > /dev/null 2>&1
  
  apps=(
    "Activity Monitor"
    "Disk Utility"
    "System Preferences"
  )

  for app in "${apps[@]}"
  do
    killall "${app}" > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
      open -a "${app}"
    fi
  done
}

printf "Restart apps? (y/n):"
read choiceKillapps
if [[ $choiceKillapps =~ ^[Yy]$ ]]; then
  killApps
fi

exit 0
