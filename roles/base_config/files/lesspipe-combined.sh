#!/bin/bash

result=$(/usr/bin/lesspipe "$1")

if [[ -n "$result" ]]
then
    echo "$result"
else
    /usr/share/source-highlight/src-hilite-lesspipe.sh "$1"
fi
