alias rm='rm -i'
alias cp='cp -i'
if [[ $(uname) == 'Linux' ]]; then
    alias open='gnome-open'
fi
alias genmongotags="cd ~/mongo; find bson client db s shell tools util  -regex \".*\\.[cChH]\\(pp\\)?\" | etags -; cd - > /dev/null"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [[ $(uname) == 'Linux' ]]; then
    alias ls='ls --color=auto -F'
else
    alias ls='ls -GF'
fi
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
    
# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'
