# Common shell environment for bash and zsh

# IFNDEF etc
if [ "${DOTFILES_PROFILE_LOADED-}" = "1" ]; then
  return 0 2>/dev/null || true
fi
export DOTFILES_PROFILE_LOADED=1

export DOTFILES_HOME="$HOME/dotfiles"

# Load app-specific paths
if [ -s "$DOTFILES_HOME/.path" ]; then
  . "$DOTFILES_HOME/.path"
fi

export LANG="${LANG:-en_US.UTF-8}"

# Python environmental variables
export PYTHONPYCACHEPREFIX="$HOME/.__pycache__" # don't clutter up my code directories
export PYTHONUNBUFFERED=true
export PYTHONIOENCODING=utf-8

# Load profile functions
if [ -s "$DOTFILES_HOME/profile_functions.sh" ]; then
  . "$DOTFILES_HOME/profile_functions.sh"
fi

add_to_path "$HOME/.local/bin"
add_to_path "$HOME/bin"
add_to_path "$PYENV_ROOT/bin"
add_to_path "$GCLOUD_HOME/bin"
add_to_path "$GOROOT/bin"
add_to_path "$GOPATH/bin"
add_to_path "$HOME/.yarn/bin"
add_to_path "$HOME/.config/yarn/global/node_modules/.bin"

export PATH
