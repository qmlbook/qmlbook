===================
Qt Quick Controls 2
===================

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

.. literalinclude:: src/imageviewer-desktop/main.qml
    :lines: 1-6, 10-13, 83-
    
The ``ApplicationWindow`` consists of four main areas as shown below. The menu bar, tool bar and status bar are usually populated by instances of ``MenuBar``, ``ToolBar`` and ``StatusBar`` controls respectively, while the contents area is where the children of the window goes. Notice that the image viewer application does not feature a status bar, that is why it is missing from the code show here, as well as from the figure above.

.. figure:: assets/applicationwindow-areas.png

    The main areas of the ``ApplicationWindow``
    
As we are targetting desktop, we enforce the use of the *Fusion* style. This can be done via environment variables, command line arguments, or programmatically in the C++ code. We do it the latter way by adding the following line to the ``main.cpp``::

    QQuickStyle::setStyle("Fusion");
    
We then start building the user interface in ``main.qml`` by adding an ``Image`` element as the contents. This element will hold the images when the user opens them, so for now it is just a place holder. The ``background`` property is used to provide an element to the window to place behind the contents. This will be shown when there is no image loaded, and as borders around the image if the aspect ratio down not let it fill the contents area of the window.

.. literalinclude:: src/imageviewer-desktop/main.qml
    :lines: 6-9, 48-58, 83-
    
We then continue by adding the ``ToolBar``. This is done using the ``toolBar`` property of the window. Inside the tool bar we add a ``RowLayout`` from the ``QtQuick.Layouts`` module. Inside the layout we place a ``ToolButton`` and a *spacer* element. A spacer element is an element used to fill space in the layout, ensuring that the toolbar fills the width of the window.

The ``ToolButton`` has a couple of interesting properties. The ``text`` is straight forward. However, the ``icon.name`` is taken from the `freedesktop.org Icon Naming Specification <https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html>`_. In that document, a list of standard icons are listed by name. By refering to such a name, Qt will pick out the correct icon from the current desktop theme.

In the ``onClicked`` signal handler of the ``ToolButton`` is the final piece of code. It calls the ``open`` method on the ``fileOpenDialog`` element.

.. literalinclude:: src/imageviewer-desktop/main.qml
    :lines: 6-9, 34-46, 83-

The ``fileOpenDialog`` element is a ``FileDialog`` control from the ``QtQuick.Dialogs`` module. The file dialog can be used to open or save files, as well as picking directories.

In the code we start by assigning a ``title``. Then we set the starting folder using the ``shortcut`` property. The ``shortcut`` property holds links to common folders such as the user's home, documents, and such. After that we set a name filter that controls what files the user can see and pick using the dialog.

Finally, we reach the ``onAccepted`` signal handler where the ``Image`` element that holds the window contents is set to show the the selected file. There is an ``onRejected`` signal as well, but we do not need to handle it in the image viewer application.
    
.. literalinclude:: src/imageviewer-desktop/main.qml
    :lines: 6-9, 60-70, 83-

We then continue with the ``MenuBar``. To create a menu, one puts ``Menu`` elements inside the menu bar, and then populate each ``Menu`` with ``MenuItem`` elements.

In the code below, we create two menus, *File* and *Help*. Under *File*, we place *Open* using the same icon and action as the tool button in the tool bar. Under *Help* you find *About* which triggers a call to the ``open`` method of the ``aboutDialog`` element. 

Notice that the ampersands ("&") in the ``title`` property of the ``Menu`` and the ``text`` property of the ``MenuItem`` turns the following character into a keyboard shortcut, e.g. you reach the file menu by pressing *Alt+F*, followed by *Alt+O* to trigger the open item.
    
.. literalinclude:: src/imageviewer-desktop/main.qml
    :lines: 6-9, 15-32, 83-

The ``aboutDialog`` element is based on the ``Dialog`` control, which is the base for custom dialogs. The dialog we are about to create is shown in the figure below.

.. figure:: assets/viewer-about.png

    The about dialog.

The code for the ``aboutDialog`` can be split into three parts. First, we setup the dialog window with a title. Then we provide some contents for the dialog -- in this case, a ``Label`` control. Finally, we opt to use a standard *Ok* button to close the dialog.
    
