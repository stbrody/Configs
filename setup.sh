#!/bin/bash

files=(.bash_aliases .bashrc .emacs.d .environment .git-completion.bash .gitconfig .profile .screenrc)

for filename in ${files[@]}
do
    # Delete file if it exists.
    if [ -e $HOME/$filename ]
    then
        if [ -d $HOME/$filename ]
        then
            rm -i -r $HOME/$filename
        else
            rm -i $HOME/$filename
        fi
    fi
    # Symlink to files in git repo
    ln -s $HOME/.configs/$filename $HOME/$filename
done


