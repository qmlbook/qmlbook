=====================
Qt Quick Controls 2.0
=====================

.. sectionauthor:: `e8johan <https://github.com/e8johan>`_

.. github:: ch105

.. note::

    Last Build: |today|

    The source code for this chapter can be found in the `assets folder <../../assets>`_.

This chapter introduces how to use Qt Quick Controls 2 to create a user interface built from standard components such as buttons, labels, sliders and so on. We will look at how various styles can be used to move user interfaces between platforms before diving into custom styling.
    
Introduction to Controls
========================

Using Qt Quick from scratch gives you primited graphical and interaction elements from which you can build your user interfaces. Using Qt Quick Controls 2 you start from a slightly more structured set of controls to build from. The controls range from simple text labels and buttons to more complex ones such as sliders and dials. These element are handy if you want to create a user interface based on classic interaction patterns as they provide a foundation to stand on.

The Qt Quick Controls 2 comes with a number of styles out of the box that are shown in the table below. The *Default* style is a basic flat style. The *Universal* style is based on the Microsoft Universal Design Guidelines, while *Material* is based on Google's Material Design Guidelines, and the *Fusion* style is a desktop oriented style. 

Some of the styles can be tweaked by tweaking the used palette. The *Imagine* is a style based on image assets, this allows a graphical designer to create a new style without writing any code at all, not even for palette colour codes.

========= =====================================
Style     Example
========= =====================================
Default   .. image:: assets/style-default.png
Universal .. image:: assets/style-universal.png
Material  .. image:: assets/style-material.png
Fusion    .. image:: assets/style-fusion.png
Imagine   .. image:: assets/style-imagine.png
========= =====================================

.. todo:: Pick a better UI to grab the example screenshot from.

The Qt Quick Controls 2 is available from the ``QtQuick.Controls`` import module. In this module you will find the basic controls such as buttons, labels, checkboxes, sliders and so on. In addition to these controls, the following modules are also of interest:

.. list-table::
    :widths: 20 80
    :header-rows: 1

    *   - Module
        - Description
    *   - ``QtQuick.Controls``
        - The basic controls.
    *   - ``QtQuick.Layouts``
        - Layout elements for supporting resizable user interfaces.
    *   - ``QtQuick.Dialogs``
        - Provides standard dialogs for showing messages, picking files, picking colours, and picking fonts, as well as the base for custom dialogs.
    *   - ``QtQuick.Controls.Universal``
        - Universal style theming support.
    *   - ``QtQuick.Controls.Material``
        - Material style theming support.
    *   - ``Qt.labs.calendar``
        - Controls for supporting date picking and other calendar related interactions.
    *   - ``Qt.labs.platform``
        - Support for platform native dialogs for common tasks such as picking files, colours, etc, as well as system tray icons and standard paths.

Notice that the ``Qt.labs`` modules are experimental, meaning that their APIs can have breaking changes between Qt versions.

An Image Viewer
===============

Let's look at a larger example of how Qt Quick Controls 2 is used. For this, we will create a simple image viewer.

First, we create it for desktop using the Fusion style, then we will refactor it for a mobile experience before having a look at the final code base.

The Desktop Version
-------------------

The desktop version is based around a classic application window with a menu bar, a tool bar and a document area. The application can be seen in action below.

.. figure:: assets/viewer-window.png

    The image viewer main window.

We use the Qt Creator project template for an empty Qt Quick application as a starting point. However, we replace the default ``Window`` element from the template with a ``ApplicationWindow`` from the ``QtQuick.Controls`` module. The code below shows ``main.qml`` where the window itself is created and setup with a default size and title.

.. literalinclude:: src/imageviewer/main.qml
    :lines: 1-6, 10-13, 83-
    
The ``ApplicationWindow`` consists of four main areas as shown below. The menu bar, tool bar and status bar are usually populated by instances of ``MenuBar``, ``ToolBar`` and ``StatusBar`` controls respectively, while the contents area is where the children of the window goes. Notice that the image viewer application does not feature a status bar, that is why it is missing from the code show here, as well as from the figure above.

.. figure:: assets/applicationwindow-areas.png

    The main areas of the ``ApplicationWindow``
    
As we are targetting desktop, we enforce the use of the *Fusion* style. This can be done via environment variables, command line arguments, or programmatically in the C++ code. We do it the latter way by adding the following line to the ``main.cpp``::

    QQuickStyle::setStyle("Fusion");
    
We then start building the user interface in ``main.qml`` by adding an ``Image`` element as the contents. This element will hold the images when the user opens them, so for now it is just a place holder. The ``background`` property is used to provide an element to the window to place behind the contents. This will be shown when there is no image loaded, and as borders around the image if the aspect ratio down not let it fill the contents area of the window.

.. literalinclude:: src/imageviewer/main.qml
    :lines: 6-9, 48-58, 83-
    
We then continue by adding the ``ToolBar``. This is done using the ``toolBar`` property of the window. Inside the tool bar we add a ``RowLayout`` from the ``QtQuick.Layouts`` module. Inside the layout we place a ``ToolButton`` and a *spacer* element. A spacer element is an element used to fill space in the layout, ensuring that the toolbar fills the width of the window.

The ``ToolButton`` has a couple of interesting properties. The ``text`` is straight forward. However, the ``icon.name`` is taken from the `freedesktop.org Icon Naming Specification <https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html>`_. In that document, a list of standard icons are listed by name. By refering to such a name, Qt will pick out the correct icon from the current desktop theme.

In the ``onClicked`` signal handler of the ``ToolButton`` is the final piece of code. It calls the ``open`` method on the ``fileOpenDialog`` element.

.. literalinclude:: src/imageviewer/main.qml
    :lines: 6-9, 34-46, 83-

The ``fileOpenDialog`` element is a ``FileDialog`` control from the ``QtQuick.Dialogs`` module. The file dialog can be used to open or save files, as well as picking directories.

In the code we start by assigning a ``title``. Then we set the starting folder using the ``shortcut`` property. The ``shortcut`` property holds links to common folders such as the user's home, documents, and such. After that we set a name filter that controls what files the user can see and pick using the dialog.

Finally, we reach the ``onAccepted`` signal handler where the ``Image`` element that holds the window contents is set to show the the selected file. There is an ``onRejected`` signal as well, but we do not need to handle it in the image viewer application.
    
.. literalinclude:: src/imageviewer/main.qml
    :lines: 6-9, 60-70, 83-

We then continue with the ``MenuBar``. To create a menu, one puts ``Menu`` elements inside the menu bar, and then populate each ``Menu`` with ``MenuItem`` elements.

In the code below, we create two menus, *File* and *Help*. Under *File*, we place *Open* using the same icon and action as the tool button in the tool bar. Under *Help* you find *About* which triggers a call to the ``open`` method of the ``aboutDialog`` element.
    
.. literalinclude:: src/imageviewer/main.qml
    :lines: 6-9, 15-32, 83-

The ``aboutDialog`` element is based on the ``Dialog`` control, which is the base for custom dialogs. The dialog we are about to create is shown in the figure below.

.. figure:: assets/viewer-about.png

    The about dialog.

The code for the ``aboutDialog`` can be split into three parts. First, we setup the dialog window with a title. Then we provide some contents for the dialog -- in this case, a ``Label`` control. Finally, we opt to use a standard *Ok* button to close the dialog.
    
.. literalinclude:: src/imageviewer/main.qml
    :lines: 6-9, 72-

    

- More desktop
    - Qt.labs.platform for a native file dialog
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
