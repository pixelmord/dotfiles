# vim:ft=ruby

if OS.mac?
  tap 'FelixKratz/formulae' # For janky borders
  # tap 'oven-sh/bun'        # Bun JavaScript runtime (if needed for bun formula)

  # macOS-specific utilities
  brew 'noti'                          # utility to display notifications from scripts
  brew 'trash'                         # rm, but put in the trash rather than completely delete
  brew 'borders'                       # add borders to windows

  # Applications
  cask 'ghostty'                       # a better terminal emulator
  cask 'wezterm'                       # a better terminal emulator
  # cask 'karabiner-elements'            # keyboard customizer
  # cask 'nikitabobko/tap/aerospace'     # a tiling window manager
  cask 'claude-code'                   # Claude AI CLI

  # Fonts
  cask 'font-symbols-only-nerd-font'   # nerd-only symbols font
  cask 'font-monaspace'                # Preferred monospace font

  # ============================================================================
  # CASKS - APPLICATIONS
  # ============================================================================
  # Web Browsers
  cask 'google-chrome'                   # Google Chrome browser
  # cask 'firefox@developer-edition'      # Firefox Developer Edition
  # cask 'microsoft-edge'                 # Microsoft Edge browser
  # cask 'arc'                            # Arc browser

  # Development Tools
  # cask 'visual-studio-code'             # VS Code editor
  cask 'cursor'                          # Cursor editor (AI-powered)
  cask 'codex'                           # AI code completion
  # cask 'github@beta'                    # GitHub Desktop (beta)
  # cask 'jetbrains-toolbox'              # JetBrains Toolbox
  # cask 'postman'                        # API testing tool
  # cask 'hoppscotch'                     # API development ecosystem
  # cask 'ngrok'                          # secure tunnels to localhost

  # Terminal & Shell
  # cask 'iterm2'                         # iTerm2 terminal emulator
  # cask 'tabby'                          # Tabby terminal

  # Productivity
  cask 'raycast'                         # productivity launcher
  # cask 'notion'                         # Notion workspace
  # cask 'obsidian'                       # knowledge base
  # cask 'logseq'                         # privacy-first knowledge base
  cask 'slack'                            # team communication
  # cask 'discord'                        # voice and text chat
  cask 'microsoft-teams'                 # Microsoft Teams

  # Design & Media
  cask 'figma'                           # design tool
  # cask 'handbrake-app'                  # video transcoder
  # cask 'vlc'                            # media player
  # cask 'flameshot'                      # screenshot tool
  # cask 'licecap'                        # animated GIF recorder
  cask 'imagealpha'                      # PNG compression
  cask 'imageoptim'                      # image optimization

  # System Utilities
  cask 'bartender'                       # menu bar organizer
  cask 'caffeine'                        # prevent sleep
  cask 'block-goose'                     # ad blocker
  # cask 'duet'                           # use iPad as second display
  # cask 'rustdesk'                       # remote desktop software
  # cask 'zoom'                           # video conferencing
  cask 'zen'                             # focus and productivity app

  # Cloud & DevOps
  cask 'gcloud-cli'                     # Google Cloud SDK
  cask 'orbstack'                        # Docker Desktop alternative
  cask 'tailscale-app'                   # Tailscale VPN client

  # Elgato Hardware
  cask 'elgato-control-center'           # Elgato Control Center
  cask 'elgato-stream-deck'              # Elgato Stream Deck
  cask 'elgato-wave-link'                # Elgato Wave Link

  # Email & Communication
  # cask 'proton-mail'                    # ProtonMail client
  cask 'proton-pass'                     # Proton Pass password manager
  cask 'lastpass'                       # password manager (consider alternatives)

  # Microsoft
  cask 'microsoft-auto-update'          # Microsoft AutoUpdate

  # Other
  cask 'balenaetcher'                   # flash OS images to SD cards
  # cask 'calibre'                        # e-book management
  cask 'spotify'                         # music streaming
  # cask 'diffmerge'                      # file comparison tool
  # cask 'temurin'                        # OpenJDK distribution

  # ============================================================================
  # CASKS - FONTS
  # ============================================================================
  cask 'font-barlow'                     # Barlow font family
  cask 'font-fira-code'                  # Fira Code font
  cask 'font-hack-nerd-font'             # Hack Nerd Font
  cask 'font-jetbrains-mono'             # JetBrains Mono font
  cask 'font-lato'                       # Lato font family
  # NOTE: font-jetbrains-mono-nerd-font is also installed

  # ============================================================================
  # QUICKLOOK PLUGINS
  # ============================================================================
  cask 'qlcolorcode'                    # QuickLook plugin for source code
  cask 'qlmarkdown'                     # QuickLook plugin for Markdown
  cask 'qlprettypatch'                  # QuickLook plugin for patch files
  cask 'qlstephen'                      # QuickLook plugin for plain text files
  cask 'quicklook-csv'                  # QuickLook plugin for CSV files
  cask 'webpquicklook'                 # QuickLook plugin for WebP images

