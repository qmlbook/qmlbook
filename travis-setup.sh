#/bin/bash

if [ "$CORRECT_TRAVIS_BRANCH" != "" ]
then
    echo "Travis corrected branch $CORRECT_TRAVIS_BRANCH"
    BRANCH="$CORRECT_TRAVIS_BRANCH"
else
    echo "Not on travis - taking branch from git"
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

[ "$BRANCH" == "travis" ] && BRANCH="master" # for debug purposes

IS_DEPLOYABLE="N"
MOVE_TO=""

if [ $(expr "$BRANCH" : '^rel_.*$') -gt 0 ]
then
    RELEASE_VERSION=$(expr "$BRANCH" : '^rel_\(.*\)$')
    IS_DEPLOYABLE="Y"
    MOVE_TO="$RELEASE_VERSION"
elif [ "$BRANCH" == "master" ]
then
    RELEASE_VERSION="master"
    IS_DEPLOYABLE="Y"
else
    RELEASE_VERSION="devbranch-$BRANCH"
    IS_DEPLOYABLE="N"
fi

echo "Release version: $RELEASE_VERSION"
echo "Is deployable?: $IS_DEPLOYABLE"
if [ "$MOVE_TO" == "" ]
then
    echo "Move to: do not move"
else
    echo "Move to: $MOVE_TO"
fi

export RELEASE_VERSION
export IS_DEPLOYABLE
export MOVE_TO
