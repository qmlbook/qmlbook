==========
Qt and C++
==========

.. sectionauthor:: `e8johan <https://bitbucket.org/e8johan>`_

.. issues:: ch15

Qt is a C++ toolkit. There are many language bindings for Qt, but as Qt is developed in C++, the properties of C++ can be found throughout the classes. In this section, we will look at Qt from a C++ perspective to build a better understanding how to extend QML with native plugins developed using C++. Through C++, it is possible to extend and control the execution environment provided to QML.

This chapter will, just as Qt, require the reader to have some basic knowledge of C++. Qt does not rely on advanced C++ features, and I generally consider the Qt style of C++ to be very readable, so do not worry if you feel that your C++ knowledge is shaky.

Approaching Qt from a C++ direction, you will find that Qt enrichen C++ with a number of modern language features enabled through making introspection data available. This is made possible through the use of the ``QObject`` base class. Introspection data, or meta data, maintains information of the classes at run-time. Something that ordinary C++ does not to. This makes it possible to dynamically probe objects for information about such details as their properties and available methods. 

Qt uses this information to enable a very losely bound callback concept using signals and slots. Each signal can be connected to any number of slots. When a signal is emitted from an object instance, the connected slots are invoked. As the signal emitting object does not need to know anything about the object owning the slot and vise versa, this mechanism can be used to create very reusable components with very few inter-component dependencies.

The introspection features are also used to create dynamic language bindings, making it possible to expose a C++ object instance to QML and making C++ functions callable from Javascript. This feature is used in the WebKit bindings, making it possible to expose C++ objects to Javascript that are a part of an HTML5 application, but also in the QML bindings.

In addition to this central concept Qt makes it possible to develop cross platform applications using C++. That is, to recompile the same source code for Windows, OS X and Linux. The end result is natively built applications with the look and feel of the target platform. It is also possible to target a number of mobile platforms using the same source code, e.g. iOS, Android, Jolla, BlackBerry, Ubuntu Phone, Tizen.

.. todo::
    * Illustration of basic app on all major platforms.

For all platform, Qt offers a set of basic types, e.g. strings with full unicode support, lists, vectors, buffers. It also provides a common abstraction to the target platforms' main loop, and cross platform threading support.
    
    
A Boilerplate Application
=========================

.. issues:: ch15

The best way to understand Qt is to start from a small demonstration application.

.. todo::
    * the main loop
    * a basic build configuration using qmake
    * how to build and run
    

The QObject
===========

.. issues:: ch15

As described in the introduction, the ``QObject`` is what enables Qt's introspection. Is the base class of almost all classes in Qt. Exceptions are value types such as ``QColor``, ``QString`` and ``QList``.

A Qt object is a standard C++ object, but with more abilities. These can be divided into two groups: introspection and memory management. The first means that a Qt object is aware of its class name, its relationship to other classes, as well as its methods and properties. The memory management concept means that each Qt object can be the parent of child objects. The parent *owns* the children, and when the parent is destroyed, it is responsible for destroying its children.

The best way of understanding how the ``QObject`` abilities affect a class is to take a standard C++ class and Qt enable it. The class shown below represents an ordinary such class.

.. todo::
    * when is it applicable - individuals, not values
    * getter, setter, reset method - using enum
    * inherit
    * Q_OBJECT
    * getFoo -> foo()
    * Q_PROPERTY, Q_ENUM
    * signal
    * setter is a natural slot
    * Q_INVOKABLE

.. code-block:: cpp

    class Person : public QObject
    {
        Q_OBJECT

        Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
        Q_PROPERTY(Gender gender READ gender WRITE setGender NOTIFY genderChanged)

        Q_ENUMS(Gender)

    public:
        Person(QObject *parent = 0);

        enum Gender { Unknown, Male, Female, Other };

        QString name() const;
        Gender gender() const;

    public slots:
        void setName(const QString &);
        void setGender(Gender);

    signals:
        void nameChanged(const QString &name);
        void genderChanged(Gender gender);

    private:
        QString m_name;
        Gender m_gender;
    };

.. code-block:: cpp

    Person::Person(QObject *parent)
        : QObject(parent)
        , m_gender(Person::Unknown)
    {
    }

.. code-block:: cpp

    QString Person::name() const
    {
        return m_name;
    }

    void Person::setName(const QString &n)
    {
        if (n != m_name)
        {
            m_name = n;
            emit nameChanged(m_name);
        }
    }

Having a valid class derived from ``QObject``, we have gained some more.

.. todo::
    * demonstrate className, point out the importance of Q_OBJECT
    * demonstrate memory management through the c'tor
    * talk about that this is the key to integrating C++ and QML
    
    
Build Systems
=============

.. issues:: ch15

.. todo::
    * why a build system
    * the actual Qt build flow
    
QMake
-----

.. issues:: ch15

.. todo::
    * background, drawbacks, benefits
    * a basic example

CMake
-----

.. issues:: ch15

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
