# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git direnv docker docker-compose extract)

# Oh My Zsh is cloned into $ZSH during setup (git-ignored). Guard the source so
# a fresh machine that hasn't cloned it yet still gets a working shell instead of
# an error on every prompt. See README "Setting Up a New Machine".
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  printf '\033[33m⚠ Oh My Zsh not found at %s — run: git clone https://github.com/ohmyzsh/ohmyzsh.git "%s"\033[0m\n' "$ZSH" "$ZSH" >&2
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


########################################################
# Configuration
########################################################

# initialize autocomplete
autoload -U compinit add-zsh-hook
compinit

# shell options
export REPORTTIME=10             # show duration for commands >10s
export KEYTIMEOUT=1              # 10ms delay for key sequences (faster vi mode)

setopt NO_BG_NICE                # don't nice background jobs
setopt NO_HUP                    # don't kill background jobs on exit
setopt NO_LIST_BEEP              # no beep on ambiguous completion
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt PROMPT_SUBST
setopt COMPLETE_ALIASES

# history settings
HIST_STAMPS="yyyy-mm-dd"
setopt EXTENDED_HISTORY          # write history in ":start:elapsed;command" format
setopt INC_APPEND_HISTORY        # write to history immediately
setopt SHARE_HISTORY             # share history between sessions
setopt HIST_IGNORE_ALL_DUPS      # remove older duplicate entries
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks
setopt HIST_IGNORE_SPACE         # ignore commands starting with space

# keybindings - terminal navigation
bindkey "^[[1;5C" forward-word                    # Ctrl-right
bindkey "^[[1;5D" backward-word                   # Ctrl-left
bindkey '^[^[[C' forward-word
bindkey '^[^[[D' backward-word
bindkey '^[[1;3D' beginning-of-line               # Alt-left
bindkey '^[[1;3C' end-of-line                     # Alt-right
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^?' backward-delete-char

# delete key handling
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
  for key in "^[[3~" "^[3;5~" "\e[3~"; do
    bindkey "$key" delete-char
  done
fi

# vi mode bindings
bindkey "^A" vi-beginning-of-line
bindkey -M viins "^F" vi-forward-word
bindkey -M viins "^E" vi-add-eol
bindkey "^J" history-beginning-search-forward
bindkey "^K" history-beginning-search-backward

# completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'                    # case insensitive
zstyle ':completion:*' insert-tab pending                              # pasting with tabs doesn't complete
zstyle ':completion:*' completer _expand _complete _files _correct _approximate
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# source local and config files
for file in $ZDOTDIR/.zsh_{exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file

# setup PATH
for dir in $HOME/.cargo/bin $HOME/.local/bin /usr/local/opt/grep/libexec/gnubin /opt/homebrew/opt/libxml2/bin /opt/homebrew/opt/libpq/bin /usr/local/sbin /usr/local/bin $DOTFILES/bin $HOME/bin; do
  prepend_path $dir
done

# define the code directory
# This is where my code exists and where I want the `c` autocomplete to work from exclusively
if [[ -d ~/workspace ]]; then
  export CODE_DIR=~/workspace
elif [[ -d ~/Developer ]]; then
  export CODE_DIR=~/Developer
fi

########################################################
# Setup
########################################################

if command -v starship &>/dev/null; then
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  eval "$(starship init zsh)"
fi

if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS="--color bg:-1,bg+:-1,fg:-1,fg+:#feffff,hl:#993f84,hl+:#d256b5,info:#676767,prompt:#676767,pointer:#676767"
  source <(fzf --zsh)
fi

# colored man pages
export MANROFFOPT='-c'
typeset -A man_colors=(
  mb "$(tput bold; tput setaf 2)"
  md "$(tput bold; tput setaf 6)"
  me "$(tput sgr0)"
  so "$(tput bold; tput setaf 3; tput setab 4)"
  se "$(tput rmso; tput sgr0)"
  us "$(tput smul; tput bold; tput setaf 7)"
  ue "$(tput rmul; tput sgr0)"
  mr "$(tput rev)"
  mh "$(tput dim)"
)
for key val in ${(kv)man_colors}; do
  export LESS_TERMCAP_$key=$val
done

# directory jumping: prefer zoxide over z.sh
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh --hook pwd)"
elif [[ -f "$(brew --prefix 2>/dev/null)/etc/profile.d/z.sh" ]]; then
  source "$(brew --prefix)/etc/profile.d/z.sh"
fi

# detect ls flavor and set color flag
colorflag=$(ls --color &>/dev/null && echo "--color" || echo "-G")

# source local and config files
for file in ~/.zshrc.local "$ZDOTDIR/.zsh_prompt" "$ZDOTDIR/.zsh_aliases"; do
  [[ -f "$file" ]] && source "$file"
done


if command -v pnpm &>/dev/null; then
  export PNPM_HOME="$HOME/Library/pnpm"
  [[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"
fi

if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

[[ -f "$HOME/.zshrc.local" ]] && source $HOME/.zshrc.local

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"

# Nudge if a tool-managed config file has drifted from its repo snapshot
# (see `dot sync` / docs/adr/0001). Throttled to every 14 days, silent when
# clean, and guarded so it can never block or slow shell startup.
if command -v dot &>/dev/null; then
  dot sync status --nudge || true
fi
