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

alias smoke="time python buildscripts/resmoke.py --dbpathPrefix=~/resmoke_data/smoke1/ --basePort=10000"
alias smoke2="time python buildscripts/resmoke.py --dbpathPrefix=~/resmoke_data/smoke2/ --basePort=15000"
alias smoke3="time python buildscripts/resmoke.py --dbpathPrefix=~/resmoke_data/smoke3/ --basePort=25000"
alias smoke4="time python buildscripts/resmoke.py --dbpathPrefix=~/resmoke_data/smoke4/ --basePort=35000"

alias mcipatch="evergreen patch -p mongodb-mongo-master -a required -f"

alias sconsOld="scons --link-model=object CC=/opt/mongodbtoolchain/v1/bin/gcc CXX=/opt/mongodbtoolchain/v1/bin/g++"
alias sconsold=sconsOld

# OSX
alias buildNinja="./buildscripts/scons.py "MONGO_VERSION=0.0.0" "MONGO_GIT_HASH=unknown" --dbg --variables-files=etc/scons/xcode_macosx.vars --ninja generate-ninja"

# Linux (old)
#alias buildNinja="python buildscripts/scons.py \
#    CCFLAGS='-Wa,--compress-debug-sections -gsplit-dwarf' \
#    MONGO_VERSION='0.0.0' MONGO_GIT_HASH='unknown' \
#    VARIANT_DIR=ninja --modules=ninja --icecream --dbg=on --opt=off \
#    build.ninja"
alias buildninja=buildNinja