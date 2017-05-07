# Pixelmord's dotfiles.

This repo contains my personal dotfiles and are heavily based on [paul](https://github.com/paulirish/dotfiles/), [mathias](https://github.com/mathiasbynens/dotfiles/) and [addy](http://github.com/addyosmani/dotfiles)'s.

## install the neccessary apps

My basic setup is captured in `setup-a-new-machine.sh` . Run commands manually!

## Copy or Symlink all .dotfiles to your home directory
Skip .git directory !

## private config

Toss it into a file called `.extra` which you do not commit to this repo and just keep in your `~/`

I do something nice with my `PATH` there:

```shell
# PATH like a bawss
      PATH=/opt/local/bin
PATH=$PATH:/opt/local/sbin
PATH=$PATH:/bin
PATH=$PATH:~/.rvm/bin
PATH=$PATH:~/code/git-friendly
# ...

export PATH
```

## Syntax highlighting

…is really important. even for these files.

add the below to this file: `~/Library/Application Support/Sublime Text 2/Packages/ShellScript/Shell-Unix-Generic.tmLanguage`

```xml
<string>.aliases</string>
<string>.bash_profile</string>
<string>.bash_prompt</string>
<string>.bashrc</string>
<string>.brew</string>
<string>.exports</string>
<string>.functions</string>
<string>.git</string>
<string>.gitattributes</string>
<string>.gitconfig</string>
<string>.gitignore</string>
<string>.inputrc</string>
<string>.osx</string>
<string>.vim</string>
<string>.vimrc</string>
```

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./osx.sh
```
See also `setup-a-new-machine.sh`

## Similar projects

I recommend getting a [`.jshintrc`](https://github.com/jshint/node-jshint/blob/master/.jshintrc) and [`.editorconfig`](http://editorconfig.org/) defined for all your projects.





## overview of files

####  Automatic config
* `.ackrc` - for ack (better than grep)
* `.vimrc`, `.vim` - vim config, obv.

#### shell environement
* `.aliases`
* `.bash_profile`
* `.bash_prompt`
* `.bashrc`
* `.exports`
* `.functions`
* `.extra` - not included, explained above

#### manual run
* `install-deps.sh` - random apps i need installed
* `osx.sh` - run on a fresh osx machine
* `brew.sh` - homebrew intialization
* `brew-cask.sh` - homebrew intialization

#### git, brah
* `.git`
* `.gitattributes`
* `.gitconfig`
* `.gitignore`

* `.inputrc` - config for bash readline


## Installation
