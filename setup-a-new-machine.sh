# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1

##############################################################################################################
### XCode Command Line Tools
#      thx https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi
###
##############################################################################################################



##############################################################################################################
### homebrew!

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# install all the things
./brew.sh
./brew-cask.sh

### end of homebrew
##############################################################################################################


##############################################################################################################
### install of common things
###

# oh my zsh
# https://github.com/robbyrussell/oh-my-zsh
# oh-my-zsh is installed by antigen in .zshrc!
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# ruby with rvm
sh -c "$(curl -sSL https://get.rvm.io | bash -s stable --ruby)"

# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
# bash < <( curl https://raw.githubusercontent.com/jamiew/git-friendly/master/install.sh)

# global npm packages
./npm.sh

# install better nanorc config
# https://github.com/scopatz/nanorc
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

# for the c alias (syntax highlighted cat)
sudo easy_install Pygments

# change to bash 4 (installed by homebrew)
BASHPATH=$(brew --prefix)/bin/bash
#sudo echo $BASHPATH >> /etc/shells
sudo bash -c 'echo $(brew --prefix)/bin/bash >> /etc/shells'
chsh -s $BASHPATH # will set for current user only.
echo $BASH_VERSION # should be 4.x not the old 3.2.X


# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# install drush shim to run drush as if it was global
curl -OL https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar
chmod +x drush.phar
sudo mv drush.phar /usr/local/bin/drush

###
##############################################################################################################



##############################################################################################################
### remaining configuration
###

# go read mathias, paulmillr, gf3, alraa's dotfiles to see what's worth stealing.

# prezto and antigen communties also have great stuff
#   github.com/sorin-ionescu/prezto/blob/master/modules/utility/init.zsh

# set up osx defaults
#   maybe something else in here https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
./osx.sh

###
##############################################################################################################



##############################################################################################################
### symlinks to link dotfiles into ~/
###

#   move git credentials into ~/.gitconfig.local    	http://stackoverflow.com/a/13615531/89484
#   now .gitconfig can be shared across all machines and only the .local changes

# symlink it up!
./symlink-setup.sh

# add manual symlink for .ssh/config

###
##############################################################################################################
