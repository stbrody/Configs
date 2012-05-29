# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Set the number of threads for scons to use from the number of cores on the machine
if [[ $(uname) == 'Linux' ]]; then
    _CORES=$(grep -c processor /proc/cpuinfo )
else
    _CORES=$(sysctl hw.physicalcpu | awk '{print $2}')
fi
_COMPILE_THREADS=$(echo $_CORES '* 3 / 2' | bc)

# Set scons flags
export SCONSFLAGS="-j$_COMPILE_THREADS --d --dd"

#
# Set the prompt.
#
PS1="\[`tput rev`\]\h\[`tput sgr0`\] \w \$ ";


# git stuff
source $HOME/.git-completion.bash
export PS1='[ \w$(__git_ps1 " (%s)") ] '
#export PS1='[ \w $(vcprompt|sed "s/\\[\\([a-zA-Z0-9]*\\):]/(\\1)/"|sed "s/\\[\\([a-z]*\\):\\([a-z]*\\)\\]/(\\1:\\2)/")] '

#start screen
if [ "$TERM" != "screen" ]; then
     screen
fi
