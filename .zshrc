# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# link to path file to add machine specific PATH extensions
source $HOME/.path

# Other paths
export MANPATH=$MANPATH:$HOME/.local/man:$HOME/man:$MANPATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$HOME/lib:/lib:/usr/lib:/usr/local/lib:$LD_LIBRARY_PATH
export CPATH=$HOME/.local/include:$HOME/apps/include:$CPATH


# History size
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTFILE=~/.zsh_history
# prevent duplicates from being saved in your history file
setopt HIST_IGNORE_ALL_DUPS


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="hugatheme"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    conda-zsh-completion
    cp
    docker
    docker-compose
    gcloud
    git
    gitignore
    history
    jira
    kubectl
    kubetail
    man
    npm
#    autoswitch_virtualenv # does not seem to work
    postgres
    python
    rsync
    skaffold
    ssh
    ssh-agent
    sudo
    systemd
    ubuntu
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Fix docker plugins not working:
autoload -U compinit && compinit

# User configuration
####################

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs'
else
  export EDITOR='code'
fi

# ALIASES:
alias emacs="emacs -nw"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Redshred envs
source ~/.config/.redshred

# jump around
source $Z_HOME/z.sh

# launch glances server
tmux has-session -t services 2> /dev/null || tmux new -ds services glances -s

# Google
# The next line updates PATH for the Google Cloud SDK.
if [ -f '$GCLOUD_HOME/path.zsh.inc' ]; then . '$GCLOUD_HOME/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '$GCLOUD_HOME/completion.zsh.inc' ]; then . '$GCLOUD_HOME/completion.zsh.inc'; fi
# kubectl completions
source <(kubectl completion zsh) 2> /dev/null