.. literalinclude:: src/imageviewer-desktop/main.qml
    :lines: 6-9, 72-
    
The end result of all this is an, albeit simple, desktop application for viewing images.

Moving to Mobile
----------------

There are a number of differences in how a user interface is expected to look an behave on a mobile device compared to a desktop application. The biggest difference for our application is how the actions are accessed. Instead of a menu bar and a tool bar, we will use a drawer from which the user can pick the actions. The drawer can swiped in from the side, but we also offer a hamburger button in the header. The resulting application with the drawer open can be seen below.

.. figure:: assets/viewer-mobile-drawer.png

    The image viewer with a drawer menu.
    
First of all, we need to change the style that is set in ``main.cpp`` from *Fusion* to *Material*::

    QQuickStyle::setStyle("Material");

Then we start adapting the user interface. We start by replacing the menu with a drawer. In the code below, the ``Drawer`` component is added as a child to the ``ApplicationWindow``. Inside the drawer, we put a ``ListView`` containing ``ItemDelegate`` instances. It also contains a ``ScrollIndicator`` used to show what part of a long list that is shown. As our list only consists of two items, this is not visible in this example.

The drawer ``ListView`` is populated from a ``ListModel`` where each ``ListItem`` corresponds to a menu item. Each time an item is clicked, in the ``onClicked`` method, the ``triggered`` method of the corresponding ``ListItem`` is called. This way, we can use a single delegate to trigger different actions.
    
.. literalinclude:: src/imageviewer-mobile/main.qml
    :lines: 7-12, 18-52, 114-

The next change is the ``header`` in the ``ApplicationWindow``. Instead of a desktop style toolbar, we add a button to open the drawer and the title of our application. 
    
.. figure:: assets/viewer-mobile.png

    The image viewer with the mobile header.
    
The ``ToolBar`` contains a ``RowLayout`` with a set of elements.
    
The ``ToolButton`` control opens the drawer. The corresponding close call can be found in the ``ListView`` delegate. When an item has been selected the drawer is closed. The icon used for the ``ToolButton`` comes from the `Material Design Icons page <https://material.io/tools/icons/?style=baseline>`_.

The ``Item`` element inside the ``RowLayout`` in the ``ToolBar`` is used to center the ``titleLabel``. By ensuring that its ``width`` is the same as the width of the ``ToolButton``, the text will be centered.
    
.. literalinclude:: src/imageviewer-mobile/main.qml
    :lines: 7-10, 54, 56-77, 114-

Finally we make the background of the toolbar pretty --- or at least orange. To do this, we alter the ``Material.background`` attached property. This comes from the ``QtQuick.Controls.Material 2.1`` module and only affects the Material style.
    
.. literalinclude:: src/imageviewer-mobile/main.qml
    :lines: 5-10, 54-55, 114-
    
With these few changes we have converted our desktop image viewer to a mobile friendly version.

A Shared Codebase
-----------------

In the past two sections we have looked at an image viewer developed for desktop use and then adapted it to mobile.

Looking at the code base, much of the code is still shared. The parts that are shared are mostly associated with the document of the application, i.e. the image. The changes has affected individual interaction patterns of desktop and mobile respectively. Naturally, we would want to unify these code bases. QML supports this through the use of *file selectors*.

A file selector lets us replace individual files based on which selectors are active. The Qt documentation maintains a list of selectors in the documentation for the ``QFileSelector`` class (`link <https://doc.qt.io/qt-5/qfileselector.html>`_). In our case we will make the desktop version the default and replace selected files when the *android* selector is encountered. During the development you can set the environment variable ``QT_FILE_SELECTORS`` to ``android`` to simulate this.

.. note::

    The file selector works by replacing files with an alternative when a *selector* is present.
    
    By creating a directory named ``+selector``, where ``selector`` represents the name of a selector, in parallel to the files that you want to replace, you can then place files with the same name as the file you want to replace inside the directory. When the selector is present, the file in the directory will be picked instead of the original file.
    
    The selectors are based on the platform, e.g. android, ios, osx, linux, qnx, and so on. They can also include the name of the Linux distribution used (if identified), e.g. debian, ubuntu, fedora. Finally, they also include the locale, e.g. en_US, sv_SE, etc.
    
    It is also possible to add your own, custom, selectors.

