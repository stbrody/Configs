#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: setMongoVersion.sh <version>"
    exit 1
fi

BINPATH=$(dirname `which mongod`)
#BINPATH=/usr/local/bin
VERSION=$1
VERSIONPATH=$BINPATH/mongodb/$VERSION
FILES=$VERSIONPATH/*

if [ ! -e $VERSIONPATH ]; then
    echo "ERROR: $VERSIONPATH does not exist"
    exit 1
fi

for programPath in ${FILES[@]}; do
    program=$(basename $programPath)
    if [ ! -e $VERSIONPATH/$program ]; then
        echo "ERROR: $VERSIONPATH/$program does not exist"
        exit 1
    fi
    if [ ! -e $BINPATH/$program ]; then
        continue
    fi
    if [ ! -L $BINPATH/$program ]; then
        echo "ERROR: $BINPATH/$program isn't a symlink"
        exit 1
    fi
done

# Error checking is done, start rewriting symlinks
for programPath in ${FILES[@]}; do
    program=$(basename $programPath)
    echo "Using $VERSIONPATH/$program"
    sudo rm -f $BINPATH/$program
    sudo ln -s $VERSIONPATH/$program $BINPATH/$program
done