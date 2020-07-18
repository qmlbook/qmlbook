=========
Meet Qt 5
=========

.. sectionauthor:: `jryannel@LinkedIn <https://www.linkedin.com/in/jryannel>`_

.. github:: ch01

.. tip::

    The source code of this chapter can be found in the `assets folder <../assets>`_.

This book provides you with a walkthrough of the different aspects of application development using Qt 5.12. It focuses on the new Qt Quick technology, but also provides necessary information about writing C++ back-ends and extension for Qt Quick.

This chapter provides a high-level overview of Qt 5. It shows the different application models available for developers, as well as a Qt 5 showcase application, as a sneak preview of things to come. Additionally, the chapter aims to provide a wide overview of the Qt 5 content and how to get in touch with the makers of Qt 5.


Preface
=======

.. rubric:: History

Qt 4 has evolved since 2005 and provided a solid ground for thousands of applications and even full desktop and mobile systems. The usage patterns of computer users changed in the recent years. From stationary PCs towards portable notebook and nowadays mobile computers. The classical desktop is more and more replaced with mobile touch-based always connected screens. With it, the desktop UX paradigms also change. Whereas in the past Windows UI has dominated the world we spend more time nowadays on other screens with another UI language.

Qt 4 was designed to satisfy the desktop world to have a coherent set of UI widgets available on all major platforms. The challenge for Qt users has changed today and it lies more to provide a touch-based user interface for a customer-driven user interface and to enable modern user interface on all major desktop and mobile systems. Qt 4.7 started to introduce the Qt Quick technology which allows users to create a set of user interface components from simple elements to achieve a completely new UI, driven by customer demands.

Qt 5 Focus
----------

Qt 5 is a complete refreshing of the very successful Qt 4 release. With Qt 4.8, the Qt 4 release is almost 7 years old. It's time to make an amazing toolkit even more amazing. Qt 5 is focused on the following:

* **Outstanding Graphics**: Qt Quick 2 is based on OpenGL (ES) using a scene graph implementation. The recomposed graphics stack allows a new level of graphics effects combined with an ease of use never seen before in this field.

* **Developer Productivity**: QML and JavaScript are the primary means for UI creation. The back-end will be driven by C++. The split between JavaScript and C++ allows a fast iteration for front-end developers concentrating on creating beautiful user interfaces and back-end C++ developers concentrating on stability, performance and extending the runtime.

* **Cross-platform portability**: With the consolidated Qt Platform Abstraction, it is now possible to port Qt to a wider range of platforms easier and faster. Qt 5 is structured around the concept of Qt Essentials and Add-ons, which allows OS developer to focus on the essentials modules and leads to a smaller runtime altogether.

* **Open Development**: Qt is now a truly open-governance project hosted at `qt.io <http://qt.io>`_. The development is open and community driven.



Qt 5 Introduction
=================


Qt Quick
--------

Qt Quick is the umbrella term for the user interface technology used in Qt 5. Qt Quick itself is a collection of several technologies:

* QML - Markup language for user interfaces
* JavaScript - The dynamic scripting language
* Qt C++ - The highly portable enhanced c++ library

.. figure:: assets/qt5_overview.png


Similar to HTML, QML is a markup language. It is composed of tags, called types in Qt Quick, that are enclosed in curly brackets: ``Item {}``. It was designed from the ground up for the creation of user interfaces, speed and easier reading for developers. The user interface can be enhanced further using JavaScript code. Qt Quick is easily extendable with your own native functionality using Qt C++. In short, the declarative UI is called the front-end and the native parts are called the back-end. This allows you to separate the computing intensive and native operation of your application from the user interface part.

In a typical project, the front-end is developed in QML/JavaScript. The back-end code, which interfaces with the system and does the heavy lifting, is developed using Qt C++. This allows a natural split between the more design-oriented developers and the functional developers. Typically, the back-end is tested using Qt Test, the Qt unit testing framework, and exported for the front-end developers to use.


