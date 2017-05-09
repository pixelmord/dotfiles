# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1


##############################################################################################################
###  backup old machine's key items

mkdir -p ~/migration/home
cd ~/migration

# what is worth reinstalling?
brew leaves      		> brew-list.txt    # all top-level brew installs
brew cask list 			> cask-list.txt
npm list -g --depth=0 	> npm-g-list.txt

# git repos in workspace -> print remotes to textfile
cd ~/dotfiles
./gitrepos.sh

# then compare brew-list to what's in `brew.sh`
#   comm <(sort brew-list.txt) <(sort brew.sh-cleaned-up)

# let's hold on to these

cp ~/.extra ~/migration/home
cp ~/.z ~/migration/home

cp -R ~/.ssh ~/migration/home
#cp -R ~/.gnupg ~/migration/home

cp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ~/migration  # wifi

cp ~/Library/Preferences/net.limechat.LimeChat.plist ~/migration
cp ~/Library/Preferences/com.tinyspeck.slackmacgap.plist ~/migration

cp -R ~/Library/Services ~/migration # automator stuff

cp -R ~/Documents ~/migration

cp -R ~/.aws ~/migration/home

cp -R ~/.docker ~/migration/home

cp -R ~/.drush ~/migration/home

# sublime text settings
cp -R "~/Library/Application Support/Sublime Text 3/Packages" ~/migration

# PHPStrom settings
cp -R "~/Library/Application\ Support/PhpStorm2017.1" ~/migration

# server configs and data
mkdir -p ~/migration/usr/local/etc/php
cp -R /usr/local/etc/php/7.0 ~/migration/usr/local/etc/php

mkdir -p ~/migration/usr/local/etc
cp -R /usr/local/etc/nginx ~/migration/usr/local/etc

mkdir -p ~/migration/usr/local/etc
cp -R /usr/local/etc/elasticsearch ~/migration/usr/local/etc
mkdir -p ~/migration/usr/local/var
cp -R /usr/local/var/elasticsearch ~/migration/usr/local/var

mkdir -p ~/migration/private/etc
cp -R /private/etc/apache2 ~/migration/private/etc


# iTerm settings.
  # Prefs, General, Use settings from Folder



### end of old machine backup
##############################################################################################################



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

# ruby with rvm
sh -c "$(curl -sSL https://get.rvm.io | bash -s stable --ruby)"

# oh my zsh
# https://github.com/robbyrussell/oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
bash < <( curl https://raw.githubusercontent.com/jamiew/git-friendly/master/install.sh)

# global npm packages
./npm.sh

# github.com/rupa/z   - oh how i love you
git clone https://github.com/rupa/z.git ~/code/z
# consider reusing your current .z file if possible. it's painful to rebuild :)
# z is hooked up in .bash_profile


# for the c alias (syntax highlighted cat)
sudo easy_install Pygments

# iterm with more margin! http://hackr.it/articles/prettier-gutter-in-iterm-2/
#   (admittedly not as easy to maintain)

# setting up the sublime symlink
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# install drush shim to run drush as if it was global
composer global require webflo/drush-shim

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


###
##############################################################################################################
