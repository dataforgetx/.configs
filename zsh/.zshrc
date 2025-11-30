# =============================================================================
# VI MODE CONFIGURATION
# =============================================================================

# Vi mode indicator
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'  # Block cursor
  elif [[ ${KEYMAP} == main ]] ||
     [[ ${KEYMAP} == viins ]] ||
     [[ ${KEYMAP} = '' ]] ||
     [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'  # Beam cursor
  fi
}
zle -N zle-keymap-select

# Start with beam cursor
echo -ne '\e[5 q'

# Restore beam cursor when line is finished
function zle-line-init() {
    echo -ne '\e[5 q'
}
zle -N zle-line-init

# Reduce escape timeout (makes switching to normal mode faster)
export KEYTIMEOUT=1

# Better vi mode bindings
bindkey -M vicmd 'gg' beginning-of-buffer-or-history
bindkey -M vicmd 'G' end-of-buffer-or-history
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M viins '^R' history-incremental-search-backward

# =============================================================================
# ZSH CONFIGURATION
# =============================================================================

# -----------------
# Zsh Built-in Settings
# -----------------

# History
setopt HIST_IGNORE_ALL_DUPS

# Input/output
bindkey -v  # Use vi keybindings

# Remove path separator from WORDCHARS for better word navigation
WORDCHARS=${WORDCHARS//[\/]}

# ===== ZIM CONFIGURATION =====
# Point to your zimrc location
export ZIM_CONFIG_FILE="$HOME/.zimrc"
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# ===== FZF CONFIGURATION =====
# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Initialize Zim modules
source ${ZIM_HOME}/init.zsh

# set up fzf key bindings
# Note: fzf completion is handled by ZIM's completion module, so we only need key bindings
if command -v fzf >/dev/null 2>&1; then
  # Find and source fzf key bindings
  if [[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]]; then
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
  elif [[ -f "$(brew --prefix fzf 2>/dev/null)/shell/key-bindings.zsh" ]]; then
    source "$(brew --prefix fzf)/shell/key-bindings.zsh"
  fi
fi

# --- setup fzf theme (Catppuccin Macchiato-inspired) ---
fg="#cad3f5"           # Slightly brighter text
bg="#24273a"           # Darker, more blue-tinted background
bg_highlight="#363a4f" # Subtle highlight with blue undertone
purple="#c6a0f6"       # Brighter, more vibrant purple
blue="#8aadf4"         # Slightly desaturated blue
cyan="#8bd5ca"         # Brighter, more electric cyan
pink="#ffb3d9"         # Softer pink
green="#a8e6a0"        # Lighter green
export FZF_DEFAULT_OPTS='--color=bg:#24273a,fg:#cad3f5,hl:#c6a0f6,fg+:#cad3f5,bg+:#363a4f,hl+:#c6a0f6,info:#8aadf4,prompt:#8bd5ca,pointer:#ffb3d9,marker:#a8e6a0,spinner:#8bd5ca,header:#8aadf4'


# Use fd for path completion
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


# ===== PATH CONFIGURATIONS =====
# Path to Wezterm
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# Add iTerm2 utilities (imgcat) to your PATH
export PATH="$PATH:/Applications/iTerm.app/Contents/Resources/utilities"

# Path to Deno
export PATH="$HOME/.deno/bin:$PATH"

# Path to Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Path to Go
export PATH="/usr/local/go/bin:$PATH"

# ruby path
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

# gives you access to unversioned commands(python, pip)
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"

export PATH="/opt/homebrew/Cellar/cmake/4.0.2/bin:$PATH"

# give you access to the versioned commands(python3, pip3)
export PATH="/opt/homebrew/bin:$PATH"

# zig
export PATH=$PATH:"/usr/bin/zig"

export PATH=/Library/PostgreSQL/16/bin:$PATH

export PATH="/Applications/Racket v8.14/bin:$PATH"

# ===== ENVIRONMENT VARIABLES =====
# set the TERM environment variable
export TERM=xterm-256color

# Preferred editor
export EDITOR="nvim"


# ===== NVM CONFIGURATION =====
source /opt/homebrew/opt/nvm/nvm.sh

# =============================================================================
# KEY BINDINGS
# =============================================================================

# History substring search (configured after zim initialization)
zmodload -F zsh/terminfo +p:terminfo
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# Custom key bindings
bindkey -s '^G' 'fg\n'  # Ctrl+G to foreground job

# Remap Ctrl+Z to fg
if [[ -o interactive ]]; then
  stty susp undef 2>/dev/null
  bindkey -s '^Z' 'fg\n'
fi
