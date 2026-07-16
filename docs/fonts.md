# Installing Fonts

How to install fonts (including Nerd Fonts) for terminals, editors, and the
desktop, on both macOS and Linux (Pop!_OS / COSMIC).

## macOS (via Brewfile)

Font casks live in the `Brewfile`'s `OS.mac?` block, under
`# CASKS - FONTS`. Add a new font by appending a `cask` line:

```ruby
cask 'font-jetbrains-mono-nerd-font'   # JetBrains Mono Nerd Font
cask 'font-fira-code-nerd-font'        # Fira Code Nerd Font
```

Find the exact cask name with:

```bash
brew search font-<name>
```

Install/update all Brewfile fonts with:

```bash
brew bundle --file=Brewfile
```

## Linux (Pop!_OS / COSMIC)

Homebrew casks are **not supported on Linux**, so fonts in the Brewfile's
`OS.mac?` block are skipped by `brew bundle` on this platform. Install fonts
manually instead.

### Option 1: Manual install (Nerd Fonts)

```bash
mkdir -p ~/.local/share/fonts
cd /tmp
curl -fsSL -o JetBrainsMono.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o -q JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -fv ~/.local/share/fonts
```

Repeat for other Nerd Fonts (e.g. `FiraCode.zip`, `Hack.zip`) — the full list
of archive names is on the
[Nerd Fonts releases page](https://github.com/ryanoasis/nerd-fonts/releases/latest).

### Option 2: Distro packages

```bash
apt search fonts- | less        # find font packages
sudo apt install fonts-firacode fonts-jetbrains-mono
```

### Verify installation

```bash
fc-list | grep -i "jetbrains\|fira code"
```

If a newly installed font doesn't show up immediately in an app, rerun
`fc-cache -fv` and restart the app.

## System-wide install (either OS, no package manager)

To make a font available to all users rather than just the current one, drop
it into `/usr/local/share/fonts` instead of `~/.local/share/fonts` and refresh
with `sudo fc-cache -fv`.
