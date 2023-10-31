alias rm='rm -i'
alias cp='cp -i'
alias myip="curl -Is checkip.10gen.com | grep X-Your-IP | cut -f2 -d' '" # Find my IP address
alias eclipse="eclipse -vmargs -Xmx4G -XX:MaxPermSize=4G"
if [[ $(uname) == 'Linux' ]]; then
    alias open='gnome-open'
fi
alias cargo='time cargo'
alias npm='time npm'
alias npmcib='npm run clean && npm i && npm run build'
alias npmib='npm i && npm run build'
alias npmi='npm i'
alias npmb='npm run build'
alias ceramic='time node packages/cli/bin/ceramic.js'
alias composedb='time node packages/cli/bin/run.js'
alias glaze='time node packages/cli/bin/run'
alias ipfs='time ipfs'

alias fuck='eval $(thefuck $(fc -ln -1))'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [[ $(uname) == 'Linux' ]]; then
    alias ls='ls --color=auto -F -h'
else
    alias ls='ls -GFh'
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