elsif OS.linux?
  brew 'xclip'                         # access to clipboard (similar to pbcopy/pbpaste)
end

# ============================================================================
# CORE UTILITIES
# ============================================================================
brew 'git'                             # Git version control
brew 'vim'                             # Vim editor
brew 'bash'                            # bash shell
brew 'zsh'                             # zsh shell
brew 'grep'                            # grep
brew 'curl'                            # internet file retriever
brew 'wget'                            # internet file retriever

# ============================================================================
# FILE & DIRECTORY UTILITIES
# ============================================================================
brew 'bat'                             # better cat
brew 'eza'                             # ls alternative
brew 'fd'                              # find alternative
brew 'tree'                            # pretty-print directory contents
brew 'zoxide'                          # switch between most used directories
brew 'rename'                          # batch rename files
brew 'rsync'                           # remote file synchronization
brew 'the_silver_searcher'             # code searching tool (ag)

# ============================================================================
# TEXT PROCESSING & SEARCH
# ============================================================================
brew 'ripgrep'                         # very fast file searcher
brew 'fzf'                             # Fuzzy file searcher, used in scripts and in vim
brew 'gnu-sed'                         # GNU stream editor (more features than BSD sed)
brew 'findutils'                       # GNU find utilities
brew 'coreutils'                       # GNU core utilities
brew 'wdiff'                           # word differences in text files
brew 'pv'                              # monitor data progress through a pipe

# ============================================================================
# CODE QUALITY & DEVELOPMENT TOOLS
# ============================================================================
brew 'shellcheck'                      # diagnostics for shell scripts
brew 'actionlint'                      # GitHub Actions workflow linter
brew 'yamllint'                        # YAML linter
brew 'tflint'                          # Terraform linter
brew 'stylua'                          # lua code formatter
brew 'cloc'                            # lines of code counter
brew 'highlight'                       # code syntax highlighting
brew 'tldr'                            # simplified man pages

# ============================================================================
# VERSION CONTROL & GIT TOOLS
# ============================================================================
brew 'gh'                              # GitHub CLI
brew 'git-delta'                       # a better git diff
brew 'lazygit'                         # a better git UI

# ============================================================================
# PROGRAMMING LANGUAGES & RUNTIMES
# ============================================================================
brew 'python'                          # python (latest)
# brew 'fnm'                             # Fast Node version manager, currently using volta
brew 'uv'                              # Fast Python package installer
brew 'bun'                             # Bun JavaScript runtime
brew 'pyenv'                           # Python version manager
# brew 'elixir'                          # Elixir programming language
brew 'rbenv'                           # Ruby version manager

# ============================================================================
# TERMINAL & SHELL ENHANCEMENTS
# ============================================================================
brew 'tmux'                            # terminal multiplexer
brew 'sesh'                            # terminal session manager
brew 'starship'                        # cross-shell prompt
brew 'gum'                             # fancy UI utilities
brew 'grc'                             # generic colorizer for terminal output
brew 'htop'                            # interactive process viewer
brew 'btop'                            # a top alternative
brew 'macchina'                        # system information fetcher

