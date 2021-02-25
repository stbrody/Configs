#!/bin/bash

# Set up buttons on Evoluent sideways mouse
if xinput list | grep -q Evoluent ; then
    idNum=$(xinput list | grep Evoluent|sed 's/.*id=\([0-9]*\).*/\1/')
    xinput set-button-map $idNum 1 3 2 4 5 6 7 2 2
fi

# Set up buttons on MX Vertical mouse
if xinput list | grep -q "MX Vertical Mouse" ; then
    idNum=$(xinput list | grep "MX Vertical Mouse"|sed 's/.*id=\([0-9]*\).*/\1/')
    xinput set-button-map $idNum 1 2 3 4 5 6 7 2 2
fi
