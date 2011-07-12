#!/bin/bash

FILES=(.bash_aliases .bashrc .emacs.d .environment .git-completion.bash .gitconfig .globalgitignore .screenrc )

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


if [ ! -e $HOME/bin ]; then
    mkdir $HOME/bin
fi
if [[ ! (-L $HOME/bin/em && $(readlink $HOME/bin/em) == $HOME/.configs/em.sh) ]]; then
    ln -s $HOME/.configs/em.sh $HOME/bin/em
fi