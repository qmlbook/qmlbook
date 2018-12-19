#/bin/bash

# Determine the branch being built
if [ "$CORRECT_TRAVIS_BRANCH" != "" ]
then
    echo "Travis corrected branch $CORRECT_TRAVIS_BRANCH"
    BRANCH="$CORRECT_TRAVIS_BRANCH"
else
    echo "Not on travis - taking branch from git"
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

# Enables hacking using a branch named travis
[ "$BRANCH" == "travis" ] && BRANCH="master" # for debug purposes

# Determine where to move contents and if it is to be deployed
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

# Ensure that we only push to qmlbook.github.io when building the official repo
if [ "$TRAVIS_REPO_SLUG" == "qmlbook/qmlbook" ]
then
    DEPLOY_BRANCH="master"
    DEPLOY_SLUG="qmlbook/qmlbook.github.io"
else
    DEPLOY_BRANCH="gh-pages"
    DEPLOY_SLUG="$TRAVIS_REPO_SLUG"
fi

# Print summary of what is attempted
echo "Release version: $RELEASE_VERSION"
echo "Is deployable?: $IS_DEPLOYABLE"
if [ "$MOVE_TO" == "" ]
then
    echo "Move to: do not move"
else
    echo "Move to: $MOVE_TO"
fi
echo "Deploy to: $DEPLOY_SLUG $DEPLOY_BRANCH"

export RELEASE_VERSION
export IS_DEPLOYABLE
export MOVE_TO
export DEPLOY_SLUG
export DEPLOY_BRANCH
