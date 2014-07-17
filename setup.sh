#!/bin/bash

FILES=(.bash_aliases .bashrc .emacs.d .environment .git-completion.bash .gitconfig .globalgitignore .mongorc.js .mongorc.colors.js .profile .screenrc useful)

DIRECTORIES=(.ssh) # TODO: symlink files from within directories.

for filename in ${FILES[@]}
do
    src=${HOME}/${filename}
    dst="$HOME/.configs/$filename"

    # Delete file if it exists.
    if [ -e $src ]; then
        if [[ -L $src && $(readlink $src) == $dst ]]; then
            # If the symlink is already set up, don't have to do anything!
            continue
        elif [ -d $src ]; then
            rm -i -r $src
        else
            rm -i $src
        fi
    fi
    # Symlink to files in git repo
    ln -s $dst $src
done

# Add bin scripts to bin
if [ ! -e $HOME/bin ]; then
    mkdir $HOME/bin
fi
for filepath in $HOME/.configs/bin/*
do
    filename=$(basename $filepath)
    destname=$(basename $filepath .sh)
    chmod 770 $HOME/.configs/bin/$filename
    if [[ ! (-L $HOME/bin/$destname && $(readlink $HOME/bin/$destname) == $HOME/.configs/bin/$filename) ]]; then
        ln -s $HOME/.configs/bin/$filename $HOME/bin/$destname
    fi
done

# Setup githooks
MONGODIRS=($HOME/mongo1 $HOME/mongo2 $HOME/mongo3 $HOME/mongo4)
for dir in ${MONGODIRS[@]}
do
    if [ -e $dir/.git/hooks ]; then
        for hook in $HOME/.configs/githooks/*
        do
            cp $hook $dir/.git/hooks/
        done
    fi
done