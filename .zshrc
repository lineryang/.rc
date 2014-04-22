# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse-corinne"

# Language aliases
alias ipython="~/Library/Python/2.7/bin/ipython"
alias julia="/Applications/Julia-0.2.0.app/Contents/Resources/julia/bin/julia"
alias nosetests="~/Library/Python/2.7/bin/nosetests-2.7"

# ssh into kona[64]
alias kona="ssh cehorn@kona.stanford.edu"
alias kona64="ssh cehorn@kona64.stanford.edu"

# ssh into my trusty raspberry pi server, rusty
alias rusty="ssh corinne@128.12.180.77" # should make more permanent?

# ssh into imac on campus
alias imac="ssh cehorn@ee-imac-boyd.stanford.edu"

# ssh into charlene
alias charlene="ssh corinne@charlene"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git pip nosetests)

# Handle tab titles
export DISABLE_AUTO_TITLE="true"
setTerminalText () {
    # echo works in bash & zsh
    local mode=$1 ; shift
    echo -ne "\033]$mode;$@\007"
}
sett   () { setTerminalText 1 $@; }

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/texbin:/opt/local/bin:/opt/local/sbin:/opt/local/include

# Compilation flags
export ARCHFLAGS="-arch x86_64"
export CFLAGS=-Wunused-command-line-argument-hard-error-in-future
export PYTHONPATH=/Library/Python/2.7/site-packages

