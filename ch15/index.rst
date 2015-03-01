==========
Qt and C++
==========

.. sectionauthor:: `e8johan <https://bitbucket.org/e8johan>`_

.. issues:: ch15

Qt is a C++ toolkit with an extension for QML and Javascript. There exists many language bindings for Qt, but as Qt is developed in C++, the spirit of C++ can be found throughout the classes. In this section, we will look at Qt from a C++ perspective to build a better understanding how to extend QML with native plugins developed using C++. Through C++, it is possible to extend and control the execution environment provided to QML.

This chapter will, just as Qt, require the reader to have some basic knowledge of C++. Qt does not rely on advanced C++ features, and I generally consider the Qt style of C++ to be very readable, so do not worry if you feel that your C++ knowledge is shaky.

Approaching Qt from a C++ direction, you will find that Qt enrichen C++ with a number of modern language features enabled through making introspection data available. This is made possible through the use of the ``QObject`` base class. Introspection data, or meta data, maintains information of the classes at run-time. Something that ordinary C++ does not do. This makes it possible to dynamically probe objects for information about such details as their properties and available methods.

Qt uses this meta information to enable a very losely bound callback concept using signals and slots. Each signal can be connected to any number of slots or even other signals. When a signal is emitted from an object instance, the connected slots are invoked. As the signal emitting object does not need to know anything about the object owning the slot and vise versa, this mechanism is used to create very reusable components with very few inter-component dependencies.

The introspection features are also used to create dynamic language bindings, making it possible to expose a C++ object instance to QML and making C++ functions callable from Javascript. Other bindings for Qt C++ exists and besides the standard Javascript binding a popular one is the Python binding called `PyQt <http://www.riverbankcomputing.co.uk/software/pyqt/intro>`_.

In addition to this central concept Qt makes it possible to develop cross platform applications using C++. Qt C++ provides a platform abstraction on the different operating systems, which allows the developer to concentrate on the task at hand and not how you open a file on different operating systems. This means you can re-compile the same source code for Windows, OS X and Linux and Qt takes care about the different OS ways of handling certain things. The end result are natively built applications with the look and feel of the target platform. As the mobile is the new desktop newer Qt version can also target a number of mobile platforms using the same source code, e.g. iOS, Android, Jolla, BlackBerry, Ubuntu Phone, Tizen.

When it comes to re-use it is not only the source code which can be re-used it is also the developer skills which are much better re-usable. A team knowing Qt can reach out to far more platforms then a team just focusing on a single platform specific technology and as Qt is so flexible the team can create different system components using the same technology.

.. image:: images/yourapplication.png

For all platform, Qt offers a set of basic types, e.g. strings with full unicode support, lists, vectors, buffers. It also provides a common abstraction to the target platforms main loop, and cross platform threading  and networking support. The general philosophy is that for an application developer Qt comes with all required functionality included. For domain specific tasks such as to interface to your native libraries Qt comes with several helper classes to make this easier.


A Boilerplate Application
=========================

.. issues:: ch15

The best way to understand Qt is to start from a small demonstration application. This application creates a simple ``"Hello World!"`` string and writes it into a file using unicode characters.

.. literalinclude:: src/coreapp/main.cpp
    :language: cpp


The simple example demonstrates the use of file access and the correct way of writing text into a file using text codecs via the text stream. For binary data there is a cross platform binary stream called ``QDataStream``. The different classes we use are included using their class name. Another possibility would be to use a module and class name e.g. ``#include <QtCore/QFile>``. For the lazy there is also the possibility to include a whole module using ``#include <QtCore>``. E.g. in ``QtCore`` you have the most common classes used for an application, which are not UI dependent. Have a look at the `QtCore class list <http://doc.qt.io/qt-5/qtcore-module.html>`_ or the `QtCore overview <http://doc.qt.io/qt-5/qtcore-index.html>`_.

You build the application using qmake and make. QMake reads a project file and generates a Makefile which then can be called using make. The project file is platform independent and qmake has some rules to apply the platform specific settings to the generated make file. The project can also contain platform scopes for platform sepcific rules, which are required in some specific cases. Here is an example of a simple project file.

.. literalinclude:: src/coreapp/coreapp.pro
    :language: cpp

