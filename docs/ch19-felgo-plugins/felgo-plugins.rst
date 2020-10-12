===================================
Felgo Plugins and QML Hot Reloading
===================================

.. sectionauthor:: `e8johan <https://bitbucket.org/e8johan>`_

.. github:: ch19

.. note::

    Last Build: |today|

    The source code for this chapter can be found in the `assets folder <../assets>`_.

We've already discussed how Felgo enhanches Qt and simplifies the creation of applications. In this chapter we will look a bit deeper at the tooling and the mobile plugins that Felgo provides.

Tooling
=======

Felgo comes with two tools that simplifies life as a Qt developer. The Felgo Live that lets you watch your code changes live, and Cloud Builds, that lets you automate the building and deployment of your apps for all platforms.

Felgo Live
----------

The Hot Reload and Felgo Live Clients lets you modify your code and see the changes live. All QML, JavaScript, and assets are updated on every connected device as soon as you save your file.

IMAGE IMAGE IMAGE

One nice aspect of Hot Reload is that it is smart enough to modify only what you changed, preserving the state of your application. For instance, if you are updating a page containing a toggled switch, it will still be toggled after a reload.

This shortens the roundtrip times dramatically when developing, as you no longer have to go through the complete save, compile, deploy, restart cycle.

The Felgo Live tool is a standalone tool that comes with the Felgo SDK and can be used with any Qt/QML project. You do not have to develop your app with the Felgo SDK to enable QML Hot Reload for your project.

In the Felgo SDK, you launch Felgo Live from the Live Play button in the Qt Creator side bar, as shown below.

IMAGE IMAGE IMAGE

Once running, the Felgo Live Server is running together with your application. Every time you save your source files, the changes are immediately shown in the running application. You can also see logs from all connected devices. It is also possible to start the live server from command line, passing your root QML file as an argument.

IMAGE IMAGE IMAGE

Felgo Hot Reload can be used on every target platform - be it desktop oo mobile. It even works for WebAssembly and Embedded systems. Felgo has more information on the topic at the `product page <https://felgo.com/doc/qml-hot-reload-felgo-live/>`_.

Felgo Live Client
+++++++++++++++++

When used locally on your computer, the Felgo Live Server talks to an instance of the Felgo Live Client. It is possible to connect more clients to each server. For instance, you can run the live client on Android and iOS devices. You can download it from `Google Play <https://play.google.com/store/apps/details?id=net.vplay.apps.QMLLive>`_ and `App Store <https://apps.apple.com/us/app/qml-live-scripting-by-felgo/id1157319191>`_ respectively.

After you install the application, make sure your device is on the same network as your PC and click on “Connect Desktop”. Your mobile device will show you the live view of your app right away. When you start changing your code you will see both the Desktop and Mobile versions updated instantaneously.

IMAGE IMAGE IMAGE

One nice aspect of Felgo Hot Reload is that you can deploy it on multiple connected device at once. This way, you can test test many different configurations of screen sizes, DPIs and styles at the same time. You can even deploy your application on an iOS device without having access to an Apple computer.

How does it Actually Work?
++++++++++++++++++++++++++

Most QML applications are layeres. They have a QML and Javascript layer running in the QML engine, sitting on top of the Qt/C++ layer. The Felgo SDK adds the Felgo Live Module component and the Felgo Live Server, interacting with the module.

IMAGE IMAGE IMAGE

The Live Server monitors your QML, JS and assets files. When they change, it sends the updated tree to the Felgo Live Module. The module takes care of comparing the current tree of QML components with the new one and updates the subtrees which have changed, preserving the state of every other property.

Custom Clients
++++++++++++++

The Felgo Live Server operates by transmitting changed QML, JS and asset files to the Live Client. However, C++ code always requires compilation which is why the Live Client cannot support custom C++ out of the box. All your native C++ classes need to be built into the application. 

The way to solve this with the Felgo SDK is to integrate the Felgo Live Module to your own project. This essentially turns your own app into a custom Live Client that supports QML Hot Reload. The code needed for this is trivial.

First, you need to add the ``felgo-live`` module to your Qt ``CONFIG`` in your project::

    CONFIG += felgo-live

The include ``FelgoLiveClient``in your ``main.cpp``::

    #include <FelgoLiveClient>

And finally, instead of loading your QML root file, use the live client to configure the ``QQmlEngine`` instance by replacing::

    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
    engine.load(QUrl(felgo.mainQmlFileName()));

With::

    FelgoLiveClient liveClient(&engine);

The line above creates a ``FelgoLiveClient`` instance, which handles loading the QML, but also updating of the QML inside the running engine when the code changes.

Now build and run the application for any Qt platform and you have a custom Felgo Live Client that you can connect to your Felgo Live Server. The application includes all your C++ code, while allowing you to use Hot Reload for the QML code.

When you are ready for release just revert the ``main.cpp`` file back the way and remove the Live Client Module. You can do this using a define that you use when calling ``qmake``. That way you can use an ``ifdef`` to avoid having two different versions of ``main.cpp``, but instead configure the build environment in Qt Creator to include or exclude the live client functionality.

Cloud Builds
------------



    
Configuring Felgo Plugins
=========================

.. literalinclude:: src/snippets/license-key-app.qml

.. literalinclude:: src/snippets/license-key-pro.pro
    :language: bash

Monetization, Ads and In-App Purchases
======================================

Ad Monetization
---------------
    
.. literalinclude:: src/snippets/ad-banner.qml

.. literalinclude:: src/snippets/ad-full-screen.qml

In-App Purchases
----------------

.. literalinclude:: src/snippets/in-app-purchases.qml

Notifications
=============

Local Notifications
-------------------

.. literalinclude:: src/snippets/local-notifications.qml

.. literalinclude:: src/snippets/local-notifications-js-qml

Remote Push Notifications
-------------------------

.. literalinclude:: src/snippets/remote-notifications.qml

.. literalinclude:: src/snippets/remote-notifications-curl.sh
    :language: bash

.. literalinclude:: src/snippets/remote-notifications-tag-curl.sh 
    :language: bash

Analytics and Crash Reporting
=============================
    
.. literalinclude:: src/snippets/amplitude.qml

Firebase: Authentication, Databases, and Storage
================================================

.. literalinclude:: src/snippets/database.qml

Authentication
--------------

.. literalinclude:: src/snippets/firebase-authentication.qml

Firebase Database
-----------------

.. literalinclude:: src/snippets/firebase-setuservalue.qml

.. literalinclude:: src/snippets/firebase-getuservalue.qml

Realtime Database
-----------------

Cloud Storage, Augmented Reality, and More
==========================================

Summary
=======
