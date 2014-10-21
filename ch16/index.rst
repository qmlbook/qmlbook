==============
Native Plugins
==============

.. sectionauthor:: `e8johan <https://bitbucket.org/e8johan>`_

.. issues:: ch16

Executing QML within the confined space that QML as a language offers can sometimes be limiting. By extending the QML run-time with native plugins written in C++, the application can utilize the full performance and freedom of the base platform.

Understanding the QML Run-time
==============================

.. issues:: ch16

When running QML, it is being executed by in a run-time environment. The run-time is implemented in C++ in the ``QtDeclarative`` module. It consists of an engine, responsible for the execution of QML, contexts, holding the properties accessible for each component, and components, the instantiated QML elements.

.. literalinclude:: src/basicmain/main.cpp
    :language: cpp

The basic components of the application shown are the ``QGuiApplication`` object, ``app`` and the ``QQuickView`` object, ``view``. The application object encapsulates all that is related to the application instance. There must be one, and only one, instance of an application object at any given time in a Qt application.


Building a Basic QML Viewer
---------------------------

.. issues:: ch16

The most trivial QML run-time that can be constructed, consists of a ``QGuiApplication`` and a ``QQuickView``. The application object is reponsible for running the event loop, integrating the program into the surrounding system. For instance, it harvests the touch events from the host platform, be it Linux, Symbian, QNX or anything else, and creates the corresponding ``QEvent`` objects that are passed to the right ``QObject`` instance. The view has a similar response, acting as the bridge between QML and C++. It executes QML code, passing events, properties and instantiable types from C++ to QML.

.. literalinclude:: src/basicmain/main.cpp
    :language: cpp

The components of the view can be accessed through methods. For instance, the ``engine`` method provides access to the ``QDeclarativeEngine`` responsible for executing the QML. The engine, in turn, can be used to configure the behavior of the run-time in detail. The native run-time shown above will serve as base for the examples through-out the remainder of this chapter.

Extending the Context
=====================

.. issues:: ch16

The easiest way to create a bridge between the C++ run-time and QML, is to extend the root context with new properties. These properties are exposed to QML as global variables. Through these globals, it is possible to access data and methods from the C++ side. The root context is available through the ``rootContext`` method of the ``QQuickView``.

Context Properties
------------------

.. issues:: ch16

Each ``QDeclarativeEngine`` has a ``rootContext`` property, containing the root context of the QML environment in which the QML components are instantiated. This root context forms the basic setup of properties available to all components contained within that engine. In addition to the root context, each component within the engine has a context of its own. A new context can be provided to the ``QDeclarativeComponent::create`` method, used to instantiate QML components from C++.

In the example below, a ``QDeclarativeEngine`` is created, then two components are created within that engine. One, ``xxx``, is constructed by calling ``create`` without an argument. This causes the engine's ``rootContext`` to be used. For the other component, a ``QDeclarativeContext`` is provided. This causes the second component, ``xxx``, to execute in a context different from the one of ``xxx``.

.. todo:: example, as described above, fix names xxx for first and second component

.. literalinclude:: src/contexts/main.cpp
    :language: cpp

All components execute within a context. By inserting properties into those contexts, it is possible to provide a bridge between C++ and QML. The easiest way to do this is to provide value properties. This means providing a single value under a name, for instance, the example below demonstrates how to pass a simple string from C++ to QML using the ``setContextProperty`` method.

.. literalinclude:: src/contextproperties/string/main.cpp
    :language: cpp

It is possible to expose a number of types as values. The basic types being supported are:

* ``bool``
* ``unsigned int``, ``int``
* ``float``, ``double``, ``qreal``
* ``QString``
* ``QUrl``
* ``QColor``
* ``QDate``, ``QTime``, ``QDateTime``
* ``QPoint``, ``QPointF``
* ``QSize``, ``QSizeF``
* ``QRect``, ``QRectF``
* ``QVariant``
* ``QVariantList``, ``QVariantMap``

.. todo: double check list above with Qt 5

By altering the value of a context property while the QML is being executed, the bindings relating to the property are reevaluated. This means that the state of the QML is being updated according to the state of C++. The code snippet below shows the C++-half of such as setup, where the ``inverted`` property is toggled every second using a ``QTimer``.

.. literalinclude:: src/contextproperties/changingbool/main.cpp
    :language: cpp

The corresponding QML-half is shown below. As you can tell, the ``inverted`` property is used to alternate between the unnamed state and ``"inverted"``. A nice aspect to notice is that the C++ property is changed instantaneously, but by using it to drive the states, the ``transitions`` apply, making the end result a fluid user interface with smooth property changes.

.. literalinclude:: src/contextproperties/changingbool/main.qml
    :language: js

.. todo:: example registering a custom type

.. todo:: example exposing a QVariantList and a QVariantMap

.. literalinclude:: src/contextproperties/listsandmaps/main.cpp
    :language: cpp

An alternative to exposing pure values to QML, is to expose ``QObject`` instances. This allows QML to use the full interface of the object. For instance, properties declared through Q_PROPERTY can be accessed, as can Q_INVOKABLE methods, as well as signals. Enumerations declared with Q_ENUMS can also be accessed directly from QML through the class name, as shown below. When looking at the example, notice how the ``Connections`` element is used to connect to a signal from the object.