We will not go into depth into this topic just remember Qt uses project files for projects and qmake generates the platform specific make files from these project files.

The simple code example above just writes the text and exists the application. For a command line tool this is good enough. For a user interface you would need an event loop which waits for user input and and somehow schedules re-draw operations. So here the same example now using a desktop button to trigger the writing.

Our ``main.cpp`` suprisingly got smaller. We moved code into an own class to be able to use signal/slots for the user input, e.g. the button click. The signal/slot mechanism normally needs an own object as you will see shortly.

.. literalinclude:: src/uiapp/main.cpp
    :language: cpp

In the main we simple create the application object and start the event loop using ``exec()``. For now the application sits in the event loop and waits for user input.

.. code-block:: cpp

    int main(int argc, char** argv)
    {
        QApplication app(argc, argv); // init application

        // create the ui

        return app.exec(); // execute event loop
    }

Qt offers several UI technologies. For this example we use the Desktop Widgets user interface library using pure Qt C++. For this we create a main window which will host a push button to trigger the functionality and also the main window will host our core functionality which we know from the previous example.

.. image:: images/storecontent.png

The main window itself is a widget, which if it does not has a parent is a window. This resembles also how Qt sees a user interface as a tree of ui elements. In this case is the main window our root element nd the push button a child of the main window.

.. literalinclude:: src/uiapp/mainwindow.h
    :language: cpp

Additional we define a public slot called ``storeContent()`` whih shall be called when the button is clicked. A slot is a C++ method which is registered with the Qt meta object system and can be dynamically called.

.. literalinclude:: src/uiapp/mainwindow.cpp
    :language: cpp

In the main window we create fist the push button and then register the signal ``clicked()`` with the slot ``storeContent()`` using the connect method. Every time the signal clicked is emitted the slot slot ``storeContent()`` is called. As simple as this, objects communicate via signal and slots with loose coupling.

The QObject
===========

.. issues:: ch15

As described in the introduction, the ``QObject`` is what enables Qt's introspection. Is the base class of almost all classes in Qt. Exceptions are value types such as ``QColor``, ``QString`` and ``QList``.

A Qt object is a standard C++ object, but with more abilities. These can be divided into two groups: introspection and memory management. The first means that a Qt object is aware of its class name, its relationship to other classes, as well as its methods and properties. The memory management concept means that each Qt object can be the parent of child objects. The parent *owns* the children, and when the parent is destroyed, it is responsible for destroying its children.

The best way of understanding how the ``QObject`` abilities affect a class is to take a standard C++ class and Qt enable it. The class shown below represents an ordinary such class.

The person class is a data class with a name and gender properties. The person class uses Qt's object system to add meta information to the c++ class. It allows users of a person object to connect to the slots and get notified when the properties get changed.

.. code-block:: cpp

    class Person : public QObject
    {
        Q_OBJECT // enabled meta object abilities

        // property declarations required for QML
        Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
        Q_PROPERTY(Gender gender READ gender WRITE setGender NOTIFY genderChanged)

        // enables enum introspections
        Q_ENUMS(Gender)

    public:
        // standard Qt constructor with parent for memory management
        Person(QObject *parent = 0);

        enum Gender { Unknown, Male, Female, Other };

        QString name() const;
        Gender gender() const;

    public slots: // slots can be connected to signals
        void setName(const QString &);
        void setGender(Gender);

    signals: // signals can be emitted
        void nameChanged(const QString &name);
        void genderChanged(Gender gender);

    private:
        // data members
        QString m_name;
        Gender m_gender;
    };


The constructor passes on the parent to the super class and initialize the members. Qt's value classes are automatically initialized. In this case ``QString`` will initialize to a null string (``QString::isNull()``) and the gender member will explicitly initialize to the unknown gender.

.. code-block:: cpp

    Person::Person(QObject *parent)
        : QObject(parent)
        , m_gender(Person::Unknown)
    {
    }

The getter function is named after the property and is normally a simple ``const`` function. The setter emits the changed signal when the property really has changed. For this we insert a guard to compare the current value with the new value. And only when the value differs we assign it to the member variable and emit the changed signal.

