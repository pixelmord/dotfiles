# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for macOS development environment using XDG Base Directory structure. Features a unified `dot` command with plugin-based subcommand architecture for managing shell configuration, system preferences, backups, and symlinks.

### Key Characteristics
- **Primary language**: Bash (strict mode: `set -Eeuo pipefail`)
- **Shell**: Zsh with Oh My Zsh
- **Structure**: XDG Base Directory compliant (`~/.config/`)
- **Management**: Symlink-based (source in dotfiles, links in home)
- **Active since**: 2011 (340+ commits, major refactor 2024-2026)

## Quick Start

### Prerequisites
- macOS (Darwin)
- XCode CLI tools: `xcode-select --install`
- Git

### Initial Setup
```bash
# Clone repository
git clone git@github.com:pixelmord/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
export DOTFILES=~/.dotfiles

# Install Homebrew and packages
./bin/dot homebrew install
brew bundle --file=Brewfile

# Link all configurations
./bin/dot link all -v

# Configure Git identity
./bin/dot git setup

# Apply macOS defaults
./bin/dot macos defaults
```

## Essential Commands

### The `dot` Command
Central management tool - discovers `dot-*` scripts in PATH automatically.

```bash
# Core commands
dot help                     # Show all available commands
dot link all                 # Symlink all config packages
dot link <pkg>               # Symlink specific package (e.g., zsh, nvim)
dot unlink all               # Remove all symlinks
dot clean                    # Remove broken legacy symlinks
dot link clean --dry-run     # Preview broken symlink cleanup

# Backup (creates ~/dotfiles-backup/backup_YYYYMMDD_HHMMSS/)
dot backup full -v           # Full backup with verbose output
dot backup config            # Config files only (default)
dot backup packages          # Export brew/npm/pnpm package lists
dot backup repos             # Export git repos from workspace
dot backup secrets           # Backup .ssh, .gnupg, .aws, local configs
dot backup apps              # Backup Raycast, Cursor, Bartender settings

# External subcommands (dot-* scripts)
dot git setup                # Configure Git credentials
dot homebrew install         # Install Homebrew
dot homebrew bundle          # Install from Brewfile
dot macos defaults           # Apply macOS system preferences
dot shell change             # Set default shell to zsh
dot update all               # Update nvim plugins, homebrew, dotfiles
dot cursor sync              # Sync Cursor editor extensions

# Tool-managed config files (see below) — snapshot <-> live, not symlinked
dot sync status              # Report drift between repo snapshot and live file
dot sync capture <name>      # Snapshot live file into repo (normalized, no commit)
dot sync seed <name>         # Write repo snapshot to live path (bootstrap)
```

### Shell Shortcuts
```bash
reload!                      # Reload zsh configuration
c <dir>                      # cd to $CODE_DIR/<dir> with completion
h <dir>                      # cd to $HOME/<dir> with completion
take <dir>                   # mkdir + cd in one command
```

## Architecture

### XDG Base Directory Structure
```
$DOTFILES/
├── config/                  # Symlinked to ~/.config/<pkg>
│   ├── zsh/                 # ZDOTDIR (shell config)
│   ├── nvim/                # Neovim (Lua config)
│   ├── git/                 # Git configuration
│   └── [other packages]/
├── home/                    # Symlinked to ~/<path>
│   ├── .zshenv              # Bootstrap (sets ZDOTDIR)
│   └── .claude/             # Claude Code settings + agents
└── bin/
    ├── dot                  # Main command (~660 lines)
    ├── dot-*                # Subcommands (auto-discovered)
    └── lib/common.sh        # Shared utilities
```

### Command Discovery Pattern
The `dot` command discovers subcommands dynamically:
```bash
# Any executable named dot-* in PATH becomes a subcommand
# Description extracted from: # Description: <text>
bin/dot-mycommand  →  dot mycommand
```

### Symlink Flow
```
$DOTFILES/config/zsh/  ──symlink──▶  ~/.config/zsh/
$DOTFILES/home/.zshenv ──symlink──▶  ~/.zshenv
```

### Configuration Layers
1. **Base config**: `$DOTFILES/config/*` (version controlled)
2. **Local overrides**: `~/.zshrc.local`, `~/.gitconfig.local` (not committed)
3. **Machine secrets**: `~/.ssh`, `~/.gnupg`, `~/.aws` (backed up separately)

### Owned vs tool-managed files (important)
Two distinct classes — see `CONTEXT.md` and `docs/adr/0001-*`:
- **Owned files**: repo is source of truth, symlinked into `$HOME`. Editing means
  editing the repo (`CLAUDE.md`, zsh/git config, `agents/*`).
- **Tool-managed files**: an app rewrites them atomically, which destroys
  symlinks (e.g. `~/.claude/settings.json`, written by Claude Code + supacode;
  `~/.pi/agent/settings.json`, written by the PI agent).
  These are **not symlinked**. The repo holds a normalized snapshot reconciled
  via `dot sync` (`capture` live→repo, `seed` repo→live). Do NOT try to symlink
  them or edit the snapshot expecting it to go live — capture from the app.
  Snapshots strip supacode hooks and contract `$HOME`/`$DOTFILES` paths.

