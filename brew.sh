#!/bin/bash

# Keep-alive: update existing `sudo` time stamp until we're  finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names

# Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash
brew install bash-completion
brew install homebrew/completions/brew-cask-completion

# zsh
brew install zsh
# zsh plugin manager
brew install antigen

# generic colouriser  http://kassiopeia.juls.savba.sk/~garabik/software/grc/
brew install grc

# Install wget with IRI support
brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install vim --with-override-system-vi
brew install homebrew/dupes/nano
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# z hopping around folders
brew install z

# run this script when this file changes guy.
brew install entr

# mtr - ping & traceroute. best.
brew install mtr

    # allow mtr to run without sudo
    mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/andi/.homebrew/Cellar/mtr/0.86`
    sudo chmod 4755 $mtrlocation/sbin/mtr
    sudo chown root $mtrlocation/sbin/mtr


# Install other useful binaries
brew install git
brew install the_silver_searcher
brew install android-platform-tools
brew install autoconf
brew install automake
brew install awscli
brew install ffmpeg
brew install freetype
brew install htop
brew install imagemagick
brew install mcrypt
brew install openssl
# brew install php71 php71-mcrypt php71-mongodb php71-opcache php71-xdebug php71-imagick
brew install php
#brew install php-code-sniffer drupal-code-sniffer
brew install phpunit
brew install pv
brew install python
brew install rename
brew install rsync
brew install terminal-notifier
brew install tree
brew install zopfli
brew install yarn
brew install youtube-dl
brew install watchman

# install local servers and development stuff
brew install node # This installs `npm` too using the recommended installation method
brew install mysql
brew install mongodb
brew install sqlite
brew install elasticsearch
brew install kibana
brew install nginx
brew install redis

# Remove outdated versions from the cellar
brew cleanup