Digesting a User Interface
---------------------------

Let's create a simple user interface using Qt Quick, which showcases some aspects of the QML language. In the end, we will have a paper windmill with rotating blades.


.. figure:: assets/scene.png
    :scale: 50%


We start with an empty document called ``main.qml``. All our QML files will have the suffix ``.qml``. As a markup language (like HTML), a QML document needs to have one and only one root type. In our case, this is the ``Image`` type with a width and height based on the background image geometry:

.. code-block:: qml

    import QtQuick 2.12

    Image {
        id: root
        source: "images/background.png"
    }

As QML doesn't restrict the choice of type for the root type, we use an ``Image`` type with the source property set to our background image as the root.


.. figure:: src/showcase/images/background.png


.. note::

    Each type has properties. For example, an image has the properties ``width`` and ``height``, each holding a count of pixels. It also has other properties, such as ``source``. Since the size of the image type is automatically derived from the image size, we don't need to set the ``width`` and ``height`` properties ourselves.

    The most standard types are located in the ``QtQuick`` module, which is made available by the import statement at the start of the ``.qml`` file.

    The ``id`` is a special and optional property that contains an identifier that can be used to reference its associated type elsewhere in the document. Important: An ``id`` property cannot be changed after it has been set, and it cannot be set during runtime. Using ``root`` as the id for the root-type is a convention used in this book to make referencing the top-most type predictable in larger QML documents.

The foreground elements, representing the pole and the pinwheel in the user interface, are included as separate images.

.. figure:: src/showcase/images/pole.png
.. figure:: src/showcase/images/pinwheel.png

We want to place the pole horizontally in the center of the background, but offset vertically towards the bottom. And we want to place the pinwheel in the middle of the background.

Although this beginners example only uses image types, as we progress you will create more sophisticated user interfaces that are composed of many different types.


.. code-block:: qml

  Image {
      id: root
      ...
      Image {
          id: pole
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: parent.bottom
          source: "images/pole.png"
      }

      Image {
          id: wheel
          anchors.centerIn: parent
          source: "images/pinwheel.png"
      }
      ...
  }



To place the pinwheel in the middle, we use a complex property called ``anchor``. Anchoring allows you to specify geometric relations between parent and sibling objects. For example, place me in the center of another type ( ``anchors.centerIn: parent`` ). There are left, right, top, bottom, centerIn, fill, verticalCenter and horizontalCenter relations on both ends. Naturally, when two or more anchors are used together, they should complement each other: it wouldn't make sense, for instance, to anchor a type's left side to the top of another type.

For the pinwheel, the anchoring only requires one simple anchor.

.. note::

    Sometimes you will want to make small adjustments, for example, to nudge a type slightly off-center. This can be done with ``anchors.horizontalCenterOffset`` or with ``anchors.verticalCenterOffset``. Similar adjustment properties are also available for all the other anchors. Refer to the documentation for a full list of anchors properties.

.. note::

    Placing an image as a child type of our root type (the ``Image``) illustrates an important concept of a declarative language. You describe the visual appearance of the user interface in the order of layers and grouping, where the topmost layer (our background image) is drawn first and the child layers are drawn on top of it in the local coordinate system of the containing type.

To make the showcase a bit more interesting, let's make the scene interactive. The idea is to rotate the wheel when the user presses the mouse somewhere in the scene.


We use the ``MouseArea`` type and make it cover the entire area of our root type.

.. code-block:: qml

    Image {
        id: root
        ...
        MouseArea {
            anchors.fill: parent
            onClicked: wheel.rotation += 90
        }
        ...
    }

The mouse area emits signals when the user clicks inside the area it covers. You can connect to this signal by overriding the ``onClicked`` function. When a signal is connected, it means that the function (or functions) it corresponds to are called whenever the signal is emitted. In this case, we say that when there's a mouse click in the mouse area, the type whose ``id`` is ``wheel`` (i.e., the pinwheel image) should rotate by +90 degrees.