.. code-block:: cpp

    QString Person::name() const
    {
        return m_name;
    }

    void Person::setName(const QString &name)
    {
        if (m_name != name) // guard
        {
            m_name = name;
            emit nameChanged(m_name);
        }
    }

Having a class derived from ``QObject``, we have gained more meta object abilities we can explore using the ``metaObject()`` method. For example retrieving the class name from the object.

.. code-block:: cpp

    Person* person = new Person();
    person->metaObject()->className(); // "Person"
    Person::staticMetaObject.className(); // "Person"

There are many more features which can be accessed by the ``QObject`` base class and the meta object. Please check out the ``QMetaObject`` documentation.


Build Systems
=============

.. issues:: ch15

Building software reliable on different platforms can be a complex task. You will encounter different environments with different compilers, paths and library variations. The purpose of Qt is to shield the application developer from these cross platform issues. For this Qt introduced the ``qmake`` build file generator. ``qmake`` operator on a project file with the ending ``.pro``. This project file contains instructions about the appication and the sources to be used. Running qmake on this project file will generate for you a ``Makefile`` on unix and mac and even under windows if the mingw compiler toolchain shall be used. Otherwise it may create a visual studio project or an xcode project.

A typical build flow in Qt would be under unix::

    $ edit myproject.pro
    $ qmake // generates Makefile
    $ make

Qt allows you also to use shadow builds. A shadow build is a build outside of your source code location. Assume we have a myproject folder with a ``myproject.pro`` file. The flow would be like this::

    $ mkdir build
    $ cd build
    $ qmake ../myproject/myproject.pro

We create a build folder and then call qmake from inside the build folder with the location of our project folder. This will setup the make file in a way that all build artifacts are stored under the build folder instead of inside our source code folder. This allows us to create builds for different qt versions and build configurations at the same time and also it does not clutter our soruce code folder which is always a good thing.

When you are using Qt Creator it does these things behind the scenes for you and you do not have to worry about these steps usually. For larger projects and more deeper understanding of the flow it is recommended that you can build your qt project from the command line.

QMake
-----

.. issues:: ch15

QMake is the tool which reads your project file and generates the build file. A project file is a simplified write down of your project configiration, external dependencies and your source files. The simplest source file is probably this::

    // myproject.pro

    SOURCES += main.cpp

Here we build an exectuable application which will have the name ``myproject`` based on the project file name. The build will only contain the ``main.cpp`` source file. And by default we will use the QtCore and QtGui module for this project. If our project would be a QML application we would need to add the QtQuick and QtQml module to the list::

    // myproject.pro

    QT += qml quick

    SOURCES += main.cpp

