==============
Qt Creator IDE
==============

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_

.. github:: ch03

Qt Creator is the default integrated development environment for Qt. It's written by Qt developers for Qt developers. The IDE is available on all major desktop platforms, i.e. Windows, macOS, and Linux. We have already seen customers using Qt Creator on an embedded device. Qt Creator has a lean and efficient user interface, and it really shines in making the developer productive. Qt Creator can be used to run your Qt Quick user interface, and also to compile C++ code for your host system or for another device using a cross-compiler.

.. figure:: assets/qtcreator-screenshots.png

Qt Creator is actively developed, with several new releases each year. Therefore, you should always refer to the `Qt Creator documentation <https://doc.qt.io/qtcreator/index.html>`_ online for up to date documentation on the version of Qt Creator you are using.

.. note::

    The source code of this chapter can be found in the `assets folder <../assets>`_.

The User Interface
==================

.. issues:: ch03

When starting Qt Creator, you are greeted by the *Welcome* screen. Here, you can quickly create and open projects, browse the included tutorial and example projects, read news from the online community and Qt blogs, and more. There is also the sessions list, which might be empty for you. A session is a collection of projects stored for your reference. This is really handy when you have several customers with larger projects.

On the left side is the mode selector. The mode selectors contain steps typical to a workflow:

* Welcome mode: For your orientation.
* Edit mode: Focus on the code.
* Design mode: Focus on the UI design.
* Debug mode: Retrieve information about a running application.
* Projects mode: Modify your project's run and build configuration.
* Help mode: Easily access the Qt documentation.

Below the mode selectors, you find the kit selector, and buttons to run, debug, and build the current project.

.. figure:: assets/creator-welcome.png
    :scale: 50%


Most of the time, you'll use the edit mode with the code editor in the central panel. From time to time, you'll visit the Projects mode when you need to configure your project. And then you press ``Run``. Qt Creator is smart enough to ensure your project is fully built before running it.

In the bottom you find output panes for issues, search results, output from the application and compiler, and other messages.

Registering your Kit
====================

.. issues:: ch03

When you install Qt, kits are automatically created. Kits are used to uniquely identify the combination of tools for your project build. In other words, a kit is the combination of a Qt version, compiler, device, and some other settings. When you open a project for the first time, you select the kit Qt Creator should use initially to build your project. You can then add further kits to use with the project. To create a kit, you need to have a compiler installed and a version of Qt registered with Qt Creator. You register a Qt version by specifying the path to its ``qmake`` executable. Qt Creator then queries ``qmake`` for the information it requires to correctly identify the Qt version.

From :menuselection:`Tools > Options > Kits` you can add kits and register Qt versions. You can also see which compilers are registered.

.. note::

    Check if your Qt Creator has already registered the correct Qt version, and then ensure a Kit for your combination of compiler, Qt, and device is specified. You cannot build a project without a kit.



Managing Projects
=================

.. issues:: ch03

Qt Creator manages your source code in projects. You can create a new project by selecting :menuselection:`File > New File or Project`. When you create a project, you can choose between a range of application templates, including desktop and mobile applications. These templates help you by creating a basic set of files, so you can focus on creating your application rather than writing boilerplate code. When you've chosen a template, Qt Creator opens a wizard for the template type, from a new QML project to a C++ class, or an autotest project for your unit tests. For a beginner, it may be difficult to choose the right project type. Check out the `Qt Creator documentation`_ for an in-depth description of each project type.

.. note::

    The beginning of this book uses the Qt Quick UI Prototype project type. Later, an empty project is used to describe some C++ aspects. For extending Qt Quick with a native plug-in, the *Qt Quick 2 Extension Plugin* project type is used.



Using the Editor
================

.. issues:: ch03

Upon creating a new project or opening an existing one, Qt Creator switches to edit mode. You should see an overview of your project files in the left pane, and the code editor in the center area. Double click any of the files on the left to open them in the editor. The editor provides syntax highlighting, code-completion, and quick-fixes. It also supports several commands for code refactoring.

.. figure:: assets/creator-editor.png
    :scale: 50%


Locator
=======

.. issues:: ch03

The locator is a central component inside Qt Creator. It lets you navigate quickly to specific locations in the source code or built-in help system. To open the locator, press :kbd:`Ctrl+K`.

.. figure:: assets/locator.png
    :scale: 50%

The locator pops up with a list of options in the bottom left. If you want to find a file in your current project, enter the first letter of the file name. The locator updates in real-time as you type, to reflect the search results. The locator accepts wild-cards, so search queries such as ``*main.qml`` also work. In addition, you can prefix your search to find specific content types. Before you enter text into the locator's input field, it shows a list of the various prefixes you can apply to your search.

.. figure:: assets/creator-locator.png
    :scale: 50%

Give it a try! For example, to open the help for the QML element Rectangle, open the locator and type ``? rectangle``. Notice how the locator updates the suggestions while you type, until you find the reference you are looking for.

Debugging
=========

.. issues:: ch03

Qt Creator comes with C++ and QML debugging support.

.. note::

    Hmm, I just realized I have not used debugging a lot. I hope this is a good sign. Need to ask someone to help me out here. In the meantime have a look at the `Qt Creator documentation`_.

Shortcuts
=========

.. issues:: ch03

Shortcuts are the difference between a nice-to-use editor and a professional editor. As a professional, you spend hundreds of hours in front of your application. Luckily, the developers of Qt Creator think the same, and have added literally hundreds of shortcuts to the application. Familiarizing yourself with the available shortcuts can help you optimize your work-flow.

To get you started, here are some of the default basic shortcuts (in Windows notation):

* :kbd:`Ctrl+B` - Build project
* :kbd:`Ctrl+R` - Run Project
* :kbd:`Ctrl+Tab` - Switch between open documents
* :kbd:`Ctrl+K` - Open Locator
* :kbd:`Esc` - Go back (hit several times and you are back in the editor)
* :kbd:`F2` - Follow Symbol under cursor
* :kbd:`F4` - Switch between header and source (only useful for c++ code)

See also the list of `Qt Creator shortcuts <http://doc.qt.io/qtcreator/creator-keyboard-shortcuts.html>`_ in the documentation.


.. note::

    You can customize the shortcuts from within Qt Creator using the options dialog.

    .. figure:: assets/creator-edit-shortcuts.png
        :scale: 50%
