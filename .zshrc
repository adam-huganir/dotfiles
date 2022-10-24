set -o vi
zmodload zsh/datetime

export LANG=en_US.UTF-8
export DOTFILES_HOME="$HOME/dotfiles"

export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.local/bin:$HOME/.local/google-cloud-sdk/bin:/usr/local/go/bin:$PATH"

#### Comp init#######
source $HOME/antigen.zsh
########################

# Python envs
source $DOTFILES_HOME/python.env

# START ANTIGEN
### omz 
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
antigen bundles <<EOF > /dev/null
  command-not-found
  copybuffer
  docker
  docker-compose
  fzf
  git
  gitignore
  isodate
  kubectx
  nmap
  ssh-agent
  terraform
  wakeonlan
  z
EOF

antigen bundle zsh-users/zsh-autosuggestions > /dev/null
antigen bundle zsh-users/zsh-completions > /dev/null
# antigen bundle zchee/zsh-completions
antigen bundle zdharma-continuum/fast-syntax-highlighting > /dev/null

## finalize antigen
antigen apply
# antigen cache-gen
# END ANTIGEN

### Misc completions ###
# Add bash compat
autoload -U bashcompinit
bashcompinit

function command-found() {command -v $1 > /dev/null}

command-found kubectl && source <(kubectl completion zsh)
command-found helm && source <(helm completion zsh)
command-found skaffold && source <(skaffold completion zsh)
command-found pipx && eval "$(register-python-argcomplete pipx)"
command-found minikube && source <(minikube completion zsh)
command-found gcloud && source $HOME/.local/google-cloud-sdk/completion.zsh.inc
command-found poe && source <(poe _zsh_completion)
command-found stern && source <(stern --completion zsh)
command-found istioctl && source <(istioctl completion zsh)
command-found kn && source <(kn completion zsh)

#########################

########### GCLOUD ##########
#############################

##### fast-syntax-highlighting #####
FAST_HIGHLIGHT[use_brackets]=1
####################################

######## fzf #############
export FZF_COMPLETION_TRIGGER='##'
##########################

### pyenv
export PYENV_ROOT="$HOME/.pyenv"
command-found pyenv || export PATH="$PYENV_ROOT/bin:$PATH"
command-found pyenv && eval "$(pyenv init -)"


############### GO #############
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

### cargo
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

### nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### fzf
[ -f $HOME/.fzf.zsh ] && source ~/.fzf.zsh


#aws, bzr, cwd, direnv, docker, docker-context, dotenv, duration, exit,
# fossil, gcp, git, gitlite, goenv, hg, host, jobs, kube, load, newline, nix-shell,
#node, perlbrew, perms, plenv, rbenv, root, rvm, shell-var, shenv, ssh, svn,
# termtitle, terraform-workspace, time, user, venv, vgo, vi-mode, wsl)
# defaults: venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root
############ THEME ##############
function powerline_precmd() {
    local __ERRCODE=$?
    local __DURATION=0
    
    if [ -n $__TIMER ]; then
        local __ERT=$EPOCHREALTIME
        __DURATION="$(($__ERT - ${__TIMER:-__ERT}))"
    fi
    eval "$($GOPATH/bin/powerline-go \
        -eval -shell zsh -git-mode compact \
        -cwd-max-depth 6 -cwd-max-dir-size 20 \
        -venv-name-size-limit 26 \
        -colorize-hostname -hostname-only-if-ssh \
        -modules host,ssh,cwd,git,hg,svn,jobs,perms \
        -modules-right exit,dotenv,venv,kube,duration,time \
        -duration $__DURATION -duration-min 10 \
        -theme gruvbox \
    -error $__ERRCODE -jobs $(jobs | wc -l))"
    unset __TIMER
    
}


function preexec() {
    __TIMER=$EPOCHREALTIME
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}


if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    install_powerline_precmd
fi
################################

# my stuff
source "$DOTFILES_HOME/utd.sh"



command-found thefuck && eval $(thefuck --alias) && eval $(thefuck --alias oops)
alias clipboard='xclip -sel clip'