The first step to do this change is to isolate the shared code. We do this by creating the ``ImageViewerWindow`` class which will be used as the ``ApplicationWindow`` for both our programs. This will consist of the dialogs, the ``Image`` element and the background. In order to make the open methods of the dialogs available to the platform specific code, we need to expose them through the functions ``openFileDialog`` and ``openAboutDialog``.

.. literalinclude:: src/imageviewer-all/ImageViewerWindow.qml
    :lines: 1-5, 9-31, 40-46, 55, 59
    
Next, we create a new ``main.qml`` for our default style *Fusion*, i.e. the desktop version of the user interface.

Here, we base the user interface around the ``ImageViewerWindow`` instead of the ``ApplicationWindow``. Then we add the platform specific parts to it, e.g. the ``MenuBar`` and ``ToolBar``. The only changes to these is that the calls to open the respective dialogs are made to the new functions instead of directly to the dialog controls.
    
.. literalinclude:: src/imageviewer-all/main.qml
    :lines: 1-5, 9-45, 49

Next, we have to create a mobile specific ``main.qml``. This will be based around the *Material* theme. Here, we keep the ``Drawer`` and the mobile specific toolbar. Again, the only change is how the dialogs are opened.

.. literalinclude:: src/imageviewer-all/+android/main.qml
    :lines: 1-6, 10-19, 23-26, 41-53, 55-61, 84, 88
    
The two ``main.qml`` files are placed in the file system as shown below. This lets the file selector that the QML engine automatically creates pick the right file. By default, the *Fusion* ``main.qml`` is loaded, unless the ``android`` selector is present. Then the *Material* ``main.qml`` is loaded instead.

.. digraph:: selector_files

    "Project Root" -> "main.qml\n(Fusion)"
    "Project Root" -> "+android"
    "+android" -> "main.qml\n(Material)"
    
Until now the style has been set in in ``main.cpp``. We could continue doing this and use ``#ifdef`` expressions to set different styles for different platform. Instead we will use the file selector mechanism again and set the style using a configuration file. Below, you can see the file for the *Material* style, but the *Fusion* file is equally simple.

.. literalinclude:: src/imageviewer-all/+android/qtquickcontrols2.conf
    :language: ini

These changes has given us a joined codebase where all the document code is shared and only the differences in user interaction patterns differ. There are different ways to do this, e.g. keeping the document in a specific component that is included in the platform specific interfaces, or as in this example, by creating a common base that is extended by each platform. The best approach is best determined when you know how your specific code base looks and can decide how to separate the common from the unique.

Native Dialogs
--------------

When using the image viewer you will notice that it uses a non-standard file selector dialog. This makes it look out of place.

The ``Qt.labs.platform`` module can help us solve this. It provides QML bindings to native dialogs such as the file selector, font selector and colour selector. It also provides APIs to create system tray icons, as well as system global menus that sits on top of the screen (e.g. as in OS X). The cost of this is a dependency on the ``QtWidgets`` module.

In order to integrate a native file dialog into the image viewer, we need to import the ``Qt.labs.platform`` module. As this module has name clashes with the ``QtQuick.Dialogs`` module we import it as ``Native``. We can then create a ``Native.FileDialog``.

In the actual file dialog element, we have to change how the ``folder`` property is set, and ensure that the ``onAccepted`` handler uses the ``file`` property instead of the ``fileUrl`` property. Apart from these details, the usage is identical to the ``FileDialog`` from ``QtQuick.Dialogs``.

.. literalinclude:: src/imageviewer-native/main.qml
    :lines: 1-10, 61-71, 84-

In addition to the QML changes, we also need to alter the project file of the image viewer to include the ``widgets`` module.

.. literalinclude:: src/imageviewer-native/imageviewer-native.pro
    :lines: 1

