#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`


# Install native apps

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# daily
brew cask install moom
brew cask install dropbox
# brew cask install gyazo
brew cask install 1password
brew cask install harvest
brew cask install hipchat
brew cask install flux
brew cask install alfred
brew cask install path-finder


# dev
brew cask install phpstorm
brew cask install iterm2
brew cask install atom
brew cask install sublime-text
brew cask install imagealpha
brew cask install imageoptim
brew cask install kaleidoscope
brew cask install tower

# fun
brew cask install limechat


# browsers
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install firefox
# brew cask install webkit-nightly
# brew cask install chromium
# brew cask install torbrowser

# less often
brew cask install nvalt
brew cask install marked
brew cask install disk-inventory-x
brew cask install screenflow
brew cask install vlc
brew cask install gpgtools
brew cask install licecap
brew cask install utorrent

