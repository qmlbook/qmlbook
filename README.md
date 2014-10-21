Qt5-Cadaques Project
====================

This is the source code for the QML book contents. It is licensed under the Creative Commons Attribution-Non Commercial-Share Alike 4.0 license. We hope you enjoy it and we hope it helps you to learn Qt5.

The code examples are licensed under the BSD license. 

* Book License: http://creativecommons.org/licenses/by-nc/4.0/
* Source Code Examples License: http://en.wikipedia.org/wiki/BSD_licenses

Dependencies
============

* git (http://git-scm.com/) - scm tool
* sphinx (http://sphinx.pocoo.org/) - book engine
* graphviz (http://www.graphviz.org/) - diagram tool
* shorty (https://github.com/qmlbook/shorty) - QML screenshot tool

Building
========

Simply use the `Makefile` provided. I supports a number of targets. We regularly build `html`, `singlehtml` and `latexpdf`, so these aught to work out of the box. The resulting files will end up in the `_build` directory.

Screenshots
===========

Screenshots are used by the `screenshots.qml` files located inside each chapter directory. This relies on the `shorty` utility . Simply run `make-screenshots.sh` to automatically invoke `shorty` on all `screenshots.qml` files in the source tree.

Contributions
=============

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

* `ch06/src/delegates/images/earth.jpeg`
    - Image credit: NASA/JPL
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA00232
* `ch06/src/delegates/images/jupiter.jpeg`
    - Image credit: NASA/Freddy Willems, Amateur Astronomer
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA14411
* `ch06/src/delegates/images/mars.jpeg`
    - Image credit: NASA/JPL-Caltech
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA14293
* `ch06/src/delegates/images/mercury.jpeg`
    - Image credit: NASA/Johns Hopkins University Applied Physics
      Laboratory/Carnegie Institution of Washington
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA14551
* `ch06/src/delegates/images/venus.jpeg`
    - Image credit: NASA/JPL
    - Source: http://photojournal.jpl.nasa.gov/catalog/PIA00072
* `ch10/src/sound-effects/swosh.wav`
    - License: CC0
    - Source: http://www.freesound.org/people/qubodup/sounds/60026/
* `ch10/src/sound-effects/beep.wav`
    - License: CC0
    - Source:  http://www.freesound.org/people/reecord2/sounds/96063/
