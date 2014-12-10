==========
JavaScript
==========

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_

.. issues:: ch14


JavaScript is the lingua-franca on web client development. It also starts to get traction on web server development mainly by node js. As such it is well suited add an imperative language onto the side of declarative QML language. QML itself as a declarative language is used to express the user interface hierachy but is limited to express operational code. Sometimes you need a way to express operations, here JavaScript comes into play.

.. note:: There is an open dispute in the Qt community about the right mixture about QML/JS/QtC++ in a modern Qt application. This book pushes the boundaries, which is not always the right mix for a product development. There it is more important to go with your developer skills and where they feel comfortable.

Here a short example how JS looks like::

  Button {
    width: 200
    height: 300
    property bool toggle: false
    text: "Click twice to exit"

    onTriggered: {
      // this is JavaScript
      toggle = !toggle
      if(toggle) {
        Qt.quit()
      }
    }
  }

So JavaScript can come in many places inside QML as a standalone JS function, as a JS module and it can be on every right side of a property binding.

::

  import "util.js" as Util // import a pure JS module

  Button {
    width: 200
    height: width*2 // JS on the right side of property binding

    // standalone function
    function log(msg) {
      console.log("Button> " + msg);
    }

    onTriggered: {
      // this is JavaScript
      log();
      Qt.quit();
    }
  }

With QML you describe the user interface, with JavaScript you make it functional. So how much JavaScript should you write? It depends on your style and how familar you are with JS development. JS is a very forgiving language in such sense it is difficult to spot defects. The way to spot defects is rigorous unit testing or acceptance testing. So if you develop real logic (not some glue lines of code) in JS you should really start unit testing this throughoutly. In general mixed teams (Qt/C++ and QML/JS) are very successfull when the minimize the amount of JS in the frontend as the domain logic and the heavy lifting is done in C++ and is heavily tested and the frontend developers can use and trust these code bases. 

.. note:: In general: backend developers are functional driven and frontend developers are user story driven.

The Language
============

For a general introduction ot JavaScript, please visit this great side on `Mozilla Developer Network <https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript>`_. 

On the surface javascript is a very common language and not differs a lot from other languages::

  function countDown() {
    for(var i=0; i<10; i++) {
      console.log('index: ' + i)
    }   
  }

  function countDown2() {
    var i=10;
    while( i>0 ) {
      i--;
    }
  }


``if ... else``, ``break``, ``continue`` also work as expected. The switch case can also switch about other types then just integer values::

  function getAge(name) {
    switch(name) {
    case "father": 
      return 58;
    case "mother":
      return 56;
    }
    return unknown;
  }

JS knows several values which can be false, e.g. ``false``, 0, "", ``undefined``, ``null``). For example a function returns by default ``undefined``.

Under the hood javascript has its own ways of doing things. For example arrays::

  function doIt() {
    var a = [] // empty arrays
    a.push(10) // addend number on arrays
    a.push("Monkey") // append string on arrays
    console.log(a.length) // prints 2
    a[0] // returns 10
    a[1] // returns Monkey
    a[2] // returns undefined
    a[99] = "String" // a valid assignment
    console.log(a.length) // prints 100
    a[98] // contains the value undefined
  }

Also for people coming from C++ or Java which are used to a OO language JS just works different. JS is not purely an OO language it is a so called prototype based language. Each object has a prototype object. An object is created based on this prototype object. Please read more about this in the book `Javascript the Good Parts by Douglas Crockford <http://javascript.crockford.com>`_ or watch the video below.

.. youtube:: hQVTIJBZook


To test some small JS snippets you can use the online `JS Console <http://jsconsole.com>`_ or just build a little piece of QML code::


  import QtQuick 2.0

  Item {
    function runJS() {
      console.log("Your JS code goes here");
    }
    Component.onCompleted: {
      runJS();
    }
  }


JS Objects
==========

While working with JS there are some objects and methods which are more frequently used. This is a small collection of them.

* ``Math.floor(v)``, ``Math.ceil(v)``, ``Math.round(v)`` - largest, smallest, rounded integer from float
* ``Math.random()`` - create a random number between 0 and 1
* ``Object.keys(o)`` - get keys from object (including QObject)
* ``JSON.parse(s)``, ``JSON.stringify(o)`` - conversion between JS object and JSON string
* ``Number.toFixed(p)`` - fixed precision float
* ``Date`` - Date manipulation
  
Here some small and limited examples how to use JS with QML. They should give you an idea how you can use JS inside QML

.. rubric:: Print all keys from QML Item

