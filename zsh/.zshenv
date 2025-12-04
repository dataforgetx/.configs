# =============================================================================
# ZSH ENVIRONMENT CONFIGURATION
# =============================================================================
# This file is sourced from ~/.zshenv
# It contains environment setup that needs to happen before .zshrc

# Source cargo environment if available
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

