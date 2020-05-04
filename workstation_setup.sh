#!/bin/bash

FILES=(.bash_aliases .emacs.d .environment .git-completion.bash .gitconfig .globalgitignore .mongorc.js .mongorc.colors.js .profile .screenrc)

DIRECTORIES=(.ssh) # TODO: symlink files from within directories.
CONFIG_DIR="$HOME/user_home/Configs"

for filename in ${FILES[@]}
do
    src=${HOME}/${filename}
    dst="$CONFIG_DIR/$filename"

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
for filepath in $CONFIG_DIR/bin/*
do
    filename=$(basename $filepath)
    destname=$(basename $filepath .sh)
    chmod 770 $CONFIG_DIR/bin/$filename
    if [[ ! (-L $HOME/bin/$destname && $(readlink $HOME/bin/$destname) == $CONFIG_DIR/bin/$filename) ]]; then
        ln -s $CONFIG_DIR/bin/$filename $HOME/bin/$destname
    fi
done

# Setup githooks
mkdir -p $HOME/.git_template/hooks
for hook in $HOME/.configs/githooks/*
do
    cp -i $hook $HOME/.git_template/hooks/
    cp -i $hook $HOME/mongo/.git/hooks/
done

# Add my .bashrc to the workstation's bashrc
echo ". $HOME/user_home/Configs/.bashrc" >> ~/.bashrc

# Override USER_HOME for workstation
echo "export USER_HOME=\"\$HOME/user_home\"" >> ~/.bashrc
