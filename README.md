# Dotfiles

Personal dotfiles for macOS development environment. Uses XDG Base Directory structure with a unified `dot` command for management.

## Credits

This setup is heavily influenced by and borrows from:
- [nicknisi/dotfiles](https://github.com/nicknisi/dotfiles) - Primary inspiration for the XDG structure and `dot` command
- [paulirish/dotfiles](https://github.com/paulirish/dotfiles/)
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles/)
- [addyosmani/dotfiles](http://github.com/addyosmani/dotfiles)

## Prerequisites

Install XCode CLI tools first:

```bash
xcode-select --install
```

## Backup Existing Machine

Before migrating, create a full backup of your current setup:

```bash
# Clone this repo (or your fork)
git clone git@github.com:pixelmord/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run full backup - exports packages, repos, secrets, and app settings
./bin/dot backup full -v

# Backup is saved to ~/dotfiles-backup/backup_YYYYMMDD_HHMMSS/
```

The backup includes:
- **Package lists**: Homebrew formulae/casks, npm globals, pnpm globals, uv/pip packages
- **Git repos**: List of all repos in your workspace with remote URLs
- **Secrets**: `.ssh`, `.gnupg`, `.aws`, `.gitconfig.local`, `.npmrc`, `.netrc`, `.zshrc.local`, `.zshenv.local`, `.config/gh`, `.zsh_history`
- **App settings**: Raycast, Cursor (settings + extensions list), Bartender, Karabiner

## Setting Up a New Machine

### 1. Clone the repo

```bash
git clone git@github.com:pixelmord/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
export DOTFILES=~/.dotfiles
```

### 2. Install Homebrew and packages

```bash
# Install Homebrew
./bin/dot homebrew install

# Install packages from Brewfile
brew bundle --file=Brewfile
```

### 3. Link configuration files

```bash
# Link all config packages
./bin/dot link all -v

# Or link specific packages
./bin/dot link zsh
./bin/dot link git
./bin/dot link nvim
```

### 4. Configure Git

```bash
./bin/dot git setup
```

### 5. Set macOS defaults

```bash
./bin/dot macos defaults
```

### 6. Restore from backup (if migrating)

```bash
# Copy secrets back
cp -r ~/dotfiles-backup/backup_*/secrets/.ssh ~/
cp -r ~/dotfiles-backup/backup_*/secrets/.gnupg ~/
cp -r ~/dotfiles-backup/backup_*/secrets/.config/gh ~/.config/

# Restore local configs
cp ~/dotfiles-backup/backup_*/secrets/.zshrc.local ~/
cp ~/dotfiles-backup/backup_*/secrets/.gitconfig.local ~/

# Re-clone your repos using the exported list
cat ~/dotfiles-backup/backup_*/git-repos.txt
```

### 7. Install global packages

```bash
# npm globals
xargs npm install -g < ~/dotfiles-backup/backup_*/npm-global.txt

# Cursor extensions
cat ~/dotfiles-backup/backup_*/apps/Cursor/extensions.txt | xargs -L1 cursor --install-extension
```

## The `dot` Command

Central management tool for all dotfiles operations:

```
dot <command> [subcommand] [options]

Commands:
    help                    Show help message
    link [all|<pkg>]        Symlink config packages to their locations
    unlink [all|<pkg>]      Remove symlinks
    clean                   Remove broken symlinks
    backup [type]           Backup dotfiles and system state
        full                Full backup (all below)
        config              Config files only (default)
        packages            Export package manager lists
        repos               Export git repos from workspace
        secrets             Backup secrets and credentials
        apps                Backup app settings

External commands (dot-*):
    cursor                  Manage Cursor editor extensions
    git                     Setup Git configuration
    homebrew                Setup Homebrew
    macos                   Configure macOS system defaults
    shell                   Setup shell configuration
    update                  Update all the things
```

## Directory Structure

```
~/.dotfiles/
├── bin/                    # Scripts and commands
│   ├── dot                 # Main management command
│   ├── dot-*               # Subcommands (git, homebrew, macos, etc.)
│   └── lib/                # Shared shell utilities
├── config/                 # XDG config packages (symlinked to ~/.config/)
│   ├── aerospace/          # Aerospace window manager
│   ├── ghostty/            # Ghostty terminal
│   ├── git/                # Git config
│   ├── karabiner/          # Keyboard customization
│   ├── kitty/              # Kitty terminal
│   ├── lazygit/            # Lazygit TUI
│   ├── nvim/               # Neovim config (Lua)
│   ├── starship/           # Starship prompt
│   ├── tmux/               # Tmux config
│   ├── wezterm/            # WezTerm terminal
│   └── zsh/                # Zsh config (ZDOTDIR)
├── home/                   # Files symlinked to ~/
│   └── .zshenv             # Bootstrap for ZDOTDIR
├── Brewfile                # Homebrew packages
└── cursor-extensions.txt   # Cursor editor extensions
```

## Shell Configuration

Uses Zsh with Oh My Zsh. Config lives in `config/zsh/` and is loaded via `ZDOTDIR`.

**Key files:**
- `.zshrc` - Main config, plugins, shell options
- `.zsh_aliases` - Command aliases
- `.zsh_functions` - Shell functions
- `.zsh_exports` - Environment variables
- `.zprofile` - Login shell setup

**Plugins (via Oh My Zsh):**
- git, direnv, docker, docker-compose, extract

**Features:**
- `c <dir>` - Quick cd to workspace directories with completion
- `h <dir>` - Quick cd to home directories with completion
- `take <dir>` - mkdir + cd in one command
- Fast keyboard repeat, vi-mode keybindings
- zoxide for smart directory jumping
- fzf for fuzzy finding
- Starship prompt

## Private Configuration

Local overrides that aren't committed:

- `~/.zshrc.local` - Machine-specific shell config
- `~/.zshenv.local` - Machine-specific environment
- `~/.gitconfig.local` - Git user name/email, signing keys

Example `.gitconfig.local`:
```ini
[user]
    name = Your Name
    email = you@example.com
    signingkey = ABCD1234

[commit]
    gpgsign = true
```

## macOS Defaults

The `dot macos defaults` command configures sensible macOS settings:

- **UI/UX**: Expanded save/print panels, save to disk by default
- **Text input**: Disable auto-correct, smart quotes, smart dashes
- **Keyboard**: Fast key repeat, short delay, full keyboard access
- **Trackpad**: Tap to click
- **Finder**: Show hidden files, extensions, path bar, list view
- **Dock**: Auto-hide, no delay, scale effect, faster animations
- **Screenshots**: PNG format, no shadows, save to Desktop

## Recommended Software

Installed via Brewfile:

**Terminals**: Ghostty, WezTerm, Kitty
**Editors**: Neovim, Cursor
**Window Management**: Aerospace
**Utilities**: Raycast, Bartender, Karabiner-Elements
**CLI Tools**: fzf, ripgrep, fd, eza, bat, delta, zoxide, lazygit, tmux
