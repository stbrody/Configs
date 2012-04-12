#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: setMongoVersion.sh <version>"
    exit 1
fi

FILES=(bsondump mongo mongod mongodump mongoexport mongofiles mongoimport mongorestore mongos mongosniff mongostat mongotop)

BINPATH=$(dirname `which mongod`)
#BINPATH=/usr/local/bin
VERSION=$1
VERSIONPATH=$BINPATH/mongodb/$VERSION

if [ ! -e $VERSIONPATH ]; then
    echo "ERROR: $VERSIONPATH does not exist"
    exit 1
fi

for program in ${FILES[@]}; do
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
for program in ${FILES[@]}; do
    rm -f $BINPATH/$program
    ln -s $VERSIONPATH/$program $BINPATH/$program
done