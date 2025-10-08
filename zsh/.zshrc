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

# Initialize Zim modules
source ${ZIM_HOME}/init.zsh

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

# ===== FZF CONFIGURATION =====
# set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#c3ccdc"
bg="#011627"
bg_highlight="#1d3b53"
purple="#c792ea"
blue="#82aaff"
cyan="#7fdbca"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd for path completion
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# ===== NVM CONFIGURATION =====
source /opt/homebrew/opt/nvm/nvm.sh

# ===== KEY BINDINGS =====
# bind ctrl+g to run fg
bindkey -s '^G' 'fg\n'

# remap <C-z> to fg key 
if [[ -o interactive ]]; then
  stty susp undef 2>/dev/null
  bindkey -s '^Z' 'fg\n'
fi
