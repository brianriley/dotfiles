#!/bin/sh

set -e

echo "Automatically hide the dock"
defaults write com.apple.dock autohide -bool true

echo "Clear dock of all apps"
defaults write com.apple.dock checked-for-launchpad -bool true
defaults write com.apple.dock persistent-apps -string "()"

echo "Hide indicator lights under running applications"
defaults write com.apple.dock show-process-indicators -bool false

echo "Set the dock icon size"
defaults write com.apple.dock tilesize -int 36

echo "Empty trash securely"
defaults write com.apple.finder EmptyTrashSecurely -bool true

echo "Show hidden files"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "Finder: Always open everything in column view"
defaults write com.apple.Finder FXPreferredViewStyle clmv

echo "Disable autocorrect"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo "Expand save panel by default" defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true echo "Tap to click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "Set a fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0.02

echo "Set a shorter Delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 12

echo "Remap capslock to control"
ioreg -n IOHIDKeyboard -r | grep -E 'VendorID"|ProductID' | awk '{ print $4 }' | paste -s -d'-\n' - | xargs -I{} defaults -currentHost write -g "com.apple.keyboard.modifiermapping.{}-0" -array "<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>"

echo "Do not create .DS_Store on network shares"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Disable top hit background preloading in Safari"
defaults write com.apple.Safari PreloadTopHit -bool false

echo "Disable quick website search in Safari"
defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false

echo "Disable search engine suggestions in Safari"
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "Set do not track HTTP header"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "Enable developer mode in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true

echo "Change default search engine to DuckDuckGo"
defaults write com.apple.Safari SearchProviderIdentifier -string "com.duckduckgo"

echo "Kill affected applications"
for app in Safari Finder Dock SystemUIServer; do killall "$app" >/dev/null 2>&1; done
