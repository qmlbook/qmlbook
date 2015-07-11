=============
Quick Starter
=============

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_

.. issues:: ch04

.. note::

    Last Build: |today|

    The source code for this chapter can be found in the `assets folder <../../assets>`_.


This chapter provides an overview of QML, the declarative user interface language used in Qt 5. We will discuss the QML syntax, which is a tree of elements, followed by an overview of the most important basic elements. Later we will briefly look at how to create our own elements, called components and how to transform elements using property manipulations. Towards the end we will look how to arrange elements together in a layout and finally have a look at elements where the user can provide input.

QML Syntax
==========

.. issues:: ch04

.. index:: qmlscene, properties, scripting, binding, syntax

QML is a declarative language used to describe the user interface of your application. It breaks down the user interface into smaller elements, which can be combined to components. QML describes the look and the behavior of these user interface elements. This user interface description can be enriched with JavaScript code to provide simple but also more complex logic. In this perspective it follows the HTML-JavaScript pattern but QML is designed from the ground up to describe user interfaces not text-documents.

In its simplest way QML is a hierarchy of elements. Child elements inherit the coordinate system from the parent. A ``x,y`` coordinate is always relative to the parent.

.. image:: assets/scene.png

Let's start with a simple example of a QML file to explain the different syntax.

.. literalinclude:: src/concepts/rectangle.qml
    :start-after: M1>>
    :end-before: <<M1

* The ``import`` statement imports a module in a specific version. In general you always want to import *QtQuick 2.0* as your initial set of elements
* Comments can be made using ``//`` for single line comments or ``/* */`` for multi-line comments. Just like in C/C++ and JavaScript
* Every QML file needs to have exactly one root element, like HTML
* An element is declared by its type followed by ``{ }``
* Elements can have properties, they are in the form ``name : value``
* Arbitrary elements inside a QML document can be accessed by using their ``id`` (an unquoted identifier)
* Elements can be nested, means a parent element can have child elements. The parent element can be accessed using the ``parent`` keyword

.. tip::

    Often you want to access a particular element by id or a parent element using the ``parent`` keyword. So it’s good practice to name your root element root using ``id: root``. Then you don't have to think about how the root element is named in your QML document.

.. hint::

    You can run the example using the Qt Quick runtime from the command line from your OS like this::

        $ $QTDIR/bin/qmlscene rectangle.qml

    Where you need to replace the *$QTDIR* to the path to your Qt installation. The *qmlscene* executable initializes the Qt Quick runtime and interprets the provided QML file.

    In Qt Creator you can open the corresponding project file and run the document ``rectangle.qml``.

Properties
----------

.. issues:: ch04

Elements are declared by using their element name but are defined by using their properties or by creating custom properties. A property is a simple key-value pair, e.g. ``width : 100``, ``text: 'Greetings'``, ``color: '#FF0000'``. A property has a well-defined type and can have an initial value.

.. literalinclude:: src/concepts/properties.qml
    :start-after: M1>>
    :end-before: <<M1

Let's go through the different features of properties:

(1) ``id`` is a very special property-like value, it is used to reference elements inside a QML file (called document in QML). The ``id`` is not a string type but rather an identifier and part of the QML syntax. An ``id`` needs to be unique inside a document and it can't be re-set to a different value, neither be queried. (It behaves more like a pointer in the C++ world.)

(2) A property can be set to a value, depending on its type. If no value is given for a property, an initial value will be chosen. You need to consult the documentation of the particular element for more information about the initial value of a property.

(3) A property can depend on one or many other properties. This is called *binding*. A bound property is updated, when its dependent properties change. It works like a contract, in this case the ``height`` should always be two times the ``width``.

(4) Adding own properties to an element is done using the ``property`` qualifier followed by the type, the name and the optional initial value (``property <type> <name> : <value>``). If no initial value is given a system initial value is chosen.

    .. note:: You can also declare one property to be the default property if no property name is given by prep-ending the property declaration with the ``default`` keyword. This is used for example when you add child elements, the child elements are added automatically to the default property ``children`` of type list if they are visible elements.

(5) Another important way of declaring properties is using the ``alias`` keyword (``property alias <name> : <reference>``). The ``alias`` keyword allows us to forward a property of an object or an object itself from within the type to an outer scope. We will use this technique later when defining components to export the inner properties or element ids to the root level. A property alias does not need a type, it uses the type of the referenced property or object.

