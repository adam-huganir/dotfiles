export TERM=xterm-256color

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
     $plugins
    ssh-agent
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Make sure we reload completions (Fix docker plugins not working):
autoload -U compinit && compinit

# User configuration
####################

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Some custom functions
. ~/rc/functions.sh
alias lsdisk='lsblk --output NAME,MOUNTPOINT,LABEL,PARTLABEL,FSUSE%,KNAME,MODE,SIZE,TYPE,STATE,UUID,PARTUUID --exclude 7'