.. note::

    This technique works for every signal, with the naming convention being ``on`` + ``SignalName`` in title case. Also, all properties emit a signal when their value changes. For these signals, the naming convention is:

        ``on`` + ``PropertyName`` + ``Changed``

    For example, if a ``width`` property is changed, you can observe it with ``onWidthChanged: print(width)``.

The wheel will now rotate whenever the user clicks, but the rotation takes place in one jump, rather than a fluid movement over time. We can achieve smooth movement using animation. An animation defines how a property change occurs over a period of time. To enable this, we use the ``Animation`` type's property called ``Behavior``. The ``Behavior`` specifies an animation for a defined property for every change applied to that property. In other words, whenever the property changes, the animation is run. This is only one of many ways of doing animation in QML.

.. code-block:: qml

    Image {
        id: root
        Image {
            id: wheel
            Behavior on rotation {
                NumberAnimation {
                    duration: 250
                }
            }
        }
    }

Now, whenever the wheel's rotation property changes, it will be animated using a ``NumberAnimation`` with a duration of 250 ms. So each 90-degree turn will take 250 ms, producing a nice smooth turn.

.. figure:: assets/scene2.png
    :scale: 50%

.. note:: You will not actually see the wheel blurred. This is just to indicate the rotation. (A blurred wheel is in the assets folder, in case you'd like to experiment with it.)

Now the wheel looks much better and behaves nicely, as well as providing a very brief insight into the basics of how Qt Quick programming works.

Qt Building Blocks
==================

Qt 5 consists of a large number of modules. In general, a module is a library for the developer to use. Some modules are mandatory for a Qt-enabled platform and form the set called *Qt Essentials Modules*. Many modules are optional, and form the *Qt Add-On Modules*. The majority of developers may not need to use the latter, but it's good to know about them as they provide invaluable solutions to common challenges.

Qt Modules
---------------------

The Qt Essentials modules are mandatory for any Qt-enabled platform. They offer the foundation to develop modern Qt 5 Applications using Qt Quick 2. The full list of modules is available in the `Qt documentation module list <https://doc.qt.io/qt-5/qtmodules.html>`_.

.. rubric:: Core-Essential Modules

The minimal set of Qt 5 modules to start QML programming.

.. list-table::
    :widths: 20 80
    :header-rows: 1

    *   - Module
        - Description
    *   - Qt Core
        - Core non-graphical classes used by other modules.
    *   - Qt GUI
        - Base classes for graphical user interface (GUI) components. Includes OpenGL.
    *   - Qt Multimedia
        - Classes for audio, video, radio and camera functionality.
    *   - Qt Multimedia Widgets
        - Widget-based classes for implementing multimedia functionality.
    *   - Qt Network
        - Classes to make network programming easier and more portable.
    *   - Qt QML
        - Classes for QML and JavaScript languages.
    *   - Qt Quick
        - A declarative framework for building highly dynamic applications with custom user interfaces.
    *   - Qt Quick Controls 2
        - Provides lightweight QML types for creating performant user interfaces for desktop, embedded, and mobile devices. These types employ a simple styling architecture and are very efficient.
    *   - Qt Quick Dialogs
        - Types for creating and interacting with system dialogs from a Qt Quick application.
    *   - Qt Quick Layouts
        - Layouts are items that are used to arrange Qt Quick 2 based items in the user interface.
    *   - Qt Quick Test
        - A unit test framework for QML applications, where the test cases are written as JavaScript functions.
    *   - Qt SQL
        - Classes for database integration using SQL.
    *   - Qt Test
        - Classes for unit testing Qt applications and libraries.
    *   - Qt Widgets
        - Classes to extend Qt GUI with C++ widgets.


.. digraph:: essentials
    :align: center

    "Qt Gui" -> "Qt Core"
    "Qt Network" -> "Qt Core"
    "Qt Multimedia" -> "Qt Gui"
    "Qt Multimedia Widgets" -> "Qt Widgets"
    "Qt Qml" -> "Qt Core"
    "Qt Quick" -> "Qt Qml"
    "Qt Quick Controls 2" -> "Qt Quick"
    "Qt Quick Dialogs" -> "Qt Quick"
    "Qt Quick Layout" -> "Qt Quick"
    "Qt Quick Test" -> "Qt Quick"
    "Qt Sql" -> "Qt Core"
    "Qt Test" -> "Qt Core"
    "Qt Widgets" -> "Qt Core"

.. rubric:: Qt Add-On Modules

Besides the essential modules, Qt offers additional modules that target specific purposes. Many add-on modules are either feature-complete and exist for backwards compatibility, or are only applicable to certain platforms. Here is a list of some of the available add-on modules, but make sure you familiarize yourself with them all in the `Qt documentation add-ons list <https://doc-snapshots.qt.io/qt5-5.12/qtmodules.html#qt-add-ons>`_ and in the list below.

.. list-table::
    :widths: 20 80
    :header-rows: 1

    *   - Module
        - Description
    *   - Qt 3D 
        - A set of APIs to make 3D graphics programming easy and declarative.
    *   - Qt Bluetooth 
        - C++ and QML APIs for platforms using Bluetooth wireless technology.
    *   - Qt Canvas 3D
        - Enables OpenGL-like 3D drawing calls from Qt Quick applications using JavaScript.
    *   - Qt Graphical Effects
        - Graphical effects for use with Qt Quick 2.
    *   - Qt Location
        - Displays map, navigation, and place content in a QML application.
    *   - Qt Network Authorization
        - Provides support for OAuth-based authorization to online services.
    *   - Qt Positioning
        - Provides access to position, satellite and area monitoring classes.
    *   - Qt Purchasing
        - Enables in-app purchase of products in Qt applications. (Only for Android, iOS and MacOS).
    *   - Qt Sensors 
        - Provides access to sensors and motion gesture recognition.
    *   - Qt Wayland Compositor
        - Provides a framework to develop a Wayland compositor. (Only for Linux).
    *   - Qt Virtual Keyboard
        - A framework for implementing different input methods as well as a QML virtual keyboard. Supports localized keyboard layouts and custom visual themes.

.. note::

    As these modules are not part of the release, the state of each module may differ depending on how many contributors are active and how well it's tested.

Supported Platforms
-------------------

Qt supports a variety of platforms including all major desktop and embedded platforms. Through the Qt Application Abstraction, it's now easier than ever to port Qt to your own platform if required.

Testing Qt 5 on a platform is time-consuming. A subset of platforms was selected by the Qt Project to build the reference platforms set. These platforms are thoroughly tested through the system testing to ensure the best quality. However, keep in mind that no code is error-free.


Qt Project
==========

From the `Qt Project wiki <http://wiki.qt.io/>`_:

    "The Qt Project is a meritocratic consensus-based community interested in Qt. Anyone who shares that interest can join the community, participate in its decision-making processes, and contribute to Qt’s development."

The Qt Project is an organization which develops the open-source part of the Qt further. It forms the base for other users to contribute. The biggest contributor is The Qt Company, which holds also the commercial rights to Qt.

Qt has an open-source aspect and a commercial aspect for companies. The commercial aspect is for companies which can not or will not comply with the open-source licenses. Without the commercial aspect, these companies would not be able to use Qt and it would not allow The Qt Company to contribute so much code to the Qt Project.

There are many companies worldwide, which make the living out of consultancy and product development using Qt on the various platforms. There are many open-source projects and open-source developers, which rely on Qt as their major development library. It feels good to be part of this vibrant community and to work with this awesome tools and libraries. Does it make you a better person? Maybe:-)

**Contribute here: http://wiki.qt.io/**