(6) The ``text`` property depends on the custom property ``times`` of type int. The ``int`` based value is automatically converted to a ``string`` type. The expression itself is another example of binding and results into the text being updated every time the ``times`` property changes.

(7) Some properties are grouped properties. This feature is used when a property is more structured and related properties should be grouped together. Another way of writing grouped properties is ``font { family: "Ubuntu"; pixelSize: 24 }``.

(8) Some properties are attached to the element itself. This is done for global relevant elements which appear only once in the application (e.g. keyboard input). The writing is ``<Element>.<property>: <value>``.

(9) For every property you can provide an signal handler. This handler is called after the property changes. For example here we want to be notified whenever the height changes and use the built-in console to log a message to the system.

.. warning:: An element id should only be used to reference elements inside your document (e.g. the current file). QML provides a mechanism called dynamic-scoping where later loaded documents overwrite the element id's from earlier loaded documents. This makes it possible to reference element id's from earlier loaded documents, if they are not yet overwritten. It's like creating global variables. Unfortunately this leads normally to really bad code in practice, where the program depends on the order of execution. Unfortunately this can't be turned off. Please only use this with care or even better don't use this mechanism at all. It's better to export the element you want to provide to the outside world using properties on the root element of your document.

Scripting
---------

.. issues:: ch04

QML and JavaScript (also known as EcmaScript) are best friends. In the *JavaScript* chapter we will go into more detail on this symbiosis. Currently we just want to make you aware about this relationship.

.. literalinclude:: src/concepts/scripting.qml
    :start-after: M1>>
    :end-before: <<M1

(1) The text changed handler ``onTextChanged`` prints the current text every-time the text changed due to a space-bar key pressed

(2) When the text element receives the space-bar key (because the user pressed the space-bar on the keyboard) we call a JavaScript function ``increment()``.

(3) Definition of a JavaScript function in the form of ``function <name>(<parameters>) { ... }``, which increments our counter ``spacePressed``. Every time ``spacePressed`` is incremented bound properties will also be updated.

.. note::

    The difference between the QML ``:`` (binding) and the JavaScript ``=`` (assignment) is, that the binding is a contract and keeps true over the lifetime of the binding, whereas the JavaScript assignment (``=``) is a one time value assignment.
    The lifetime of a binding ends, when a new binding is set to the property or even when a JavaScript value is assigned is to the property. For example a key handler setting the text property to an empty string would destroy our increment display::

        Keys.onEscapePressed: {
            label.text = ''
        }

    After pressing escape, pressing the space-bar will not update the display anymore as the previous binding of the ``text`` property (*text: "Space pressed: " + spacePresses + " times"*) was destroyed.

    When you have conflicting strategies to change a property as in this case (text updated by a change to a property increment via a binding and text cleared by a JavaScript assignment) then you can't use binding! You need to use assignment on both property change paths as the binding will be destroyed by the assignment (broken contract!).

Basic Elements
==============

.. issues:: ch04

.. index:: Item, Rectangle, Text, MouseArea, Image, gradients

Elements can be grouped into visual and non-visual elements. A visual element (like the ``Rectangle``) has a geometry and normally present an area on the screen. A non-visual element (like a ``Timer``) provides general functionality, normally used to manipulate the visual elements.

Currently we will focus on the fundamental visual elements, such as ``Item``, ``Rectangle``, ``Text``, ``Image`` and ``MouseArea``.

Item Element
------------

.. issues:: ch04

``Item`` is the base element for all visual elements as such all other visual elements inherit from ``Item``. It doesn't paint anything by itself but defines all properties which are common across all visual elements:

.. list-table::
    :widths: 20,80
    :header-rows: 1

    *   - Group
        - Properties
    *   - Geometry
        - ``x`` and ``y`` to define the top-left position, ``width`` and ``height`` for the expand of the element and also the ``z`` stacking order to lift elements up or down from their natural ordering
    *   - Layout handling
        - ``anchors`` (left, right, top, bottom, vertical and horizontal center) to position elements relative to other elements with their ``margins``
    *   - Key handling
        - attached ``Key`` and ``KeyNavigation`` properties to control key handling and the input ``focus`` property to enable key handling in the first place
    *   - Transformation
        - ``scale`` and ``rotate`` transformation and the generic ``transform`` property list for *x,y,z* transformation and their ``transformOrigin`` point
    *   - Visual
        - ``opacity`` to control transparency, ``visible`` to show/hide elements, ``clip`` to restrain paint operations to the element boundary and ``smooth`` to enhance the rendering quality
    *   - State definition
        - ``states`` list property with the supported list of states and the current ``state`` property as also the ``transitions`` list property to animate state changes.