And we need to update ``main.qml`` to instantiate a ``QApplication`` object instead of a ``QGuiApplication`` object. This is because the ``QGuiApplication`` class contains the minimal environment needed for a graphical application, while ``QApplication`` extends ``QGuiApplication`` with features needed to support ``QtWidgets``.
    
.. literalinclude:: src/imageviewer-native/main.cpp
    :language: cpp
    :lines: 1, 4-8, 11-14, 22
    
With these changes, the image viewer will now use native dialogs on most platforms. The platforms supported are iOS, Linux (with a GTK+ platform theme), macOS, Windows and WinRT. For Android, it will use a default Qt dialog provided by the ``QtWidgets`` module.
    
Common Patterns
===============

There a number of common user interface patterns that can be implemented using Qt Quick Controls 2. In this section, we try to demonstrate how some of the more common ones can be built.

Nested Screens
--------------

For this example we will create a tree of pages that can be reached from the previous level of screens. The structure is pictured below.

.. digraph:: nested_screens

    "Home" -> "Profile"
    "Profile" -> "Edit Profile"
    "Home" -> "About"

The key component in this type of user interface is the ``StackView``. It allows us to place pages on a stack which then can be poped when the user wants to go back. In the example here, we will show how this can be implemented.

The initial home screen of the application is shown in the figure below.

.. figure:: assets/interface-stack-home.png

    The home screen page.

The application start in ``main.qml`` where we have an ``ApplicationWindow`` containing a ``ToolBar``, a ``Drawer``, a ``StackView`` and a home page element, ``Home``. We will look into each of the components below.

.. literalinclude:: src/interface-stack/main.qml
    :lines: 1-4, 10-16, 36-41, 66-72, 84

The home page, ``Home.qml`` consists of a ``Page``, which is an control element that support headers and footers. In this example we simply center a ``Label`` with the text *Home Screen* on the page.

.. literalinclude:: src/interface-stack/Home.qml

Returning back to the ``main.qml``, we now look at the drawer part. This is where the navigation to the pages begin. The active parts of the user interface is the ``ÌtemDelegate`` items. In the ``onClicked`` handler, the next page is pushed onto the ``stackView``.

As shown in the code below, it possible to push either a ``Component`` or a reference to a specific QML file. Either way results in that a new instance is created and is pushed onto the stack.

.. literalinclude:: src/interface-stack/main.qml
    :lines: 4, 10-12, 38, 42-66, 73-

The other half of the puzzle is the toolbar. The idea is that a back button is shown when the ``stackView`` contains more than one page, otherwise a menu button is shown. The logic for this can be seen on the ``text`` property where the ``"\u..."`` strings represents the unicode symbols that we need.

In the ``onClicked`` handler, we can see that when there is more than one page on the stack, the stack is poped, i.e. the top page is removed. If the stack contains only one item, i.e. the home screen, the drawer is opened.

Below the ``ToolBar``, you find a ``Label``. This element shows the title of each page in the center of the header.
    
.. literalinclude:: src/interface-stack/main.qml
    :lines: 4, 10-12, 13, 17-36, 81-

Now we've seen how to reach the *About* and *Profile* pages, but we also want to make it possible to reach the *Edit Profile* page from the *Profile* page. This is done via the ``Button`` on the *Profile* page. When the button is clicked, the ``EditProfile.qml`` file is pushed onto the ``StackView``.

.. figure:: assets/interface-stack-profile.png

    The profile page with the *Edit* button.

.. literalinclude:: src/interface-stack/Profile.qml

Side by Side Screens
--------------------

For this example we create a user interface consisting of three pages that the user can shift through. The pages are shown in the diagram below. This could be the interface of a health tracking app, tracking the current state, the user's statistics and the overall statistics.

.. digraph:: side_by_side_screens

    "Current" -> "Your Statistics"
    "Your Statistics" -> "Community Statistics"
    
The illustration below shows how the *Current* page looks in the application. The title and text come from the page, while the ``PageIndicator`` (the three dots at the bottom) come from ``main.qml``. The page indicator shows the user which page that is currently active, helping when navigating.

.. figure:: assets/interface-side-by-side-current.png

    The *Current* page in the side-by-side app.

