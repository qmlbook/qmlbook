=====================
Qt Quick Controls 2.0
=====================

.. sectionauthor:: `e8johan <https://github.com/e8johan>`_

.. github:: ch105

.. note::

    Last Build: |today|

    The source code for this chapter can be found in the `assets folder <../../assets>`_.

This chapter introduces how to use the Qt Quick Controls 2.0 to create a user interface built from standard components such as buttons, labels, sliders and so on. We will look at how various styles can be used to move user interfaces between platforms before diving into custom styling.
    
Introduction to Controls
========================

- What controls exist
- How do the styles look
- How to use them on desktop
- How to use them on devices
- Mention that they can be styled
- Mention difference to qt quick controls
- Mention relationships to other modules (templates, calendar, etc)

An Image Viewer
===============

- Example program - a simple image viewer
- Implemenation for desktop
    - main window
    - file dialog
    - menu
    - toolbar
    - make the image scrollable / zoomable
- Implementation for mobile
    - what concepts translate 1:1, what has to be changed
- How to work with file selectors for a single code base

Common Patterns
===============

- Document Windows (one window per document instance)
- Dialogs (and layouts)
- Nested screens with stack view
- Side-by-side screens with page view

Controls in Depth
=================

- Enumerate what elements exist (in groups)
- Enumerate what dialogs exist (in groups)