To better understand the different properties we will try to introduce them throughout this chapter in context of the element presented. Please remember these fundamental properties are available on every visual element and work the same across these elements.

.. note::

    The ``Item`` element is often used as a container for other elements, similar to the *div* element in HTML.

Rectangle Element
-----------------

.. issues:: ch04

The ``Rectangle`` extends ``Item`` and adds a fill color to it. Additionally it supports borders defined by ``border.color`` and ``border.width``. To create rounded rectangles you can use the ``radius`` property.

.. literalinclude:: src/concepts/rectangle2.qml
    :start-after: M1>>
    :end-before: <<M1

.. image:: assets/rectangle2.png

.. note::

    The named colors used are colors from the SVG color names (see  http://www.w3.org/TR/css3-color/#svg-color). You can provide colors in QML in different ways the most common ways are as RGB string ('#FF4444') or as a color name (e.g. 'white').

Besides a fill color and a border the rectangle also supports custom gradients.


.. literalinclude:: src/concepts/rectangle3.qml
    :start-after: M1>>
    :end-before: <<M1

.. image:: assets/rectangle3.png

A gradient is defined by a series of gradient stops. Each stop has a position and a color. The position marks the position on the y-axis (0 = top, 1 = bottom). The color of the ``GradientStop`` marks the color at that position.

.. note::

    A rectangle with no *width/height* set will not be visible. This happens often when you have several rectangles width (height) depending on each other and something went wrong in your composition logic. So watch out!

.. note::

    It is not possible to create an angled gradient. For this it's better to use predefined images. One possibility would be to just rotate the rectangle with the gradient, but be aware the geometry of an rotated rectangle will not change and thus will lead to confusion as the geometry of the element is not the same as the visible area. From the authors perspective it's really better to use designed gradient images in that case.

Text Element
------------

.. issues:: ch04

To display text you can use the ``Text`` element. Its most notable property is the ``text`` property of type ``string``. The element calculates its initial width and height based on the given text and the font used. The font can be influenced using the font property group (e.g. ``font.family``, ``font.pixelSize``, ...). To change the color of the text just use the color property.

.. literalinclude:: src/concepts/text.qml
    :start-after: M1>>
    :end-before: <<M1

|

.. image:: assets/text.png

Text can be aligned to each side and the center using the ``horizontalAlignment`` and ``verticalAlignment`` properties. To further enhance the text rendering you can use the ``style`` and ``styleColor`` property , which allows you render the text in outline, raised and sunken mode. For longer text you often want to define a *break* position like *A very ... long text*, this can be achieved using the ``elide`` property. The ``elide`` property allows you to set the elide position to the left, right or middle of your text. In case you don't want the '...' of the elide mode to appear but still want to see the full text you can also wrap the text using the ``wrapMode`` property (works only when width is explicitly set)::

    Text {
        width: 40; height: 120
        text: 'A very long text'
        // '...' shall appear in the middle
        elide: Text.ElideMiddle
        // red sunken text styling
        style: Text.Sunken
        styleColor: '#FF4444'
        // align text to the top
        verticalAlignment: Text.AlignTop
        // only sensible when no elide mode
        // wrapMode: Text.WordWrap
    }

A ``Text`` element only displays the given text. It does not render any background decoration. Besides the rendered text the ``Text`` element is transparent. It's part of your overall design to provide a sensible background to the text element.

.. note::

    Be aware a ``Text`` initial width (height) is depending on the text string and on the font set. A ``Text`` element with no width set and no text will not be visible, as the initial width will be 0.

.. note::

    Often when you want to layout ``Text`` elements you need to differentiate between aligning the text inside the ``Text`` element boundary box or to align the element boundary box itself. In the former you want to use the ``horizontalAlignment`` and ``verticalAlignment`` properties and in the later case you want to manipulate the element geometry or use anchors.

Image Element
-------------

.. issues:: ch04

An ``Image`` element is able to display images in various formats (e.g. PNG, JPG, GIF, BMP). *For the full list of supported image formats, please consult the Qt documentation*. Besides the obvious ``source`` property to provide the image URL it contains a ``fillMode`` which controls the resizing behavior.

.. literalinclude:: src/concepts/image.qml
    :start-after: M1>>
    :end-before: <<M1

.. image:: assets/image.png

.. note::

    An URL can be a local path with forward slashes ( "./images/home.png" ) or a web-link (e.g. "http://example.org/home.png").

.. note::

    ``Image`` elements using ``PreserveAspectCrop`` should also enable the clipping to avoid image data to be rendered outside the ``Image`` boundaries. By default clipping is disabled (``clip : false``). You  need to enable clipping (``clip : true``) to restrain the painting to the elements bounding rectangle. This can be used on any visual element.

.. tip::

    Using C++ you are able to create your own image provider using :qt5:`QQmlImageProvider <qqmlimageprovider>`. This allows you to create images on the fly and threaded image loading.

MouseArea Element
-----------------

.. issues:: ch04

To interact with these elements you often will use a ``MouseArea``. Its a rectangular invisible item in where you can capture mouse events. The mouse area is often used together with a visible item to execute commands when the user interacts with the visual part.

.. literalinclude:: src/concepts/mousearea.qml
    :start-after: M1>>
    :end-before: <<M1

.. list-table::
    :widths: 50 50

    *   - .. image:: assets/mousearea1.png
        - .. image:: assets/mousearea2.png

.. note::

    This is an important aspect of Qt Quick, the input handling is separated from the visual presentation. By this it allows you to show the user an interface element, but the interaction area can be larger.

Components
==========

.. issues:: ch04

.. index:: components

A component is a reusable element and QML provides different ways to create components. But currently we are only interested in only way: A file based component. A file based component is created by placing a QML element in a file and give the file an element name (e.g. ``Button.qml``). You can use the component like every other element from the QtQuick module, in our case you would use this in your code as ``Button { ... }``.

Let's go for this example. We create a rectangle containing a text and a mouse area. This resembles a simple button and doesn't need to be more complicated for our purpose.


.. literalinclude:: src/elements/inlined_component.qml
    :start-after: M1>>
    :end-before: <<M1

The UI will look similar to this. On the left the UI in the initial state, on the right after the button has been clicked.

.. list-table::
    :widths: 50 50

    *   - .. image:: assets/button_waiting.png
        - .. image:: assets/button_clicked.png


Our task is now to extract the button UI in a reusable component. For this we shortly think about a possible API for our button. You can do this by imagine yourself how someone else should use your button. Here is my imagination::

    // my ideal minimal API for a button
    Button {
        text: "Click Me"
        onClicked: { // do something }
    }

I would like to set the text using a ``text`` property and to implement my own click handler. Also I would expect the button to have a sensible initial size, which I can overwrite (e.g. with ``width: 240`` for example).

To achieve this we create a ``Button.qml`` file and copy our button UI inside. Additionally we need to export the properties a user might want to change on the root level.

.. literalinclude:: src/elements/Button.qml
    :start-after: M1>>
    :end-before: <<M1

We have exported the text and clicked signal on the root level. Typically we name our root element root to make the referencing easier. We use the ``alias`` feature of QML, which is a way to export properties inside nested QML elements to the root level and make this available for the outside world. It is important to know, that only the root level properties can be accessed from outside this file by other components.

To use our new ``Button`` element we can simple declare it in our file. So the earlier example will become a little bit simplified.

.. literalinclude:: src/elements/reusable_component.qml
    :start-after: M1>>
    :end-before: <<M1

Now you can use as many buttons as you like in your UI by just using ``Button { ... }``. A real button could be more complex, e.g providing feedback when clicked or showing a nicer decoration.

.. note::

    Personally you could even go a step further and use an item as a root element. This prevents users to change the color of our designed button, and provides us more control about the exported API. The target should be to export a minimal API. Practically this means we would need to replace the root ``Rectangle`` with an ``Item`` and make the rectangle a nested element in the root item.

    |

    .. code-block:: js

        Item {
            id: root
            width: 116; height: 26
            
            property alias text: label.text
            signal clicked
            
            Rectangle {
                anchors.fill parent
                color: "lightsteelblue"
                border.color: "slategrey"
            }
            ...
        }

With this technique it is easy to create a whole series of reusable components.

Simple Transformations
======================

.. issues:: ch04

.. index:: Transformation, Translation, Rotation, Scaling, ClickableImage Helper, Stacking order

A transformation manipulates the geometry of an object. QML Items can in general be translated, rotated and scaled. There is a simple form of these operation and a more advanced way.

Let's start with the simple transformations. Here is our scene as our starting point.

A simple translation is done via changing the ``x,y`` position. A rotation is done using the ``rotation`` property. The value is provided in degrees (0 .. 360). A scaling is done using the ``scale`` property and a value <1 means the element is scaled down and ``>1`` means the element is scaled up. The rotation and scaling does not change your geometry. The items ``x,y`` and ``width/height`` are still the same. Just the painting instructions are transformed.

Before we show off the example I would like to introduce a little helper: The ``ClickableImage`` element. The ``ClickableImage`` is just an image with an mouse area. By this we follow a simple rule, after three times using the same code it is better to extract a component.

.. literalinclude:: src/transformation/ClickableImage.qml
    :start-after: M1>>
    :end-before: <<M1


.. image:: assets/rockets.png

We use our clickable image to present three rockets. Each rocket performs a simple transformation when clicked. Clicking the background will reset the scene.


.. literalinclude:: src/transformation/transformation.qml
    :start-after: M1>>
    :end-before: <<M1

.. image:: assets/rockets_transformed.png

Rocket-1 increments the x-position by 5 px on each click and rocket-2 will continue to rotate on each click. Rocket-3 will rotate and scale the image down on each click. For the scaling and rotation operation we set ``smooth: true`` to enable anti-aliasing, which is switched off (same as the clipping property ``clip``) for performance reasons. When you see in your own work some rasterized edges in your graphics, then probably you would like to switch smooth on.


.. note::

    To achieve better visual quality when scaling images it is recommended to scale images down instead of up. Scaling an image up with a larger scaling factor will result into scaling artifacts (blurred image). When scaling an image you should consider using ``smooth : true`` to enable the usage of a higher quality filter.


The background clicker ``MouseArea`` covers the whole background and resets the rocket values.

.. note::

    Elements which appear earlier in the code have a lower stacking order (called z-order). If you click long enough on ``rocket1`` you will see it moves below ``rocket2``. The z-order can also be manipulated by the ``z-property`` of an Item.

    .. image:: assets/order_matters.png

    This is because ``rocket2`` appears later in the code. The same applies also to mouse areas. A mouse area later in the code will overlap (an thus grab the mouse events) of a mouse area earlier in the code.

    Please remember: *The order of elements in the document matters*.

Positioning Elements
====================

.. issues:: ch04

.. index:: Row, Column, Grid, Repeater, Flow, Square Helper

There are a number of QML elements used to position items. These are called positioners and the following are provided in the QtQuick module ``Row``, ``Column``, ``Grid`` and ``Flow``. They can be seen showing the same contents in the illustration below.

.. todo: illustration showing row, grid, column and flow side by side showing four images

.. note::

    Before we go into details, let me introduce some helper elements. The red, blue, green, lighter and darker square. Each of these components contains a 48x48 pixel colorized rectangle. As reference here is the source code for the ``RedSquare``:

    .. literalinclude:: src/positioners/RedSquare.qml
        :start-after: M1>>
        :end-before: <<M1

    Please note the use of ``Qt.lighter(color)`` to produce a lighter border color based on the fill color. We will use these helpers in the next examples to make the source code more compact and hopefully readable. Please remember each rectangle is initial 48x48 pixel.


The ``Column`` element arranges child items into a column by stacking them on top of each other. The ``spacing`` property can be used to distance each of the child elements from each other.

.. image:: assets/column.png

.. literalinclude:: src/positioners/column.qml
    :start-after: M1>>
    :end-before: <<M1

The ``Row`` element places its child items next to each other, either from the left to the right, or from the right to the left, depending on the ``layoutDirection`` property. Again, ``spacing`` is used to separate child items.

.. image:: assets/row.png

.. literalinclude:: src/positioners/row.qml
    :start-after: M1>>
    :end-before: <<M1

The ``Grid`` element arranges its children in a grid, by setting the ``rows`` and ``columns`` properties, the number or rows or columns can be constrained. By not setting either of them, the other is calculated from the number of child items. For instance, setting rows to 3 and adding 6 child items will result in 2 columns. The properties ``flow`` and ``layoutDirection`` are used to control the order in which the items are added to the grid, while ``spacing`` controls the amount of space separating the child items.

.. image:: assets/grid.png

.. literalinclude:: src/positioners/grid.qml
    :start-after: M1>>
    :end-before: <<M1

The final positioner is ``Flow``. It adds its child items in a flow. The direction of the flow is controlled using ``flow`` and ``layoutDirection``. It can run sideways or from the top to the bottom. It can also run from left to right or in the opposite direction. As the items are added in the flow, they are wrapped to form new rows or columns as needed. In order for a flow to work, it must have a width or a height. This can be set either directly, or though anchor layouts.

.. image:: assets/flow.png

.. literalinclude:: src/positioners/flow.qml
    :start-after: M1>>
    :end-before: <<M1

An element often used with positioners is the ``Repeater``. It works like a for-loop and iterates over a model. In the simplest case a model is just a value providing the amount of loops.

.. image:: assets/repeater.png

.. literalinclude:: src/positioners/repeater.qml
    :start-after: M1>>
    :end-before: <<M1

In this repeater example, we use some new magic. We define our own color property, which we use as an array of colors. The repeater creates a series of rectangles (16, as defined by the model). For each loop he creates the rectangle as defined as child of the repeater. In the rectangle we chose the color by using JS math functions ``Math.floor(Math.random()*3)``. This gives us a random number in the range from 0..2, which we use to select the color from our color array. As noted earlier JavaScript is a core part of Qt Quick, as such the standard libraries are available for us.

A repeater injects the ``index`` property into the repeater. It contains the current loop-index. (0,1,..15). We can use this to make our own decisions based on the index, or in our case to visualize the current index with the ``Text`` element.

.. note::

    More advanced handling of larger models and kinetic views with dynamic delegates is covered in an own model-view chapter. Repeaters are best used when having a small amount of static data to be presented.

Layout Items
============

.. issues:: ch04

.. index:: anchors

.. todo:: do we need to remove all uses of anchors earlier?

QML provides a flexible way to layout items using anchors. The concept of anchoring is part of the ``Item`` fundamental properties and available to all visual QML elements. An anchors acts like a contract and is stronger than competing geometry changes. Anchors are expressions of relativeness, you always need a related element to anchor with.

.. image:: assets/anchors.png

An element has 6 major anchor lines (top, bottom, left, right, horizontalCenter, verticalCenter). Additional there is the baseline anchor for text in Text elements. Each anchor line comes with an offset. In the case of top, bottom, left and right they are called margins. For horizontalCenter, verticalCenter and baseline they are called offsets.

.. image:: assets/anchorgrid.png

#. An element fills a parent element

    .. literalinclude:: src/anchors/anchors.qml
        :start-after: M1>>
        :end-before: <<M1


#. An element is left aligned to the parent

    .. literalinclude:: src/anchors/anchors.qml
        :start-after: M2>>
        :end-before: <<M2

#. An element left side is aligned to the parents right side

    .. literalinclude:: src/anchors/anchors.qml
        :start-after: M3>>
        :end-before: <<M3

#. Center aligned elements. ``Blue1`` is horizontal centered  on the parent. ``Blue2`` is also horizontal centered but on ``Blue1`` and it's top is aligned to the ``Blue1`` bottom line.

    .. literalinclude:: src/anchors/anchors.qml
        :start-after: M4>>
        :end-before: <<M4


#. An element is centered on a parent element

    .. literalinclude:: src/anchors/anchors.qml
        :start-after: M5>>
        :end-before: <<M5


#. An element is centered with an left-offset on a parent element using horizontal and vertical center lines

    .. literalinclude:: src/anchors/anchors.qml
        :start-after: M6>>
        :end-before: <<M6

.. note:: Our squares have been enhanced to enable dragging. Try the example and drag around some squares. You will see that (1) can't be dragged as it's anchored on all sides, sure you can drag the parent of (1) as it's not anchored at all. (2) can be vertically dragged as only the left side is anchored. Similar applies to (3). (4) can only be dragged vertically as both squares are horizontal centered. (5) is centered on the parent and as such can't be dragged, similar applies to (7). Dragging an element means changing their ``x,y`` position. As anchoring is stronger than geometry changes such as ``x,y`` changes dragging is restricted by the anchored lines. We will see this effect later when we discuss animations.

Input Elements
==============

.. issues:: ch04

.. index:: TextInput, TextEdit, FocusScope, focus, Keys, KeyNavigation

We have used already the ``MouseArea`` as mouse input element. Here we would like to focus more on the keyboard input possibilities. We start off with the text editing elements: ``TextInput`` and ``TextEdit``.

TextInput
---------

.. issues:: ch04


The ``TextInput`` allows the user to enter a line of text. The element supports input constraints such as ``validator`` and ``inputMask`` as also an ``echoMode``.

.. literalinclude:: src/input/textinput.qml
    :start-after: M1>>
    :end-before: <<M1

.. image:: assets/textinput.png

The user can click inside a ``TextInput`` to change the focus. To support switching the focus by keyboard, we can use the ``KeyNavigation`` attached property.

.. literalinclude:: src/input/textinput2.qml
    :start-after: M1>>
    :end-before: <<M1

The ``KeyNavigation`` attached property supports a preset of navigation keys where an element id is bound to switch focus on the given key press.

A text input element comes with no visual presentation besides a blinking cursor and the entered text. For the user to be able to recognize the element as an input element it needs some visual decoration, for example a simple rectangle. When placing the ``TextInput`` inside an element you need to ensure to export the major properties you want others be able to access.

We move this piece of code into our own component called ``TLineEditV1`` for reuse.

.. literalinclude:: src/input/TLineEditV1.qml
    :start-after: M1>>
    :end-before: <<M1

.. note::

    If you like to export the ``TextInput`` completely you can export the element by using ``property alias input: input``. The first ``input`` is the property name, where the 2nd input is the element id.


We rewrite our ``KeyNavigation`` example with the new ``TLineEditV1`` component.

.. code-block:: js

    Rectangle {
        ...
        TLineEditV1 {
            id: input1
            ...
        }
        TLineEditV1 {
            id: input2
            ...
        }
    }

.. image:: assets/textinput3.png

And try the tab key for navigation. You will experience the focus does not change to ``input2``. The simple use of ``focus:true`` is not sufficient. The problem arises, that the focus was transferred to the ``input2`` element the top-level item inside the TlineEditV1 (our Rectangle) received focus and did not forward the focus to the TextInput. To prevent this QML offers the FocusScope.

FocusScope
----------

.. issues:: ch04

A focus scope declares that the last child element with ``focus:true`` receives the focus if the focus scope receives the focus. So it's forward the focus to the last focus requesting child element. We will create a 2nd version of our TLineEdit component called TLineEditV2 using the focus scope as root element.

.. literalinclude:: src/input/TLineEditV2.qml
    :start-after: M1>>
    :end-before: <<M1

And our example will now look like this:

.. code-block:: js

    Rectangle {
        ...
        TLineEditV2 {
            id: input1
            ...
        }
        TLineEditV2 {
            id: input2
            ...
        }
    }

Pressing the tab key now successfully switches the focus between the 2 components and the correct child element inside the component is focused.


TextEdit
--------

.. issues:: ch04

The ``TextEdit`` is very similar to ``TextInput`` and support a multi-line text edit field. It misses the text constraint properties for this it provides querying the painted size of the text (``paintedHeight``, ``paintedWidth``). We also create our own component called ``TTextEdit`` to provide a edit background and use the focus scope for better focus forwarding.

.. literalinclude:: src/input/TTextEdit.qml
    :start-after: M1>>
    :end-before: <<M1

You can use it like the ``TLineEdit`` component

.. literalinclude:: src/input/textedit.qml
    :start-after: M1>>
    :end-before: <<M1

.. image:: assets/textedit.png

Keys Element
------------

.. issues:: ch04

The attached property ``Keys`` allows to execute code based on certain key presses. For example to move a square around and scale we can hook up the up, down, left and right keys to translate the element and the plus, minus key to scale the element.

.. literalinclude:: src/input/keys.qml
    :start-after: M1>>
    :end-before: <<M1

.. image:: assets/keys.png


Advanced Techniques
===================

.. issues:: ch04

.. todo:: To be written