Diving into ``main.qml``, it consists of an ``ApplicationWindow`` with a ``SwipeView``. The latter is what provides the mechanics for the interface that we are building.
    
.. literalinclude:: src/interface-side-by-side/main.qml
    :lines: 1-4, 8-14, 26-29, 38-

Inside the ``SwipeView`` each of the child pages are instantiated in the order they are to appear. They are ``Current``, ``UserStats`` and ``TotalStats``.
    
.. literalinclude:: src/interface-side-by-side/main.qml
    :lines: 4-7, 14-25, 29, 38-
    
Finally the ``count`` and ``currentIndex`` properties of the ``SwipeView`` are bound to the ``PageIndicator`` element. This completes the structure around the pages.

.. literalinclude:: src/interface-side-by-side/main.qml
    :lines: 4-7, 14-15, 26-37, 41
    
Each page consists of a ``Page`` with a ``header`` consisting of a ``Label`` and some contents. For the *Current* and *User Stats* pages the contents is a simple ``Label``, but for the *Community Stats* page, a back button is included.

.. literalinclude:: src/interface-side-by-side/TotalStats.qml
    :lines: 1-12, 26

.. figure:: assets/interface-side-by-side-community.png

    The *Back* button in the side-by-side app.
    
The back button explicitly sets the ``currentIndex`` of the ``SwipeView``, returning the user directly to the *Current* page. During each transition between pages the ``SwipeView`` provides a transition, so even when explicitly changing the ``currentIndex`` the user is given a sense of direction.

.. literalinclude:: src/interface-side-by-side/TotalStats.qml
    :lines: 4, 10-    

Document Windows
----------------

.. warning:: This example is broken. The following pieces are missing:

    * There is no open dialog implemented
    * There is no way to close all windows, e.g. to exit (requires a singleton)
    * The example fails miserably on the following sequence:
        1. File -> New
        2. Close new window
        3. Opt so save changes (click Yes)
        4. The dialog fails to show and the window closes, losing all changes
        
``DocumentWindow.qml``. Document window with menu bar. Standard document operations: new, open, save, save as

Open does not use a dialog at the moment. Instead the filename is hardcoded.
        
.. literalinclude:: src/interface-document-window/DocumentWindow.qml
    :lines: 1-9, 19, 23-50, 128-
    
Bootstrapping from ``main.qml``, creating the initial ``DocumentWindow``

.. literalinclude:: src/interface-document-window/main.qml

New and Open are similar. Dynamically create a new object. Do not specify a root object for createObject, as the windows otherwise end up owned, e.g. when the first document closes, all close.

.. literalinclude:: src/interface-document-window/DocumentWindow.qml
    :lines: 5, 7-9, 52-65, 128-
    
Introduce dirty bit, filename and the save methods + save dialog. Compared to C++, the dialog is not blocking. We need to preserve state. Introduce tryingToClose.

.. literalinclude:: src/interface-document-window/DocumentWindow.qml
    :lines: 5, 7-9, 15-17, 7-9, 67-100, 128-
    
The window title is calculated from ``_fileName`` and ``isDirty``.
    
.. literalinclude:: src/interface-document-window/DocumentWindow.qml
    :lines: 5, 7-10, 128-

Closing is not accepted for dirty documents, but we show a dialog.

If the user wants to save, we set ``_tryingToClose`` and attempt to save.

If the user do not want to save, we clear ``_isDirty`` and close (leading to ``onClosing`` again)

If the user clicks cancel (or otherwise rejects the dialog, e.g. closes the window), we do nothing, already having prevented the close.

.. literalinclude:: src/interface-document-window/DocumentWindow.qml
    :lines: 5, 7-9, 102-127, 131

The Imagine Style
=================

One of the goals with Qt Quick Controls 2 is to separate the logic of a control from its appearance. For most of the styles, the implementation of the appearance consists of a mix of QML code and graphical assets. However, using the *Imagine* style, it is possible to customize the appearance of a Qt Quick Controls 2 based application using only graphical assets.

The imagine style is based on `9-patch images <https://developer.android.com/guide/topics/graphics/drawables#nine-patch>`_. This allows the images to carry information on how they are stretched and what parts are to be considered as a part of the element and what is outside, e.g. a shadow. The style declares a large number of assets that can be used to control the appearance of each element.

