The Travis Setup
================

The QmlBook currently uses travis to build and deploy on each new commit to the project.

There is some logic in this setup and this document outlines the purpose of this logic.



Branches
========

Travis is triggered on all branches. Depending on the name of the branch, the build is deployed or not.

* The `master` branch is built and deployed to the root of the gh-pages.
* Branches starting with `rel_` are build and deployed into a subdirectory named after the branch of the gh-pages.
* All other branches are built but not deployed.

An example of a `rel_` branch would be `rel_5.12`. This branch would end up under `5.12/` in the gh-pages. This way, we can build and deploy multiple parallel releases.

Branch Names and Travis
-----------------------

As Travis has its own view on how to handle branches, we have to get the branch name using Travis if we detect that we are running in that environment. Otherwise we use `git` to find the name.

More info: https://graysonkoonce.com/getting-the-current-branch-name-during-a-pull-request-in-travis-ci/

Pull-requests
-------------

The messed up branch / repo slug situation around pull requests means that we do not build pull requests due to the risk of accidentally overwriting something important. I guess a fix should go into `travis-setup.sh` if you are eager to help.



Languages
=========

We plan to support languages later on, but right now we've reverted to only supporting the original English version.

When supporting languages, they will add onother path under the branch paths as described above. E.g. `de/` and `5.12/de/`. English will stay in a path without a prefix.



Implementation
==============

The branch handling is done via `travis-setup.sh` which is _sourced_ first. It exports three environment variables:

* `RELEASE_VERSION`, used in the build.
* `IS_DEPLOYABLE`, used to to determine if the output should be deployed or not (based on the branch name).
* `MOVE_TO`, used to determine if a specific build has to be moved (again, based on the branch name).
* `DEPLOY_BRANCH`, branch to deploy to.
* `DEPLOY_SLUG`, repo slug to deploy to.

After this, Paver is used to build a release, including all assets and outputs (pdf, ePub, html, etc). This ends up in `_build/html`.

Then a `.nojekyll` file is created from the script in `.travis.yml` to prevent GitHub Pages to be smart.

Finally `travis-move.sh` is run. This script relies on the `MOVE_TO` environment variable and moves the contents of `_build/html/` to `_build/html/$MOVE_TO` if `MOVE_TO` is set.

After that, the `deploy.on.condition` in `travis.yml` evaluates if the build is deployable and acts accordingly, relying on `DEPLOY_SLUG` and `DEPLOY_BRANCH`.