## Project Structure

```
~/.dotfiles/
├── bin/                        # Scripts and commands
│   ├── dot                     # Main dotfiles manager
│   ├── dot-cursor              # Cursor extension manager
│   ├── dot-git                 # Git credential setup
│   ├── dot-homebrew            # Homebrew installer
│   ├── dot-macos               # macOS defaults
│   ├── dot-shell               # Shell configuration
│   ├── dot-update              # Update utilities
│   ├── lib/
│   │   └── common.sh           # Colors, logging, spinners
│   ├── archive/                # Deprecated scripts (reference only)
│   └── [30+ utility scripts]   # git-*, tmux-*, claude-*, etc.
├── config/
│   ├── zsh/                    # Zsh config (ZDOTDIR)
│   │   ├── .zshrc              # Main config
│   │   ├── .zsh_aliases        # Aliases
│   │   ├── .zsh_functions      # Functions (including zfetch)
│   │   ├── .zsh_exports        # Environment variables
│   │   └── ohmyzsh/            # Oh My Zsh (git-ignored)
│   ├── nvim/                   # Neovim (Lua, lazy.nvim)
│   ├── git/                    # Git config + aliases
│   ├── tmux/                   # Tmux configuration
│   ├── starship/               # Prompt configuration
│   ├── ghostty/                # Terminal config
│   ├── wezterm/                # Terminal config
│   ├── kitty/                  # Terminal config
│   ├── lazygit/                # Git TUI
│   ├── karabiner/              # Keyboard customization
│   ├── aerospace/              # Tiling window manager
│   └── [other packages]/
├── home/
│   ├── .zshenv                 # Bootstrap (sets XDG paths)
│   ├── .claude/                # Claude Code config + 20+ agents
│   └── .pi/agent/              # PI agent settings.json snapshot (tool-managed, dot sync)
├── Brewfile                    # Homebrew packages (291 lines)
├── cursor-extensions.txt       # Cursor extensions list
└── README.md
```

## Important Patterns

### Adding a New dot-* Subcommand

1. Create executable: `bin/dot-mycommand`
2. Use this template:
```bash
#!/usr/bin/env bash
# Description: Short description shown in dot help

set -Eeuo pipefail
source "$DOTFILES/bin/lib/common.sh"
command_name=$(basename "${BASH_SOURCE[0]}")

usage() {
  cat <<EOF
  $(fmt_key "Usage:") $(fmt_cmd "$command_name") $(fmt_value "[options] <command>")

Options:
    -h, --help       Show this help message
    subcommand       Description
EOF
}

cmd_subcommand() {
  # Implementation
}

main() {
  local subcmd=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -h | --help) usage; exit 0 ;;
    *) subcmd="$1"; shift ;;
    esac
  done

  case "$subcmd" in
  subcommand) cmd_subcommand "$@" ;;
  *) log_error "Unknown command: $subcmd"; usage; exit 1 ;;
  esac
}

main "$@"
```
3. Make executable: `chmod +x bin/dot-mycommand`
4. Auto-discovered by `dot help`

### Adding a New Config Package

1. Create directory: `config/mypackage/`
2. Add config files inside
3. Link: `dot link mypackage`
4. Result: `~/.config/mypackage` symlinked to `$DOTFILES/config/mypackage`

### Local Override Pattern
Machine-specific config without committing secrets:
```bash
# These files are sourced at END of main configs (can override anything)
~/.zshrc.local       # Shell customizations
~/.zshenv.local      # Environment variables
~/.gitconfig.local   # Git user/email/signing key

# Example ~/.gitconfig.local
[user]
    name = Your Name
    email = you@example.com
```

### Error Handling Pattern
All scripts use strict mode:
```bash
set -Eeuo pipefail                    # Exit on error, undefined vars, pipe failures
trap cleanup SIGINT SIGTERM ERR EXIT  # Cleanup on any exit

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  tput cnorm 2>/dev/null || true      # Restore cursor
}
```

## Code Style

### Bash Conventions
- **Shebang**: `#!/usr/bin/env bash`
- **Safety**: Always `set -Eeuo pipefail`
- **Sourcing**: Validate file exists before sourcing
- **Quoting**: Always quote variables `"$var"`, use `"${var:-default}"`

### Naming Conventions
```bash
# Files
bin/dot-mycommand           # Subcommands: dot-<name>
config/package/             # Config packages: lowercase

# Functions
cmd_backup()                # Command handlers: cmd_<action>
backup_packages()           # Helpers: <verb>_<noun>
setup_colors()              # Utilities: <verb>_<noun>

# Variables
local backup_dir            # Local: lowercase snake_case
CONFIG_HOME                 # Constants: UPPERCASE
verbose=true                # Booleans: string "true"/"false"
```

