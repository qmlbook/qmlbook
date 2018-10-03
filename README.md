QmlBook Project
====================

[![Join the chat at https://gitter.im/qmlbook/qmlbook](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/qmlbook/qmlbook?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![Build Status](https://travis-ci.org/qmlbook/qmlbook.svg?branch=master)](https://travis-ci.org/qmlbook/qmlbook)

This is the source code for the QML book contents (http://qmlbook.org). It is licensed under the Creative Commons Attribution-Non Commercial-Share Alike 4.0 license. We hope you enjoy it and we hope it helps you to learn Qt5.

The code examples are licensed under the BSD license. 

* Book License: http://creativecommons.org/licenses/by-nc/4.0/
* Source Code Examples License: http://en.wikipedia.org/wiki/BSD_licenses

Dependencies
============

* git (http://git-scm.com/) - scm tool
* sphinx (http://sphinx.pocoo.org/) - book engine
    * sphinx-bootstrap-theme (https://github.com/ryan-roemer/sphinx-bootstrap-theme) - bootstrap HTML theme
* graphviz (http://www.graphviz.org/) - diagram tool
* shorty (https://github.com/qmlbook/shorty) - QML screenshot tool

Setup
=====

Ideally you use a python virtual environment and install the dependencies their inside.

    cd qmlbook
    virtualenv -p python3 venv
    source venv/bin/activate

This gives you a clean python3 setup. Now you need to install the dependencies:
    
    source venv/bin/activate
    pip install -r requirements.txt

This will install all listed packages from the requirements document.

For rebuilding the documentation we also use a screen shot tool called shorty. It takes a screenshot from a running Qt application. To build it please clone the repo and build the tool with a decent Qt version.

    git clone git@github.com:qmlbook/shorty.git
    cd shorty
    mkdir build && cd build
    qmake .. && make

Make sure shorty is on your search path, when 

Building
========

Simply use the `Makefile` provided. It supports a number of targets. We regularly build `html`, `singlehtml` and `latexpdf`, so these aught to work out of the box. The resulting files will end up in the `_build` directory.

Screenshots
===========

Screenshots are used by the `screenshots.qml` files located inside each chapter directory. This relies on the `shorty` utility . Simply run `make-screenshots.sh` to automatically invoke `shorty` on all `screenshots.qml` files in the source tree.

Contributions
=============

We greatly appreciate any contributions to this project. Feel free to submit pull requests with fixes or additional contents. When contributing, please add your name to the list of contributors in the `pages/contributors.rst` file. Also, if contributing a chapter, add your self as the `sectionauthor`.

We only accept contributions under a CLA, see `CONTRIBUTING.md`. This is because we, the original authors, want to ensure that we say yes if approached by someone willing to turn this material into a book made from dead trees.

Licensing
=========

In general, the text of this book is available under a Creative Commons 
Attribution-NonCommercial-ShareAlike 4.0. Please refer to `LICENSE.text` for
the actual legaleese wording of the license. This applies to:

* All `rst` files.
* All illustrations appearing in the text.

The examples assoiated with the book are made available under a three clause
BSD license, see `LICENSE.code` for the actual license text. This is to make it
possible for readers to take inspiration from, or even copy and paste from the
examples without any fear of licensing issues. This applies to:

* All example source code, i.e. `qml`-files and `js`-files used in examples.
* Graphics used in the examples.

Exceptions
----------

This section lists material that does not fall under the general licensing
rules described above. This list is explicit and overrides any other licensing
information.

* `modelview/src/delegates/images/earth.jpeg`
    - Image credit: NASA/JPL
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA00232
* `modelview/src/delegates/images/jupiter.jpeg`
    - Image credit: NASA/Freddy Willems, Amateur Astronomer
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA14411
* `modelview/src/delegates/images/mars.jpeg`
    - Image credit: NASA/JPL-Caltech
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA14293
* `modelview/src/delegates/images/mercury.jpeg`
    - Image credit: NASA/Johns Hopkins University Applied Physics
      Laboratory/Carnegie Institution of Washington
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA14551
* `modelview/src/delegates/images/venus.jpeg`
    - Image credit: NASA/JPL
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA00072
* `multimedia/src/sound-effects/swosh.wav`
    - License: CC0
    - Source: http://www.freesound.org/people/qubodup/sounds/60026/
* `multimedia/src/sound-effects/beep.wav`
    - License: CC0
    - Source:  http://www.freesound.org/people/reecord2/sounds/96063/
* `controls/src/imageviewer-mobile/images/baseline-menu-24px.svg`
    - License: Apache-2.0
    - Source: https://material.io/tools/icons/?icon=menu&style=baseline
* `controls/src/imageviewer-all/images/baseline-menu-24px.svg`
    - License: Apache-2.0
    - Source: https://material.io/tools/icons/?icon=menu&style=baseline