::

  Item {
    id: root
    Component.onCompleted: {
      var keys = Object.keys(root);
      for(var i=0; i<keys.length; i++) {
        var key = keys[i];
        // prints all properties, signals, functions from object
        console.log(key + ' : ' + root[key]);
      }
    }
  }


.. rubric:: Parse a object and back

::

  Item {
    property var obj: {
      key: 'value'      
    }

    Component.onCompleted: {
      var data = JSON.stringify(obj);
      console.log(data);
      var obj = JSON.parse(data);
      console.log(obj.key); // > 'value'
    }
  }

.. rubric:: Current Data

::

  Item {
    Timer {
      id: timeUpdater
      interval: 100
      running: true
      repeat: true
      onTriggered: {
        var d = new Date();
        console.log(d.getSeconds());
      }
    }
  }


.. rubric:: Call a function

::
  
  Item {
    id: root

    function doIt() {
      console.log("doIt()")
    }

    Component.onCompleted: {
      // Call using function execution
      root["doIt"]();
      var fn = root["doIt"];
      // Call using JS call method (could pass in a custom this object and arguments)
      fn.call()
    }
  }


Creating a JS Console
=====================


To create a JS console we need to be able to provide an input field and ideally a list of output results. As this should more look like a desktop application we use the QtQuick Controls module.


.. note:: A JS console inside your next project can be really benefitical for testing. Enhanced with a Quake-Terminal effect it is also good to impress customers. To use it wisely you need to control the scope the JS console acts on, e.g. the current visible screen, the main data model, a singleton core object or all together.


.. image:: assets/jsconsole.png


We use Qt Creator to create a QtQuick UI using QtQuick controls. We call the project JSConsole. After the wizard runs through we have already a basic structure for the application with an application window and a menu to exit the application. 

For the input we use a TextField and a Button to send the input for evaluation. The result is displayed using a ListView using a ListModel as model and two labels to display the input and the evaluated result.

::

  // part of JSConsole.qml
  ApplicationWindow {
    id: root

    ... 

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 9
        RowLayout {
            Layout.fillWidth: true
            TextField {
                id: input
                Layout.fillWidth: true
                focus: true
                onAccepted: {
                    // call our evaluation function on root
                    root.jsCall(input.text)
                }
            }
            Button {
                text: qsTr("Send")
                onClicked: {
                    // call our evaluation function on root
                    root.jsCall(input.text)
                }
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.fill: parent
                color: '#333'
                border.color: Qt.darker(color)
                opacity: 0.2
                radius: 2
            }

            ScrollView {
                id: scrollView
                anchors.fill: parent
                anchors.margins: 9
                ListView {
                    id: resultView
                    model: ListModel {
                        id: outputModel
                    }
                    delegate: ColumnLayout {
                        width: ListView.view.width
                        Label {
                            Layout.fillWidth: true
                            color: 'green'
                            text: "> " + model.expression
                        }
                        Label {
                            Layout.fillWidth: true
                            color: 'blue'
                            text: "" + model.result
                        }
                        Rectangle {
                            height: 1
                            Layout.fillWidth: true
                            color: '#333'
                            opacity: 0.2
                        }
                    }
                }
            }
        }
    }
  }


The evaluation function ``jsCall`` does the evaluation not by itself this has been moved to a JS module (``jsconsole.js``) for clearer separation.

::

  // part of JSConsole.qml

  import "jsconsole.js" as Util

  ...

  ApplicationWindow {
    id: root

    ...

    function jsCall(exp) {
        var data = Util.call(exp);
        // insert the result at the beginning of the list
        outputModel.insert(0, data)
    }
  }

For safety we do not use the ``eval`` function from JS as this would allow the user to modify the local scope. We use the Function constructor to create a JS function on runtime and pass in our scope as this variable. As the function is created every time it does not act as a closure and stores its own scope, we need to use ``this.a = 10`` to store the value 10 in a inside the this scope of the function. The this scope is set by the script to the scope valriable.

::

  // jsconsole.js
  .pragma library

  var scope = {
    // our custom scope injected into our function evaluation
  }

  function call(msg) {
      var exp = msg.toString();
      console.log(exp)
      var data = {
          expression : msg
      }
      try {
          var fun = new Function('return (' + exp + ');');
          data.result = JSON.stringify(fun.call(scope), null, 2)
          console.log('scope: ' + JSON.stringify(scope, null, 2) + 'result: ' + result)
      } catch(e) {
          console.log(e.toString())
          data.error = e.toString();
      }
      return data;
  }

The data return from the call function is a JS object with a result, expression and error property: ``data: { expression: {}, result: {}, error: {} }``. We can use this JS object directly inside the ListModel and access it then from the delegate, e.g. ``model.expression`` gives us the input expression. For the simplicity of the example we ignore the error result.




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
