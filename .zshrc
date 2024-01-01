# Zsh stuff
zmodload zsh/datetime
setopt extended_glob
setopt GLOB_STAR_SHORT

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
export PYENV_ROOT="$HOME/.pyenv"
YARN_BIN="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/dotfiles/scripts:$HOME/.local/bin:$PYENV_ROOT/bin:$GCLOUD_HOME/bin:$GOROOT/bin:$PATH"

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
if command-found lvim; then
  export EDITOR='lvim'
elif command-found nvim; then
  export EDITOR='nvim'
elif command-found vim; then
  export EDITOR='vim'
else
  export EDITOR='nano'
fi

###### BEGIN  OH-MY-ZSH ######
ZSH_THEME="agnoster"  # set to null so we can use starship
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
  emoji
  extract
  fast-syntax-highlighting
  fd
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
  ssh-agent
  terraform
  ubuntu
  ufw
  wakeonlan
  z
  zsh-autosuggestions
  zsh-completions
  zsh-interactive-cd
)
CUSTOM_OMZ_FILE="$HOME/.zshrc.d/omz-additional.zsh" # e.g. for adding plugins
if exists "$CUSTOM_OMZ_FILE"; then
  . $CUSTOM_OMZ_FILE
fi
source "$OMZ_HOME/oh-my-zsh.sh"

# plugin  settings
notify_threshold=120  # for bgnotify min seconds
FAST_HIGHLIGHT[use_brackets]=1  # brackets work correctly


###### END OH-MY-ZSH ######

### fzf
exists "$HOME/.fzf.zsh" && . "$HOME/.fzf.zsh"

### pyenv
export PYENV_VIRTUALENV_MANAGE=true
command-found pyenv && eval "$(pyenv init -)"

### cargo
exists "$HOME/.cargo/env" && . "$HOME/.cargo/env"

### nvm
NVM_DIR="$HOME/.nvm"
exists "$NVM_DIR/nvm.sh" && . "$NVM_DIR/nvm.sh"  # This loads nvm

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

############ THEME ##############
# ides + starship do not mix well
if ! [[ $TERMINAL_EMULATOR = 'JetBrains'* || $TERM_PROGRAM = 'vscode'* ]]
then
  eval "$(starship init zsh)"
fi

################################

### Misc completions ###
command-found kubectl && . <(kubectl completion zsh)
command-found helm && . <(helm completion zsh)
command-found skaffold && . <(skaffold completion zsh)
command-found pipx && eval "$(register-python-argcomplete pipx)"
command-found ruff && . <(ruff generate-shell-completion zsh)
command-found minikube && . <(minikube completion zsh)
command-found gcloud && . "$GCLOUD_HOME/completion.zsh.inc"
command-found poe && . <(poe _zsh_completion)
command-found stern && . <(stern --completion zsh)
command-found istioctl && . <(istioctl completion zsh)
command-found kn && . <(kn completion zsh)
command-found argocd && . <(argocd completion zsh)
exists "$NVM_DIR/bash_completion" && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
