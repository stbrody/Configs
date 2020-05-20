alias rm='rm -i'
alias cp='cp -i'
alias myip="curl -Is checkip.10gen.com | grep X-Your-IP | cut -f2 -d' '" # Find my IP address
alias eclipse="eclipse -vmargs -Xmx4G -XX:MaxPermSize=4G"
if [[ $(uname) == 'Linux' ]]; then
    alias open='gnome-open'
fi
alias cargo='time cargo'

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

# 10gen specific aliases
#alias genmongotags="find bson client db s shell tools util  -regex \".*\\.[cChH]\\(pp\\)?\" | etags -"
alias genmongotags="ctags -e --extra=+qf --fields=+iasnfSKtm --c++-kinds=+p  --recurse ."

alias smoke="time python3 buildscripts/resmoke.py run --dbpathPrefix=~/resmoke_data/smoke1/ --basePort=10000"
alias smoke2="time python3 buildscripts/resmoke.py run --dbpathPrefix=~/resmoke_data/smoke2/ --basePort=15000"
alias smoke3="time python3 buildscripts/resmoke.py run --dbpathPrefix=~/resmoke_data/smoke3/ --basePort=25000"
alias smoke4="time python3 buildscripts/resmoke.py run --dbpathPrefix=~/resmoke_data/smoke4/ --basePort=35000"

alias mcipatch="evergreen patch -p mongodb-mongo-master -a required -f"
alias commitqueue="evergreen commit-queue merge --project mongodb-mongo-master"

alias sconsOld="scons --link-model=object CC=/opt/mongodbtoolchain/v1/bin/gcc CXX=/opt/mongodbtoolchain/v1/bin/g++"
alias sconsold=sconsOld


if [[ $(uname) == 'Linux' ]]; then
  alias buildNinja="python3 buildscripts/scons.py \
    MONGO_VERSION='0.0.0' MONGO_GIT_HASH='unknown' \
    --dbg=on --opt=off --link-model=dynamic --install-mode=hygienic \
    --variables-files=./etc/scons/mongodbtoolchain_stable_gcc.vars \
    ICECC=icecc CCACHE=ccache \
    --ninja=next generate-ninja"
else
  alias buildNinja="python3 buildscripts/scons.py \
    "MONGO_VERSION=0.0.0" "MONGO_GIT_HASH=unknown" \
    --dbg=on --opt=off --link-mode=dynamic --install-mode=hygienic \
    --variables-files=etc/scons/xcode_macosx.vars \
    CCACHE=ccache \
    --ninja=next generate-ninja"

fi

alias buildninja=buildNinja