.. todo:: example exposing a QObject*, and an enum property and signal
.. literalinclude:: src/contextproperties/qobject/main.cpp
    :language: cpp

A special, and very useful, case of exposing a ``QObject`` to QML from C++ is to expose a model. This makes it easy to share data in the form of a C++ model to QML. Depending on the nature of the application being developed, a model is a natural mechanism for exposing list data to QML.

In the following example a simple ``QStringListModel`` is provided to QML space under the name ``colorModel``. It contains all the color names known to Qt. On the QML side, the model is visualized through a ``GridView`` exposing a set of colored rectangles. This shows how natural it is to expose data through models implemented in C++.

.. literalinclude:: src/contextproperties/model/main.cpp
    :language: cpp

On the QML-side, shown below, there is no additional code to handle the fact that the model is instantiated from C++. Likewise, on the C++ side, shown above, the model is identical to a model used through a C++ view, it is only bound to a QML name using the ``setContextProperty`` method of the root context.

.. literalinclude:: src/contextproperties/model/main.qml
    :language: js
    :lines: 1-21

A Context Property Object
-------------------------

.. issues:: ch16

.. todo:: context property object
.. literalinclude:: src/contextproperties/contextobject/main.cpp
    :language: cpp

Image Providers
---------------

.. issues:: ch16

A common requirement when developing QML applications is to use generated graphics in the user interface. This can range from images being created on the fly from a data set, to images provided through a non-standard mechanism such as a custom API. In these cases, a small C++ snippet is needed to create an actual ``QImage`` or ``QPixmap`` object. However, it is not possible to share such an image with QML directly. It is not one of the default types, and the ``Image`` element does not accept it through any property. Instead, images are always accessed through URLs in QML.

To pass a custom, generated, image from C++ to QML, an image provider must be implemented. This is done by inhering the ``QDeclarativeImageProvider`` class and implementing one of the virtual methods ``requestImage`` or ``requestPixmap``, depending on the format of the image being generated. The image provides are registered with the ``QDeclarativeEngine`` used through the ``addImageProvider`` method. As soon as an image has been registered under a name, all URLs starting with ``image:://name/`` will be passed to the provider. For instance, the provider below gets all the URLs starting with ``image://stock-icons/``.

.. todo:: example, stock-icons image provider
.. literalinclude:: src/imageproviders/main.cpp
    :language: cpp

The image provider implemented above makes it easy to access a set of stock icons. The example below demonstrates this by showing the available icons in a ``GridView``.

.. todo:: example, a model of strings, shown through Image and Text elements in a GridView
.. literalinclude:: src/imageproviders/main.qml
    :language: js

It is possible to use an image provider to acquire images in a separate thread, as well as provide images that change over time. Both these topics are covered in the advanced techniques section later in this chapter.

Registered Types
================

.. issues:: ch16

Providing data through context properties is useful to exposing data from a static setting. For instance, the current time, temperature, screen orientation, and other information that always is available. In some cases, this is not flexible enough. For instance, providing a model representing the contents of a directory path as a context property limits the user interface to showing the contents of a single directory at once. An alterantive would be to expose the model to QML in such a fashion that QML could instantiate any number of instances of the model. This would allow the QML developer to determine how many directories to show at once.

Any class derived from the ``QObject`` clase can be registered with QML to allow QML to instantate it. However, there are basically two types of elements that are useful to expose to QML this way: data sources, such as the directory contents model, and visible items. We will discuss both types in the sections below.

Data Sources
------------

.. issues:: ch16

Any QObject derived class can be used to expose data to QML. By providing a relevant set of properties, methods and signals, the usage from QML can be made both convenient and reusable. A special, and very common, case of a non-visual class exposed to QML are data models. Before we look at a model, a simple directory monitoring class is used.

.. todo:: example, class exposing inotify, counting the contents of a directory and signalling changes
.. todo:: explain howto register type

.. todo:: example of a model exposing directory contents, where the base directory path can be controlled, as well as a filter. Base on QDir. Expose an invokable method for creating directories...

QQuickPainterItem
-----------------

.. issues:: ch16


.. note::

    * using the painter or OpenGL

.. todo:: qmlRegisterUncreatableType<QDeclarativeCameraCapture>(uri, 5, 0, "CameraCapture", trUtf8("CameraCapture is only provided by Camera element"));


QML Specific Property Concepts
------------------------------

.. issues:: ch16


* List properties
* Default properties
* Grouped properties

Extension Plugins
=================

.. issues:: ch16


.. note::

    Exporting and exposing extensions as plugins through the qmlscene viewer application

Resource Files
==============

.. issues:: ch16

.. note:: embedding data in the application. Accessing files from qrc qml, accessing qrc from file qml



Advanced Techniques
===================

.. issues:: ch16

* Threaded image provider
* Image provider and images changing over time (http://www.digia.com/en/Blogs/Qt-blog/Andy-Shaw/Dates/2012/2/Qt-Commercial-Support-Weekly-15---Models-providing-dynamic-images-in-QML/)
* Using QDeclarativeParserStatus
* Using extension objects, and why
* API revisions, how to use a single class for multiple revisions and why
* Working with QSGNode
