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

> **Bootstrap ordering matters.** The steps below are ordered to avoid two
> chicken-and-egg traps: (1) cloning over SSH needs keys you haven't restored
> yet, so the first clone uses **HTTPS**; (2) the zsh config requires Oh My Zsh,
> which must be cloned **before** linking or your first shell errors. Follow the
> order as written.

### 1. Clone the repo (HTTPS — no SSH keys yet)

```bash
# HTTPS works on a fresh machine before any SSH key is restored.
git clone https://github.com/pixelmord/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
export DOTFILES="$PWD"   # matches wherever you cloned; auto-derived later via ~/.zshenv
```

You can clone anywhere — `$DOTFILES` is re-derived from the symlinked `~/.zshenv`
after step 4, so the location doesn't have to be `~/.dotfiles`.

### 2. Install Homebrew and packages

```bash
# Install Homebrew
./bin/dot homebrew install

# Install packages from Brewfile (git, gh, python, jq, coreutils, ... land here)
brew bundle --file=Brewfile
```

After this step the requirements for `dot link`, `dot git`, and `dot sync` are
met (see **Requirements** below).

### 3. Install Oh My Zsh (before linking)

```bash
# The zsh config sources Oh My Zsh; clone it first or the shell errors on start.
git clone https://github.com/ohmyzsh/ohmyzsh.git "$DOTFILES/config/zsh/ohmyzsh"
```

### 4. Link configuration files

```bash
# Link all config packages
./bin/dot link all -v

# Or link specific packages
./bin/dot link zsh
./bin/dot link git
./bin/dot link nvim
```

### 5. Seed tool-managed config files

Some app config files (e.g. `~/.claude/settings.json`) can't be symlinked —
the app rewrites them atomically and would clobber the link. These are kept as
**snapshots** in the repo and materialized onto the machine with `dot sync seed`.
This only writes files that don't already exist (safe to re-run).

```bash
# Requires: $DOTFILES set + python3 (both satisfied after step 2)
./bin/dot sync seed
```

See [docs/adr/0001-tool-managed-files-sync-not-symlink.md](docs/adr/0001-tool-managed-files-sync-not-symlink.md).

### 6. Configure Git

```bash
./bin/dot git setup
```

### 7. Set macOS defaults

```bash
./bin/dot macos defaults
```

### 8. Restore from backup (if migrating)

```bash
# Copy secrets back
cp -r ~/dotfiles-backup/backup_*/secrets/.ssh ~/
cp -r ~/dotfiles-backup/backup_*/secrets/.gnupg ~/
cp -r ~/dotfiles-backup/backup_*/secrets/.config/gh ~/.config/

# Restore local configs
cp ~/dotfiles-backup/backup_*/secrets/.zshrc.local ~/
cp ~/dotfiles-backup/backup_*/secrets/.gitconfig.local ~/

# Now that SSH keys are restored, switch this repo's remote to SSH:
git remote set-url origin git@github.com:pixelmord/dotfiles.git

# Re-clone your repos using the exported list
cat ~/dotfiles-backup/backup_*/git-repos.txt
```

### 9. Install global packages

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
    sync                    Sync tool-managed config files (snapshot <-> live)
        capture [name]      Snapshot live file(s) into the repo (normalized)
        seed [name] [--force]  Write repo snapshot to the live path
        status [--nudge]    Report drift between snapshot and live
    update                  Update all the things
```

### Requirements

Most `dot` subcommands are pure Bash and need only `$DOTFILES` set (auto-derived
from the symlinked `~/.zshenv` once linked). Two exceptions matter during
bootstrap:

| Command       | Needs                        | Available after        |
| ------------- | ---------------------------- | ---------------------- |
| `dot homebrew`| network + curl               | prerequisites          |
| `dot sync`    | `$DOTFILES` + `python3`      | `brew bundle` (step 2) |

`dot sync` **refuses to run** with a clear message if `$DOTFILES` is unset or
`python3` is missing, rather than failing halfway. This is why seeding
(step 5) comes after `brew bundle` (step 2) in the setup order.

### Owned vs tool-managed files

- **Owned files** are symlinked from the repo into `$HOME` — the repo is the
  source of truth (`CLAUDE.md`, zsh/git config, agents).
- **Tool-managed files** are rewritten by an app (which breaks symlinks), so the
  repo keeps a normalized **snapshot** reconciled with `dot sync` instead. Edit
  these in the app, then `dot sync capture` to snapshot. A throttled shell nudge
  flags drift. See [`CONTEXT.md`](CONTEXT.md) and
  [ADR-0001](docs/adr/0001-tool-managed-files-sync-not-symlink.md).

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