# ============================================================================
# JSON, YAML & DATA PROCESSING
# ============================================================================
brew 'jq'                              # work with JSON files in shell scripts
brew 'yq'                              # YAML processor (like jq for YAML)

# ============================================================================
# NETWORK & SYSTEM MONITORING
# ============================================================================
brew 'mtr'                             # network diagnostic tool
brew 'nmap'                            # network exploration and security auditing
brew 'watch'                           # execute a program periodically
brew 'watchman'                        # file watching service (used by many dev tools)

# ============================================================================
# BUILD TOOLS & COMPILERS
# ============================================================================
brew 'make'                            # build automation tool
brew 'autoconf'                        # generate configuration scripts
brew 'automake'                        # generate Makefile.in files
brew 'pkgconf'                         # package compiler and linker metadata tool
brew 'zlib'                            # compression library
brew 'openssl@3'                       # SSL/TLS toolkit
brew 'libxml2'                         # XML parser library
brew 'libxmlsec1'                      # XML security library
brew 'freetype'                        # font rendering library
brew 'libpq'                           # PostgreSQL client library
brew 'suite-sparse'                    # sparse matrix library


# ============================================================================
# CONTAINER & ORCHESTRATION
# ============================================================================
# brew 'podman'                         # daemonless container engine
# brew 'k3d'                            # lightweight wrapper to run k3s in Docker
# brew 'kubernetes-cli'                 # Kubernetes command-line tool
# brew 'kubectx'                        # switch between Kubernetes contexts
# brew 'helm'                           # Kubernetes package manager
# brew 'kustomize'                      # Kubernetes native configuration management
# brew 'argocd'                         # declarative GitOps continuous delivery tool
# brew 'aws-iam-authenticator'         # AWS IAM authenticator for Kubernetes
# brew 'terraformer'                    # generate Terraform files from existing infrastructure

# ============================================================================
# CLOUD & INFRASTRUCTURE
# ============================================================================
brew 'awscli'                          # Amazon Web Services command-line interface
# brew 'flyctl'                         # Fly.io command-line interface
# brew 'supabase/tap/supabase'          # Supabase CLI
# brew 'tursodatabase/tap/turso'       # Turso database CLI
# brew 'localstack/tap/localstack-cli'  # LocalStack CLI (local AWS cloud stack)
# brew 'hashicorp/tap/terraform'       # Infrastructure as code tool

# ============================================================================
# DEVELOPMENT WORKFLOW
# ============================================================================
brew 'entr'                            # file watcher / command runner
brew 'direnv'                          # load and unload environment variables
brew 'commitizen'                      # commit message conventions
# brew 'langgraph-cli'                 # LangGraph CLI tool
# brew 'withgraphite/tap/graphite'      # Graphite CLI (stacked Git workflows)

# ============================================================================
# MEDIA & IMAGE PROCESSING
# ============================================================================
# brew 'ffmpeg'                         # multimedia framework
# brew 'imagemagick'                    # image manipulation library
brew 'yt-dlp'                           # download videos from YouTube and other platforms
# brew 'graphviz'                       # graph visualization software

# ============================================================================
# ADDITIONAL UTILITIES
# ============================================================================
brew 'neovim'                          # A better vim
brew 'glow'                            # markdown viewer
# brew 'pipenv'                         # Python dependency manager
# brew 'pipx'                           # install and run Python applications in isolated environments
# brew 'rclone'                         # rsync for cloud storage
# brew 'zopfli'                         # compression library (may be outdated)
# brew 'moreutils'                      # collection of Unix utilities
# brew 'chart-releaser'                 # Helm chart releaser

if OS.mac?
  brew 'terminal-notifier'              # send macOS User Notifications from command line
end

# ============================================================================
# NOTES & RISKS
# ============================================================================
# 1. TAPS: Some taps from the old Brewfile may be outdated:
#    - Check if 'hashicorp/tap', 'helm/tap', 'libsql/sqld', 'localstack/tap',
#      'mongodb/brew', 'oven-sh/bun', 'supabase/tap', 'tursodatabase/tap',
#      'withgraphite/tap' are still needed and valid
#
