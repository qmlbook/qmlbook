#!/bin/bash

if [ "$MOVE_TO" != "" ]
then
    echo "Moving build result to $MOVE_TO"
    pushd _build
    mkdir h2
    mv html "h2/$MOVE_TO"
    mv h2 html
else
    echo "Nothing to move"
fi
