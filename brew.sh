#!/bin/bash

# Install command-line tools using Homebrew
brew tap homebrew/homebrew-php

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

# generic colouriser  http://kassiopeia.juls.savba.sk/~garabik/software/grc/
brew install grc

# Install wget with IRI support
brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# run this script when this file changes guy.
brew install entr

# github util. imho better than hub
brew install gh

# mtr - ping & traceroute. best.
brew install mtr

    # allow mtr to run without sudo
    mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/andi/.homebrew/Cellar/mtr/0.86`
    sudo chmod 4755 $mtrlocation/sbin/mtr
    sudo chown root $mtrlocation/sbin/mtr


# Install other useful binaries
brew install git
brew install ack
brew install android-platform-tools
brew install autoconf
brew install automake
brew install awscli
brew install behat
brew install boost
brew install composer
brew install ffmpeg --with-libvpx
brew install flow
brew install freetype
brew install htop
brew install imagemagick --with-webp
brew install mcrypt
brew install openssl
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

# install local servers and development stuff
brew install node # This installs `npm` too using the recommended installation method
brew install mysql
brew install mongodb
brew install sqlite
brew install elasticsearch
brew install kibana
brew install php71 php71-mcrypt php71-mongodb php71-opcache php71-xdebug php71-imagick
brew install nginx
brew install selenium-server-standalone
brew install redis

# Remove outdated versions from the cellar
brew cleanup