### Logging (from lib/common.sh)
```bash
log_info "Message"          # Blue ℹ icon
log_success "Message"       # Green ✔ icon
log_warning "Message"       # Yellow ⚠ icon
log_error "Message"         # Red ✖ icon (to stderr)

# Formatting
fmt_key "Label"             # Cyan bold
fmt_value "value"           # Bright cyan
fmt_cmd "command"           # Magenta bold
fmt_path "/path/to/file"    # Bright blue
```

### Git Conventions
- **Commit style**: Conventional commits (`type: description`)
- **Types**: `feat`, `fix`, `chore`, `refactor`, `docs`
- **Examples**: `feat: add backup command`, `fix: resolve symlink issue`

## Hidden Context

### macOS-Specific Behavior
- `dot macos defaults` closes System Preferences before applying (prevents override conflicts)
- Git credentials use `osxkeychain` helper (macOS native)
- Brewfile has `if OS.mac?` guard for macOS-only packages
- Screenshot settings, Dock behavior, Finder preferences are Darwin-specific

### Security Considerations
- **Never committed**: `.ssh`, `.gnupg`, `.aws`, `.gitconfig.local`, `.npmrc`, `.zshrc.local`
- **Backup warning**: Secrets directory contains sensitive data
- **History security**: Commands prefixed with space don't enter history (`HIST_IGNORE_SPACE`)
- **Backup includes**: `.zsh_history` (may contain sensitive commands)

### Zsh Initialization Order
```
1. ~/.zshenv           (Bootstrap: sets ZDOTDIR, DOTFILES)
2. ~/.config/zsh/.zprofile  (Login shells only)
3. ~/.config/zsh/.zshrc     (Interactive shells)
   └── sources: .zsh_exports, .zsh_aliases, .zsh_functions
   └── sources: ~/.zshrc.local (if exists)
```

### Known Gotchas

1. **DOTFILES must be set**: Scripts depend on `$DOTFILES` environment variable
2. **Symlink safety**: `dot link` skips existing targets (won't overwrite)
3. **Broken symlinks**: Use `dot link clean --dry-run` before cleanup
4. **Workspace discovery**: `dot backup repos` scans `$CODE_DIR` (default: `~/workspace`) to depth 3
5. **Oh My Zsh**: Directory `config/zsh/ohmyzsh/` is git-ignored (cloned on setup)

### Hot Spots (Frequently Changed)
Based on git history, these files change most often:
- `.zsh_aliases` / `.zsh_functions` - Shell customizations
- `dot-macos` - macOS defaults (high-risk, test carefully)
- `config/git/config` - Git aliases and settings

### Deprecated/Archived
- `bin/archive/` - Old scripts, reference only
- `dot_archive/` - Legacy bash configs (pre-zsh migration)
- Fish shell config removed
- Powerlevel10k replaced by Starship

## Utility Scripts Reference

### Git Utilities (bin/git-*)
```bash
git-bare-clone <url>        # Clone as bare repo
git-create-worktree         # Create git worktree
git-kill <branch>           # Delete local + remote branch
git-modified                # Show modified files
git-recent                  # Show recent branches
```

### Tmux Utilities
```bash
tm                          # Tmux session manager
tmux-git-status             # Git status for tmux
tmux-smart-name             # Intelligent window naming
```

### Claude Utilities
```bash
claude-dashboard            # Claude AI dashboard
claude-status               # Show Claude status
claude-statusline           # Statusline integration
```

## Debugging

### Common Issues

1. **"DOTFILES not set"**
   - Ensure `~/.zshenv` is symlinked: `dot link all`
   - Or manually: `export DOTFILES=~/.dotfiles`

2. **Symlink already exists**
   - Check what's there: `ls -la ~/.config/zsh`
   - Remove manually if needed, then re-link

3. **Command not found: dot**
   - Add to PATH: `export PATH="$DOTFILES/bin:$PATH"`
   - Or use full path: `~/.dotfiles/bin/dot`

4. **zsh config not loading**
   - Verify ZDOTDIR: `echo $ZDOTDIR` (should be `~/.config/zsh`)
   - Check `.zshenv` symlink: `ls -la ~/.zshenv`

### Verbose Mode
Most commands support `-v` or `--verbose`:
```bash
dot link all -v
dot backup full -v
dot link clean --dry-run -v
```

## Resources

### Internal
- `README.md` - Setup guide and command reference
- `Brewfile` - Package manifest with comments
- `bin/lib/common.sh` - Logging and formatting utilities

### External Inspirations
- [nicknisi/dotfiles](https://github.com/nicknisi/dotfiles) - Primary inspiration (XDG structure, dot command)
- [paulirish/dotfiles](https://github.com/paulirish/dotfiles/)
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles/)

## Agent skills

### Issue tracker

Issues are tracked in the `pixelmord/dotfiles` GitHub Issues, via the `gh` CLI. See `docs/agents/issue-tracker.md`.

### Triage labels

Default canonical labels: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `CONTEXT.md` + `docs/adr/` at the repo root. See `docs/agents/domain.md`.
