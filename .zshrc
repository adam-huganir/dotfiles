# Zsh stuff
zmodload zsh/datetime
autoload -z edit-command-line
zle -N edit-command-line
#bindkey -M vicmd v edit-command-line

setopt extended_glob
setopt GLOB_STAR_SHORT
unsetopt autocd
set +x

# helper to only run certain commands if the command is installed
function command-found() {command -v $1 > /dev/null}
function exists() {[ -s "$1" ]}
#     _______   ___    __
#    / ____/ | / / |  / /
#   / __/ /  |/ /| | / /
#  / /___/ /|  / | |/ /
# /_____/_/ |_/  |___/
# PATH stuff
export OMZ_HOME=$HOME/.oh-my-zsh
export GCLOUD_HOME="$HOME/.local/google-cloud-sdk"
export GOROOT="$HOME/.local/go"
export GOPRIVATE=github.com/redshred
export PYENV_ROOT="$HOME/.pyenv"
YARN_BIN="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.fvm_flutter/bin:$PATH"
export PATH="$HOME/dotfiles/scripts:$HOME/.local/bin:$PYENV_ROOT/bin:$GCLOUD_HOME/bin:$GOROOT/bin:$HOME/go/bin:$HOME/.local/flutter/bin:$PATH"

export LANG=en_US.UTF-8
export DOTFILES_HOME="$HOME/dotfiles"

export LESS=XR

# PYTHON ENVS
. "$DOTFILES_HOME/python.env"

# USER stuff and custom local overrides
exists "$HOME/.alias" && . "$HOME/.alias"
exists "$HOME/.path" && . "$HOME/.path"
exists "$HOME/.python.env" && . "$HOME/.python.env"
exists "$HOME/.zshrc.d/zshrc.zsh" && . "$HOME/.zshrc.d/zshrc.zsh"

# EDITOR preference order
if command-found nvim; then
  export EDITOR='nvim'
elif command-found nvim; then
  export EDITOR='nvim'
elif command-found vim; then
  export EDITOR='vim'
else
  export EDITOR='nano'
fi

###### BEGIN  OH-MY-ZSH ######
ZSH_THEME="agnoster" # starship overrides
COMPLETION_WAITING_DOTS="true"

# History
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=50000
SAVEHIST=100000

# OH-MY-ZSH
plugins=(
  battery
  bgnotify
  command-not-found
  copybuffer
  docker
 # emoji
  fast-syntax-highlighting
  fzf
  gh
  git
  gitignore
  httpie
  isodate
  kubectx
  kubetail
  microk8s
  nmap
  pip
  poetry
  rust
  ssh-agent
  terraform
  ubuntu
  ufw
  wakeonlan
  z
  zsh-completions
  zsh-vim-mode
  zsh-autosuggestions
)
CUSTOM_OMZ_FILE="$HOME/.zshrc.d/omz-additional.zsh" # e.g. for adding plugins
if exists "$CUSTOM_OMZ_FILE"; then
  . $CUSTOM_OMZ_FILE
fi
source "$OMZ_HOME/oh-my-zsh.sh"

# plugin  settings
notify_threshold=120           # for bgnotify min seconds
FAST_HIGHLIGHT[use_brackets]=1 # brackets work correctly

###### END OH-MY-ZSH ######

### Vim mode
MODE_CURSOR_VIINS="#00ff00 blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

### fzf
exists "$HOME/.fzf.zsh" && . "$HOME/.fzf.zsh"

### pyenv
export PYENV_VIRTUALENV_MANAGE=false
# command-found pyenv && eval "$(pyenv init -)"

### cargo
exists "$HOME/.cargo/env" && . "$HOME/.cargo/env"

### n (node)
export N_PREFIX="$HOME/.n"
exists "$N_PREFIX" && export PATH="$N_PREFIX/bin:$PATH"

# my stuff
exists "$DOTFILES_HOME/utd.sh" && . "$DOTFILES_HOME/utd.sh"
exists "$DOTFILES_HOME/functions.sh" && . "$DOTFILES_HOME/functions.sh"

command-found thefuck && eval $(thefuck --alias) && eval $(thefuck --alias oops)

# X env only
alias clipboard='xclip -sel clip'
# Wezterm only
alias imgcat='wezterm imgcat'
alias pdr='patch-deployment-image reader'

# copilot
command-found github-copilot-cli && eval "$(github-copilot-cli alias -- "$0")"


################################

### Misc completions ###
command-found pipx && eval "$(register-python-argcomplete pipx)"
command-found ruff && eval "$(ruff generate-shell-completion zsh)"
command-found gcloud && . "$GCLOUD_HOME/completion.zsh.inc"
command-found poe && eval "$(poe _zsh_completion)"
command-found stern && eval "$(stern --completion zsh)"
command-found yq && eval "$(yq shell-completion zsh)"
command-found uv &&  eval "$(uv generate-shell-completion zsh)"

command-found yq && eval "$(task --completion zsh)"
export TASK_X_REMOTE_TASKFILES=1

command-found rsctl && eval "$(rsctl --show-completion zsh)"
for app in crane gcrane krane argo kn istioctl minikube skaffold helm kubectl; do
  command-found $app && eval "$($app completion zsh)"
done

# wine
if command-found wine; then
  if exists "$HOME/.local/share/npp/notepad++.exe"; then
    alias npp="nohup wine $HOME/.local/share/npp/notepad++.exe & >/dev/null 2>&1"
  fi
fi

# below is needed to activate completions correctly
compinit
alias gactivate="gcloud config configurations activate"

# pnpm
export PNPM_HOME="/home/adam/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/adam/.dart-cli-completion/zsh-config.zsh ]] && . /home/adam/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export TASK_X_REMOTE_TASKFILES=1
set +x

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/adam/.bun/_bun" ] && source "/home/adam/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[[ -s "/home/adam/.gvm/scripts/gvm" ]] && source "/home/adam/.gvm/scripts/gvm"

[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.
