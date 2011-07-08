#!/bin/bash

FILES=(.bash_aliases .bashrc .emacs.d .environment .git-completion.bash .gitconfig .profile .screenrc )
FILES=(.bash_aliases .bashrc .emacs.d .environment .git-completion.bash .gitconfig .gitignore .purple .screenrc )

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


