#!/bin/bash

# Keep-alive: update existing `sudo` time stamp until we're  finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# to maintain cask ....
#     `brew cask upgrade && brew cask cleanup`

brew tap homebrew/cask-versions

brew cask install 1password
brew cask install adobe-creative-cloud
brew cask install alfred
brew cask install alinof-timer
brew cask install arq
brew cask install atext
brew cask install bartender
brew cask install betterzip
brew cask install boxcryptor
brew cask install daisydisk
brew cask install dash
brew cask install disk-inventory-x
brew cask install docker
brew cask install dropbox
brew cask install duet
brew cask install evernote
brew cask install fantastical
brew cask install firefox
brew cask install firefox-nightly
brew cask install flux
brew cask install forklift
brew cask install gitbook-editor
brew cask install godot
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-backup-and-sync
brew cask install grammarly
brew cask install graphql-ide
brew cask install handbrake
brew cask install imagealpha
brew cask install imageoptim
brew cask install insomnia
brew cask install iterm2
brew cask install java
brew cask install jetbrains-toolbox
brew cask install jsui
brew cask install kaleidoscope
brew cask install kap
brew cask install kindle
brew cask install kitematic
brew cask install koa11y
brew cask install lando
brew cask install lepton
brew cask install libreoffice
brew cask install libreoffice-language-pack
brew cask install licecap
brew cask install little-snitch
brew cask install marshallofsound-google-play-music-player
brew cask install menubar-stats
brew cask install micro-snitch
brew cask install mongodb-compass-community
brew cask install moom
brew cask install now
brew cask install nvalt
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install qlmarkdown
brew cask install qlstephen
brew cask install quicklook-json
brew cask install real-vnc
brew cask install screenflow
brew cask install sequel-pro
brew cask install skitch
brew cask install slack
brew cask install station
brew cask install sublime-text
brew cask install tower
brew cask install vagrant
brew cask install vagrant-manager
brew cask install virtualbox
brew cask install visual-studio-code-insiders
brew cask install vlc
brew cask install webpquicklook
brew cask install wordpresscom
# brew cask install zeplin
brew cask install zoomus

#brew tap caskroom/fonts
brew cask install font-fira-code