The details of 9-patch images, and how each control can be styled is covered in great detail in the `Imagine style documentation <https://doc.qt.io/qt-5/qtquickcontrols2-imagine.html>`_. Here, we will create a custom style to an imaginary device interface to demonstrate how the style is used.

The application consists of a custom style of the ``ApplicationWindow`` and ``Button`` controls. For the buttons, the normal case, as well as *pressed* and *checked* are handled. The demonstration application is shown below.

.. figure:: assets/style-imagine-example.png

    The custom imagine button style.

The code for this uses a ``Column`` for the clickable buttons, and a ``Grid`` for the checkable ones. The clickable buttons also stretch with the window width.
    
.. literalinclude:: src/imagine-style/main.qml
    :lines: 4-7, 13, 21-34, 42-

As we are using the *Imagine* style, all controls that we want to use needs to be styled using a graphical asset. The easiest is the background for the ``ApplicationWindow``. This is a single pixel texture defining the background colour. By naming the file ``applicationwindow-background.png`` and then pointing the style to it using the ``qtquickcontrols2.conf`` file, the file is picked up.

In the ``qtquickcontrols2.conf`` file shown below, you can see how we set the ``Style`` to ``Imagine``, and then setup a ``Path`` for the style where it can look for the assets. Finally we set some palette properties as well. The available palette properties can be found on the `palette QML Basic Type <https://doc.qt.io/qt-5/qml-palette.html#qtquickcontrols2-palette>`_ page.
    
.. literalinclude:: src/imagine-style/qtquickcontrols2.conf
    :language: ini

The assets for the ``Button`` control are ``button-background.9.png``, ``button-background-pressed.9.png`` and ``button-background-checked.9.png``. These follow the *control*-*element*-*state* pattern. The stateless file, ``button-background.9.png`` is used for all states without a specific asset. According to the `Imagine style element reference table <https://doc.qt.io/qt-5/qtquickcontrols2-imagine.html#element-reference>`_, a button can have the following states:

* disabled
* pressed
* checked
* checkable
* focused
* highlighted
* flat
* mirrored
* hovered

Which ones that are needed depends on your user interface. For instance, the hovered style is never used for touch based interfaces.

.. figure:: assets/button-background-checked-enlarged.9.png

    The ``button-background-checked.9.png`` asset enlarged.

Looking at an enlarged version of ``button-background-checked.9.png`` above you can see the 9-patch guide lines along the sides. The purple background has been added for visibility reasons. This area is actually transparent in the asset used in the example. 

The pixes along the edges of the image can be either white/transparent, black, or red. These have different meanings that we will go through one by one.

* **Black** lines along the **left** and **top** sides of the asset mark the stretchable parts of the image. This means that the rounded corners and the white marker in the example are not affected when the button is stretched.
* **Black** lines along the **right** and **bottom** sides of the asset mark the area used for the control's contents. That means what part of the button is used for text in the example.
* **Red** lines along the **right** and **bottom** sides of the asset mark *inset* areas. These areas are a part of the image, but not considered a part of the control. For the checked image above, this is used for a soft halo extending outside the button.

A demonstration of the usage of an *inset* areas is how the ``button-background.9.png`` (below) and ``button-background-checked.9.png`` (above) result in an image that seems to light up, but not move, in the example.

.. figure:: assets/button-background-enlarged.9.png

    The ``button-background.9.png`` asset enlarged.

Summary
=======

In this chapter we have looked at the Qt Quick Controls 2. They offer set of elements that provide more high level concepts than the basic QML elements. For most scenarios, you will save memory and gain performance by using the Qt Quick Controls 2, as they are based around an optimized C++ logic instead of Javascript and QML.

In the chapter we've demonstrated how different styles can be used, and how a common code base can be developed using file selectors. This way, a single code base can address multiple platforms with user interactions and visual styles.

Finally, we have looked at the Imagine style that allows you to completely customize the look of a QML application through the use of graphical assets. This way an application can be reskinned without any code change what so ever.
