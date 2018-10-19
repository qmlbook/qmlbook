=============
Qt for Python
=============

.. sectionauthor:: `e8johan <https://github.com/e8johan>`_

.. github:: ch106

.. note::

    Last Build: |today|

    The source code for this chapter can be found in the `assets folder <../../assets>`_.


This chapter ... TBD    

Introduction
============
    
the module

Can be used for anything - interacting with Qt interfaces. Headless, widgets or qml. our focus is qml.

No current support for mobile platforms.

Reference documentation: https://doc.qt.io/qtforpython/
Caveats: https://wiki.qt.io/Qt_for_Python/Considerations

Natural way to use it is Logic in python, UI in QML

.. note::

    Through-out this chapter we will use Python 3.6.

Installing
==========

Example::

    e8johan@xps13den3e:~/work/code/qmlbook/python-for-qt$ python3 -m venv .
    e8johan@xps13den3e:~/work/code/qmlbook/python-for-qt$ . bin/activate
    (python-for-qt) e8johan@xps13den3e:~/work/code/qmlbook/python-for-qt$ python --version
    Python 3.6.6

    $ pip install pyside2
    Collecting pyside2
    Downloading https://files.pythonhosted.org/packages/3d/21/c903d1d68882d9c813f4b291f04849281f2b42550c0fca88ff5dc9d9427c/PySide2-5.11.2-5.11.2-cp35.cp36.cp37-abi3-manylinux1_x86_64.whl (166.4MB)
        100% |████████████████████████████████| 166.4MB 12kB/s 
    Installing collected packages: pyside2
    Successfully installed pyside2-5.11.2

    $ python
    Python 3.6.6 (default, Jun 27 2018, 14:44:17) 
    [GCC 8.1.0] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> from PySide2 import QtCore, QtWidgets, QtGui
    >>> import sys
    >>> app = QtWidgets.QApplication(sys.argv)
    >>> widget = QtWidgets.QLabel("Hello World!")
    >>> widget.show()
    >>> app.exec_()
    0
    >>> 


A TBD Application
=================

demo of python environment hosting a QML UI, sharing state through a class

Running QML from Python
-----------------------

.. literalinclude:: src/basic/basic.py
    :language: python

.. literalinclude:: src/basic/main.qml


Exposing a Python object to QML
-------------------------------

- invokable methods
- slots
- signals
    - signal argument names trick

.. literalinclude:: src/object/object.py
    :language: python

.. literalinclude:: src/object/main.qml

- properties
    - signal argument name solved by property name
    - readonly property
    - readwrite property
    - camel case slot, calling python method (to not break QML bindings)
    - two ways to define a signal
    - ordering

.. literalinclude:: src/property/property.py
    :language: python
    
.. literalinclude:: src/object/main.qml

Exposing a Python class to QML
------------------------------

- Instantiation from python

.. literalinclude:: src/class/class.py
    :language: python

.. literalinclude:: src/class/main.qml


Modelling in Python
-------------------

- abstract item list model
    - using psutil - https://pypi.org/project/psutil/
    - no QVariant, use None

.. literalinclude:: src/class/class.py
    :language: python

.. literalinclude:: src/class/main.qml

Summary
=======
