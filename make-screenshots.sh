#!/bin/bash

set -e

SCREENSHOTS=$(find -name screenshots.qml)

for SS in $SCREENSHOTS
do
    SSD=$(dirname $SS)
    pushd $SSD > /dev/null
    shorty screenshots.qml
    popd > /dev/null
done
