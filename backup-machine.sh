# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1

#############################################################################################################
###  backup old machine's key items

mkdir -p ~/migration/home
mkdir -p ~/migration/Library/"Application Support"/
mkdir -p ~/migration/Library/Preferences/
mkdir -p ~/migration/Library/Application Support/
mkdir -p ~/migration/rootLibrary/Preferences/SystemConfiguration/
cd ~/migration

# what is worth reinstalling?
brew leaves      		> brew-list.txt    # all top-level brew installs
brew cask list 			> cask-list.txt
npm list -g --depth=0 	> npm-g-list.txt
yarn global ls --depth=0 > yarn-g-list.txt

# git repos in workspace -> print remotes to textfile
cd ~/dotfiles
./gitrepos.sh

# then compare brew-list to what's in `brew.sh`
#   comm <(sort brew-list.txt) <(sort brew.sh-cleaned-up)

# backup some dotfiles likely not under source control
cp -Rp \
    ~/.bash_history \
    ~/.extra ~/.extra.fish \
    ~/.gitconfig.local \
    ~/.gnupg \
    ~/.nano \
    ~/.nanorc \
    ~/.netrc \
    ~/.npmrc \
    ~/.ssh \
    ~/.z   \
    ~/.aws \
    ~/.docker \
    ~/.drush \
        ~/migration/home

cp -R ~/Documents ~/migration

cp -Rp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ~/migration/rootLibrary/Preferences/SystemConfiguration/ # wifi

cp -Rp ~/Library/Preferences/net.limechat.LimeChat.plist ~/migration/Library/Preferences/
cp -Rp ~/Library/Preferences/com.tinyspeck.slackmacgap.plist ~/migration/Library/Preferences/

cp -Rp ~/Library/Services ~/migration/Library/ # automator stuff
cp -Rp ~/Library/Fonts ~/migration/Library/ # all those fonts you've installed

# editor settings & plugins
cp -Rp ~/Library/Application\ Support/Sublime\ Text\ * ~/migration/Library/"Application Support"
cp -Rp ~/Library/Application\ Support/Code\ -\ Insider* ~/migration/Library/"Application Support"

# PHPStrom settings
cp -Rp "~/Library/Application\ Support/PhpStorm2017.1" ~/migration/Library/"Application Support"

# server configs and data
mkdir -p ~/migration/usr/local/etc
cp -R /usr/local/etc/php ~/migration/usr/local/etc
cp -R /usr/local/etc/nginx ~/migration/usr/local/etc

cp -R /usr/local/etc/elasticsearch ~/migration/usr/local/etc
mkdir -p ~/migration/usr/local/var
cp -R /usr/local/var/elasticsearch ~/migration/usr/local/var

mkdir -p ~/migration/private/etc
cp -R /private/etc/apache2 ~/migration/private/etc


# iTerm settings.
  # Prefs, General, Use settings from Folder



### end of old machine backup
##############################################################################################################