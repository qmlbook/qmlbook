==========
JavaScript
==========

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_

.. issues:: ch14


.. hint::

	This chapter is about scripting QML. QML comes with the V8 JS engine. It contains the ful ECMA script language.

	* Math, Date, JSON, ...
	* JS reference (for-loop. datatypes, functions, arrays, objects...) - short and precise in the context of qml
	* QML JS difference to Browser JS - e.g. no document model, not JS libs like JQuery
	* Cover specialities between QML and JS. Sometime QML types get converted to JS types and loose information (or wise/versa)
	* JS libraries


	.. todo:: there is a qmltestrunner, should we also cover unit testing possibilties

* EcmaScript vs. JavaScript
* Qt and JavaScript
* JS Version used , Google V8
* QML and JavaScript
	* Properties, Functions, Modules

* http://arstechnica.com/business/2012/04/an-in-depth-look-at-qt-5-making-javascript-a-first-class-citizen-for-native-cross-platform-developme/
* http://doc-snapshot.qt-project.org/5.0/qml-javascript.html
* http://doc-snapshot.qt-project.org/5.0/qml-scope.html
* http://doc-snapshot.qt-project.org/5.0/qml-properties.html
* https://developer.mozilla.org/en/JavaScript/Guide
* http://en.wikipedia.org/wiki/ECMAScript
* http://de.wikipedia.org/wiki/JavaScript
* http://www.ecma-international.org/publications/standards/Ecma-262.htm


Performing Work in the Background
=================================

.. issues:: ch14

When executing JavaScript as a part of a QML application, it is run in the main thread. That means that any lengthy operations that might take place will block the main loop of the application. To remedy this, these tasks must be executed in a background thread. Something that can be implemented either using C++, or using a ``WorkerScript`` element.

The ``WorkerScript`` element provides an method to execute an arbitrary piece of JavaScript in a separate thread. It also provides a mechanism for exchanging messages with the thread,



.. todo:: continue here with a simple example, exchanging messages between the ui and a thread



Separate Thread Context
-----------------------

.. issues:: ch14

The script executed through a ``WorkerScript`` is executed in a separate context. This means that no QML items or properties are accessible, nor are any properties exposed through the use of the C++ ``QDeclarateContext`` class. Instead, all shared objects must be passed through messages.

.. todo:: example on how to pass an item to a script, exposing its properties to the JavaScript (exposing a C++ object would be more relevant, but it is too early for that).

Interfacing Models
------------------

.. issues:: ch14

When sharing a ``ListModel`` between the main thread an a ``WorkerScript`` thread, some precausions must be taken. First of all, the model must not contain list-type properties, i.e. properties containing lists, e.g. objects or values listed between´´[´´ and ´´]´´. Also, any alternations to the model must be synced to be propagated from a ``WorkerScript`` thread to the main thread.

When a change is made to a model, i.e. data being altered, deleted or appended, from a ``WorkerScript`` thread, this is not immediately reflected in the main thread. Instead, the ``WorkerScript`` code must call the ``sync`` function of the ``ListModel`` to explicitly propagate the changes to the main thread.

.. todo:: simple example of a worker script updating a model and calling synced

- ListModel.sync()
