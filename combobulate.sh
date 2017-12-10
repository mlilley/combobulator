#!/bin/bash

# REFs: 
#   https://gist.github.com/tobyspark/fa57e1c663bc5d799d2a
#   https://gist.github.com/meleyal/5890865
#   https://github.com/paulirish/dotfiles/blob/master/.osx
#   https://github.com/mathiasbynens/dotfiles/

hostname="bender"
temp="/tmp"

# close System Preferences if open, to prevent fighting over configuration
osascript -e 'tell application "System Preferences" to quit'

# get admin
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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

# Desktop & Screen Saver
defaults write com.apple.screensaver idleTime -int 0
defaults -currentHost write com.apple.screensaver idleTime -int 0

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock orientation -string 'left'
# killall Dock

# Displays
# TODO: show mirroring -> false

# Energy Saver
# see "$ man pmset" for more info
sudo pmset displaysleep 30
sudo pmset disksleep 10
sudo pmset womp 1
sudo pmset autorestart 0
sudo pmset powernap 0

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
# defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Finder
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file:///Users/mike/"
# TODO: sidebar settings (order of favorites)
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# TODO: remove from trash after 30 days -> false
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder EmptyTrashSecurely -bool true

#CFPreferencesAppSynchronize "com.apple.finder"

# Disk Utility
defaults write com.apple.DiskUtility SidebarShowAllDevices -bool true
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

#CFPreferencesAppSynchronize "com.apple.DiskUtility"

# Misc

#curl -L -O "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
#hdiutil mount -nobrowse googlechrome.dmg
#cp -R "/Volumes/Google Chrome/Google Chrome.app" /Applications
#hdiutil unmount "/Volumes/Google Chrome"
#rm googlechrome.dmg

# Iterm

defaults write com.googlecode.iterm2 PromptOnQuit -bool false



function installApp() {
  url=$1
  dmg=$2
  vol=$3

  tmp="`mktemp`"

  curl -s -L "${url}" -o "${tmp}"
  hdiutil mount -nobrowse "${tmp}"
  cp -R "${vol}" /Applications
  hdiutilunmount "${vol}"
  rm "${dmg}"
}

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