Now the build file knows to link against the QtQml and QtQuick Qt modules. QMake use the concept of ``=``, ``+=` and ``-=`` to assign, add, remove elements from a list of options. For example for a pure console build without UI dependencies you would remove the QtGui module::

    // myproject.pro

    QT -= gui

    SOURCES += main.cpp

When you want to build a library instead of an application you need to change the build template::

    // myproject.pro
    TEMPLATE = lib

    QT -= gui

    HEADERS += utils.h
    SOURCES += utils.cpp


Now the project will build as a library without UI dependencies and used the ``utils.h`` header and the ``utils.cpp`` source file. The format of the library will depend on the OS you are building the project.

Often you wil have more complicated setups and need to build a set of projects. For this qmake offers the ``subdirs`` template. Assumy we would have a mylib and a myapp project. Then our setup could be like this::

    my.pro
    mylib/mylib.pro
    mylib/utils.h
    mylib/utils.cpp
    myapp/myapp.pro
    myapp/main.cpp

We know already how the mylib.pro and myapp.pro would look like. The my.pro as the overarching project file would look like this::

    // my.pro
    TEMPLATE = subdirs

    subdirs = mylib \
        myapp

    myapp.depends = mylib

This declares a project with two subproject ``mylib`` and ``myapp``. Where ``myapp`` depends on ``mylib``. When you run qmake on this project file it will generate for each project file a build file in the corresponding folder. When running the make file for ``my.pro`` then all subproject are also build.

Sometimes you need to do one thing on one platform and another thing on other platforms based on your configuration. For this qmake introduces the concept of scopes. A scope is a applied when a configuration option is set to true.

For example to use a unix specific utils implementation you could use::

    unix {
        SOURCES += utils_unix.cpp
    } else {
        SOURCES += utils.cpp
    }

What it says is if the CONFIG variable contains a unix option then apply this scope otherwise use the else path. A typical one is to remove the application bundling under mac::

    macx {
        CONFIG -= app_bundle
    }

This will create your application as a plain executable under mac and not as a ``.app`` folder which is used for application instalation.

QMake based projects are normally the choice number one when you start programming Qt applications. But there are also other options out there. All have their benefits and drawbacks. We will shortly discuss these other options in the next topcis.

.. rubric:: References

* :qt5:`QMake Manual <qmake-manual>` - Table of contents of the qmake manual

* :qt5:`QMake Language <qmake-language>` - Value assignment, scopes and so like

* :qt5:`QMake Variables <qmake-variable-reference>` - Variables like TEMPLATE, CONFIG, QT are explained here



CMake
-----

.. issues:: ch15

CMake is a tool create by Kitware. Kitware is very well known for their 3D visualitation software VTK and also CMake, the cross platform makefile generator. It uses a series of ``CMakeLists.txt`` files to generate platform specific make files. CMake is used by the KDE project and as such has a special relationship with the Qt community.

The ``CMakeLists.txt`` file to store the project configuration. For a simple hello world using QtCore the project file would look like this::

    // ensure cmake version is at least 3.0
    cmake_minimum_required(VERSION 3.0)
    // adds the source and build location to the include path
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
    // Qt's MOC tool shall be automatically invoked
    set(CMAKE_AUTOMOC ON)
    // using the Qt5Core module
    find_package(Qt5Core)
    // create excutable helloworld using main.cpp
    add_executable(helloworld main.cpp)
    // helloworld links against Qt5Core
    target_link_libraries(helloworld Qt5::Core)

This will build a helloworld executable using main.cpp and linked agains the external Qt5Core library. The build file can be modified to be more generic::

    // sets the PROJECT_NAME variable
    project(helloworld)
    cmake_minimum_required(VERSION 3.0)
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
    set(CMAKE_AUTOMOC ON)
    find_package(Qt5Core)

    // creates a SRC_LIST variable with main.cpp as single entry
    set(SRC_LIST main.cpp)
    // add an executable based on the project name and source list
    add_executable(${PROJECT_NAME} ${SRC_LIST})
    // links Qt5Core to the project executable
    target_link_libraries(${PROJECT_NAME} Qt5::Core)

You see CMake is quit powerful. It takes some time to get used to the syntax. What is said in general that CMake is better suited for large and complex projects.

.. rubric:: References

* `CMake Help <http://www.cmake.org/documentation/>`_ - available online but also as QtHelp format
* `Running CMake <http://www.cmake.org/runningcmake/>`_
* `KDE CMake Tutorial <https://techbase.kde.org/Development/Tutorials/CMake>`_
* `CMake Book <http://www.kitware.com/products/books/CMakeBook.html>`_
* `CMake and Qt <http://www.cmake.org/cmake/help/v3.0/manual/cmake-qt.7.html>`_

.. todo::
    * background, KDE, benefits, drawbacks, etc
    * a basic example


Common Qt Classes
=================

.. issues:: ch15

The ``QObject`` class forms the foundations of Qt, but there are many more classes in the framework. Before we continue looking at QML and how to extend it, we will look at some basic Qt classes that are useful to know about.

.. todo::
    * QString, QStringList
    * unicode, arg()

.. todo::

    * QList, foreach, iterators (both C++-style and JavaStyle)

.. todo::
    * QFile, QTextReader


Models in C++
=============

.. issues:: ch15

.. todo::
    * QAbstractListModel
    * custom role names
    * the basics
    * how this fits into QML

Asynchronous Data Retrieval
---------------------------

.. issues:: ch15

.. todo::
    * canFetchMore/fetchMore + beginInsertRows/endInsertRows
    * this really does not work very well with QML, should we scrap it?

SQL Models
----------

.. issues:: ch15

.. todo::
    * QSqlTableModel
    * QSqlQueryModel
    * mapping columns to roles
