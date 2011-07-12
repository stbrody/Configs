alias rm='rm -i'
alias cp='cp -i'
alias em='emacs -nw'
alias open='gnome-open'
alias genmongotags="cd ~/mongo; find bson client db s shell tools util  -regex \".*\\.[cChH]\\(pp\\)?\" | etags -; cd - > /dev/null"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -F'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'
