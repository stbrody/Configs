# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Add USER_HOME so my setup scripts can look there to see what to treat
# as the home dir
export USER_HOME="/Users/spencer"

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=20000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load personal environment settings

if [ -f ~/.environment ]; then
    . ~/.environment
fi

if [ -f ~/.secrets ]; then
    . ~/.secrets
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set the number of threads for scons to use from the number of cores on the machine
if [[ $(uname) == 'Linux' ]]; then
    _OS='Linux'
    _CORES=$(grep -c processor /proc/cpuinfo )
else
    _OS='OSX'
    _CORES=$(sysctl hw.logicalcpu | awk '{print $2}')
fi
_COMPILE_THREADS=$_CORES

#
# Set the prompt.
#
PS1="\[`tput rev`\]\h\[`tput sgr0`\] \w \$ ";


# git stuff
source $HOME/.git-completion.bash
export PS1='[ \w$(__git_ps1 " (%s)") ] '
#export PS1='[ \w $(vcprompt|sed "s/\\[\\([a-zA-Z0-9]*\\):]/(\\1)/"|sed "s/\\[\\([a-z]*\\):\\([a-z]*\\)\\]/(\\1:\\2)/")] '

if [[ $(uname) == 'Linux' ]]; then
    /home/spencer/bin/xinput_set
fi

#start screen
if [ "$TERM" != "screen.xterm-256color" ] && [ "$TERM" != "screen" ]; then
     screen
fi

# python include path
#if [ "$_OS" = "OSX" ]; then
#    export PYTHONPATH='/usr/local/lib/python2.7/site-packages'
#fi

# Set up pyenv to manage python versions
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


function repeat(){
    for ((i=0;i<$1;i++)); do
        eval ${*:2}
    done
}

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:$HOME/.foundry/bin"

export PNPM_HOME="/home/spencer/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

#export PATH="$HOME/.local/bin:$PATH"

# Put /usr/local/bin before /usr/bin
#export PATH="/usr/local/bin:$PATH"

# Add Rust's cargo bin to PATH
. "$HOME/.cargo/env"

# Add brew-installed ruby to path before system ruby
#export PATH="/usr/local/opt/ruby/bin:$PATH"

export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

# source /Users/spencer/.docker/init-bash.sh || true # Added by Docker Desktop

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/spencer/google-cloud-sdk/path.bash.inc' ]; then . '/Users/spencer/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/spencer/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/spencer/google-cloud-sdk/completion.bash.inc'; fi
