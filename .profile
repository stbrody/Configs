# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set up buttons on Evoluent sideways mouse
if xinput list | grep -q Evoluent ; then
    idNum=$(xinput list | grep Evoluent|sed 's/.*id=\([0-9]*\).*/\1/')
    xinput set-button-map $idNum 1 3 2 4 5 6 7 2 2
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
