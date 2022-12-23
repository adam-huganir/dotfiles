# Zsh stuff
zmodload zsh/datetime

# helper to only run certain commands if the command is installed
function command-found() {command -v $1 > /dev/null}
function exists() {[ -s "$1" ]}
#     _______   ___    __
#    / ____/ | / / |  / /
#   / __/ /  |/ /| | / /
#  / /___/ /|  / | |/ /
# /_____/_/ |_/  |___/
# PATH stuff
export GCLOUD_HOME="$HOME/.local/google-cloud-sdk"
export GOROOT="$HOME/.local/golang"
export GOPATH="$HOME/.local/go"
export PYENV_ROOT="$HOME/.pyenv"
ANTIGEN_SCRIPT="$HOME/.local/src/antigen.zsh"
YARN_BIN="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$HOME/.local/bin:$PYENV_ROOT/ bin:$GCLOUD_HOME/bin:$GOROOT/bin:$GOPATH/bin:$PATH"

export LANG=en_US.UTF-8
export DOTFILES_HOME="$HOME/dotfiles"

# PYTHON ENVS
. "$DOTFILES_HOME/python.env"

# START ANTIGEN
. $ANTIGEN_SCRIPT
### omz

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

antigen use oh-my-zsh
antigen bundles <<EOF
  command-not-found
  copybuffer
  docker
  fzf
  git
  gitignore
  isodate
  kubectx
  nmap
  poetry
  ssh-agent
  terraform
  wakeonlan
  z
EOF

# load in all the zsh lib stuff
antigen bundle zsh-users/zsh-autosuggestions > /dev/null
antigen bundle zsh-users/zsh-completions > /dev/null
antigen bundle zdharma-continuum/fast-syntax-highlighting > /dev/null
antigen bundle johanhaleby/kubetail > /dev/null


### fzf
exists "$HOME/.fzf.zsh" && . "$HOME/.fzf.zsh"
command-found fzf && antigen bundle joshskidmore/zsh-fzf-history-search > /dev/null

## finalize antigen
antigen apply
# END ANTIGEN

##### fast-syntax-highlighting #####
FAST_HIGHLIGHT[use_brackets]=1
####################################

### pyenv
command-found pyenv && eval "$(pyenv init --path)"

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

############ THEME ##############
eval "$(starship init zsh)"
################################

### Misc completions ###
command-found kubectl &&. <(kubectl completion zsh)
command-found helm && . <(helm completion zsh)
command-found skaffold && . <(skaffold completion zsh)
command-found pipx && eval "$(register-python-argcomplete pipx)"
command-found minikube && . <(minikube completion zsh)
command-found gcloud && . "$GCLOUD_HOME/completion.zsh.inc"
command-found poe && . <(poe _zsh_completion)
command-found stern && . <(stern --completion zsh)
command-found istioctl && . <(istioctl completion zsh)
command-found kn && . <(kn completion zsh)
exists "$NVM_DIR/bash_completion" && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# below is needed to activate completions correctly
complete -p > /dev/null  # https://github.com/zsh-users/antigen/issues/698
