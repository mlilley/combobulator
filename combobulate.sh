$hostname="bender"

# Machine Name
#sudo scutil --set HostName $hostname
#sudo scutil --set LocalHostName $hostname
#sudo scutil --set ComputerName $hostname
#sudo dscacheutil -flushcache

# General
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
# TODO: sidebar icon size -> Small
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
# TODO: (heaps)
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Misc
