=========
初识 Qt 5
=========

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_

.. issues:: ch01

.. note::

    本章源代码收录于 `资源目录 <../../assets>`_。


这本书展示了通过 Qt 5.x 版本进行开发应用的各方面内容。它主要关注新的 Qt Quick 技术，但也提供了编写 C++ 后端和 Qt Quick 扩展的必要信息。

本章在较高的层面对 Qt5 进行概述，它展示了对开发者来说可行的多种开发模式，并通过一个 Qt5 示例应用作为开胃菜。另外本章力求展现更多关于 Qt 5 的概述，还提供了联系 Qt 的开发者的方法。


序言
=======

.. rubric:: 历史

Qt4 诞生于 2005 年，为成千上万的应用甚至是桌面和移动操作系统提供了坚实的基础。近年来计算机用户的使用模式改变了许多，这种改变主要是从传统的 PC 向便携笔记本和移动终端的迁移。传统的桌面程序被越来越多的基于触控操作的移动设备所取代，桌面用户体验模式也随之而变。在过去，Windows 用户界面主宰世界，但是现在我们更多地在使用配备了另一种用户界面设计语言的移动设备。

Qt4 当初被设计来为主流平台桌面程序开发提供完备的 UI 组件。因此现在 Qt 用户所面临的挑战也发生了改变，Qt 需要能开发基于触控操作的用户界面，并且适用于开发主流桌面和移动操作系统的现代化的用户界面。Qt 4.7 发布了 Qt Quick 技术，允许用户使用新的方式来创建用户界面组件集合，用于开发满足用户需求的完整用户界面。


Qt 5 特性
---------

Qt 5 重新定义了 Qt。截至 Qt 4.8，Qt 4 版本已经发展了近 7 年了。Qt 5 带来了更多惊喜，主要聚焦于以下方面：

* **出色的图形绘制**: Qt Quick 2 基于 OpenGL (ES)，采用场景图形实现。重组的图形堆栈带来了更好的图形特效，并且在易用性方面出类拔萃。

* **开发效率**: Qt 5 使用 QML 和 JavaScript 作为用户界面创建的主要工具，其后端由 C++ 驱动。JavaScript 和 C++ 的去耦合使得快速的版本迭代成为可能，前端开发者可以专注于创建漂亮的用户界面，后端 C++ 开发者可以专注于程序的稳定性、性能和扩展。

* **跨平台移植性**: 统一的 Qt 平台抽象使得用户可以更简单和快速地将 Qt 移植到更多地平台上。Qt 5 围绕着 Qt 的基础组件和附加组件的概念进行组织，这使得操作系统开发者可以专注于基础模块的实现，从而提升程序的效率。

* **开源**: Qt 目前托管在 `qt.io <http://qt.io>`_，由开源社区驱动。

Qt 5 简介
=========


Qt Quick
--------

Qt Quick 涵盖了 Qt 5 中用户界面开发技术，包括以下几种技术：

* QML - 用户界面标记语言
* JavaScript - 动态脚本语言
* Qt C++ - 高度可移植、优化的 C++ 库

.. figure:: assets/qt5_overview.png

类似于 HTML 语言，QML 也是一种标记语言。QML 由使用类似于 ``Item {}`` 形式的、使用花括号包围的元素标签组成。QML 重新设计了用户界面的创建方式，使得开发者能够快速、简便地理解。用户界面可使用 JavaScript 来加强。Qt Quick 可以使用本地 Qt C++ 功能性实现来快速地扩展，一言概之，使用声明式的 UI 成为前端，而本地的 Qt C++ 功能实现作为后端。这样可以将应用程序中计算密集和后台操作的部分与用户界面分离开来。

典型的 Qt 5 项目中，前端开发使用QML/JaveScript，后端代码开发使用 Qt C++ 来完成和操作系统的交互以及繁重计算。这样就很自然的将设计界面的开发者和功能开发者分开了。后端开发测试使用Qt自带的单元测试框架后，将接口提供给前端开发者使用。

用户界面示例
---------------------------

现在我们使用 Qt Quick 来创建一个简单的用户界面，用于展示 QML 语言的特性。最后我们需要实现一个旋转的纸风车。


.. figure:: assets/scene.png
    :scale: 50%


我们从空文档 ``main.qml`` 开始，所有 QML 文档的后缀都是 ``.qml``。作为标记语言，QML 文档有且仅有一个根元素，在这个示例当中，根元素为具有背景图像几何尺寸的 ``Image`` 元素：


.. code-block:: qml

    import QtQuick 2.5

    Image {
        id: root
        source: "images/background.png"
    }


QML 不会限制根元素的类型，我们使用 ``source`` 属性设置为背景图片的 ``Image`` 元素作为根元素。

.. figure:: src/showcase/images/background.png


.. note::

    每个元素都可以有若干属性，例如，图片具有 ``width``, ``height`` 以及 ``source`` 等属性。图片元素可以根据图片实际尺寸自动推断出元素尺寸，也可以通过给 ``width`` 和 ``height`` 设置有效的属性值来指定。

    在第一行中使用 ``import`` 语句导入的 ``QtQuick`` 模块包含了最常用的标准元素。

    ``id`` 属性是可选值，作为元素的标识符，可以在文档中的其它地方引用。注意：``id`` 属性一旦指定不能再修改，并且不能在程序运行时动态指定。使用 ``root`` 作为根元素的 ``id`` 属性是一种常用的实践，这样可以在规模较大的 QML 文档中明确地引用最顶层的元素。

纸风车的杆和车轮作为相互独立的前景元素：

.. figure:: src/showcase/images/pole.png
.. figure:: src/showcase/images/pinwheel.png

杆需要垂直放置在背景的水平中心位置，车轮放置于背景的中心位置。

通常用户界面由许多不同类型的元素组成，而不仅仅是本例中的图片元素。

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

为了使车轮在中心位置，我们使用到 ``anchor`` （锚点）属性。锚点用于指定子元素与父元素之间的相对几何关系。例如，放置于另一个元素的中心位置（``anchors.centerIn: parent``）。另外还有 ``left``、``right``、``top``、``bottom``、 ``centerIn``、``fill``、``verticalCenter`` 以及 ``horizontalCenter``等关系描述方式。注意到，这些描述需要是有意义的匹配，例如，子元素的左侧和父元素的上侧是无法匹配的。

通过上面的代码，我们将车轮放置于父元素（背景）的中心。

.. note::

    有些时候需要在中心位置的基础上做一些微调，这个时候可以使用 ``anchors.horizontalCenterOffset`` 或 ``anchors.verticalCenterOffset`` 来实现。类似的微调属性对于其他描述方式也是使用的，可以在文档中获取到完整的锚点属性。

.. note::

    将一幅图片作为子元素放置到根元素（``Image`` 元素）中，展现了声明式语言的一个重要概念。我们使用层级和分组来描述用户界面，其中最顶层的元素最先被绘制，随后在父元素的局部坐标系中绘制子元素的内容。

为了使这个示例更加有趣，我们希望描述的场景是交互性的。一个想法是在用户在场景中的某一位置点击鼠标后，旋转风车以作为响应。

我们使用 ``MouseArea`` 元素，并将其设置为和根元素相同的尺寸。

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

``MouseArea`` 会在用户在覆盖区域内点击时发出信号，我们可以覆盖 ``onClicked`` 函数来连接到此信号，在本例中我们引用车轮图像并且将其旋转 +90 度。

.. note::

    类似方法也适用于其他信号，命名规则为 ``on`` + ``SignalName``。并且所有的属性都会在其值改变时发送信号，其命名规则为：

        ``on`` + ``PropertyName`` + ``Changed``

    例如，``width`` 属性值的改变可以通过 ``onWidthChanged: print(width)`` 来观测到。

现在风车可以旋转了，但是看起来还不太平滑，因为旋转角属性瞬间就改变了。我们希望属性值的改变从 0 到 90 度随时间逐渐变化。我们可以使用动画来实现，这将用到属性行为这种动画类型。``Behaviour`` 对于某一属性值的每一次变化指定一个动画。一言概之，每次属性值改变，动画都会进行。这仅仅是 QML 中声明动画的多种方式之一。

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

现在每次风车的旋转角变化，都会使用 250ms 的动画 ``NumberAnimation`` 来实现。也就是说旋转 90 度会花费 250ms。

.. figure:: assets/scene2.png
    :scale: 50%

.. note:: 

    并不会看到风车旋转时的模糊效果，示例图仅用于表示风车在旋转。资源文件夹中有模糊版本的风车，读者可以亲自试试。

目前风车看起来漂亮多了，希望这能够给读者一个关于 Qt Quick 编程工作原理的简明概念。


Qt 构建模块
===========

Qt 5 包含了大量的模块。通常来说，模块即供开发者使用的库。某些模块对 Qt 平台来说是必选项，这些模块组成了名为 **Qt 基础模块** 的集合。除此之外还有很多模块时可选项，这些模块组成了名为 **Qt 附加模块** 的集合，虽然大部分开发者并不会用到这些模块，但是需要了解的是这些模块为一些通用的问题提供了非常有价值的解决方案。

Qt 模块
-------

Qt 基础模块对于 Qt 平台来说是强制性的必选项，其提供了使用 Qt Quick 2 开发现代化的 Qt 5 应用程序的基石。

.. rubric:: 基础核心模块

用于 QML 编程的最小化 Qt 5 模块集合。

.. list-table::
    :widths: 20 80
    :header-rows: 1

    * - 模块
      - 描述
    * - Qt Core
      - 其他模块依赖的非图形化的核心类库
    * - Qt GUI
      - 图形用户界面（GUI）组件的基础类库，包括 OpenGL。
    * - Qt Multimedia
      - 音频、视频、电台和摄像头等功能性类库
    * - Qt Network
      - 用于简化可移植网络编程的类库
    * - Qt QML
      - QML 和 JavaScript 语言类库
    * - Qt Quick
      - 构建具有自定义用户界面的高度灵活的应用程序的声明式框架
    * - Qt SQL
      - 使用 SQL 进行整合数据库的类库
    * - Qt Test
      - 用于 Qt 应用和类库单元测试的类库
    * - Qt WebKit
      - 基于 WebKit2 实现的类以及一套新的 QML API。
    * - Qt WebKit Widgets
      - Qt 4 中 WebKit1 和基于 QWidget 的类库
    * - Qt Widgets
      - 使用 C++ 组件扩展 Qt GUI 的类库


.. digraph:: essentials

    QtGui -> QtCore
    QtNetwork ->QtCore
    QtMultimedia ->QtGui
    QtQml -> QtCore
    QtQuick -> QtQml
    QtSql -> QtCore


.. rubric:: Qt 附加模块

除了基础模块之外，Qt 还提供为软件开发者提供了附加的模块，附加模块没有包含在发行版中。这里列举了一些可用的附加模块：

* Qt 3D - 简化声明式 3D 图形编程的 API 集合
* Qt Bluetooth - 针对于使用蓝牙无线技术的 C++ 和 QML API 集合
* Qt Contacts - 访问地址簿/联系人数据库的 C++ 和 QML API 集合
* Qt Location - 提供使用 QML 和 C++ 进行定位、地图、导航和地点搜索的接口。使用 NMEA 作为定位的后端。
* Qt Organizer - 组织事件（任务清单、事件等）的 C++ 和 QML API 集合
* Qt Publish and Subscribe - 发布与订阅
* Qt Sensors - 通过 QML 和 C++ 接口访问传感器
* Qt Service Framework -  允许应用程序读取、导航和订阅来改变通知信息。
* Qt System Info - 系统相关的信息和功能
* Qt Versit - vCard 和 iCalendar 格式支持
* Qt Wayland - 针对于 Linux，包含了 Qt Compositor API（服务器）和 Wayland 平台插件（客户端）
* Qt Feedback - 用户行为的触感和音频反馈
* Qt JSON DB - NoSQL 对象存储

.. note::

    因为这些模块不作为发行版的一部分，这些模块目前的情况各异，主要取决于活跃贡献者的数量以及其测试情况。

平台支持
--------

Qt 支持多种平台。所有的主流桌面和嵌入式平台都支持。若有需要，通过 Qt 应用程序抽象，将 Qt 移植到自己的平台上也更加容易。 

在某一平台上测试 Qt 5 是非常耗时的。Qt Project 选择了一个平台子集用于构建参考平台集合，这些平台经过了全面的系统测试，以保证最佳品质。即便如此，还是需要提醒一句：不存在完全没有问题的代码。

Qt 项目
=======

摘自 `Qt 项目维基 <http://wiki.qt.io/>`_:

Qt 项目是对 Qt 感兴趣的人达成共识的社区。任何对 Qt 感兴趣的人都可以加入社区，参与到其决策中，并且向 Qt 的开发做出贡献。

Qt 项目是一个开发 Qt 后续版本中的开源部分的组织。Qt 项目为其他用户的贡献提供了基础。目前最大的贡献者是 DIGIA，其拥有 Qt 的商业授权。

Qt 对于企业来说包括开源分支和商业分支。使用商业分支的公司不需要遵守开源协议。如果没有商业分支，这些公司将不能使用 Qt，并且 DIGIA 也不能向 Qt 项目贡献如此多的代码。

在全球有很多在不同的平台上使用Qt开发产品和提供咨询的公司。同样也有很多使用Qt作为它们的开发库的开源项目和开源开发者。成为如此活跃的社区的一部分并且使用如此优秀的工具和库，是振奋人心的事情。或许能让你成为一个更好的人？也许吧:-)。

**在这里为项目做出贡献：http://wiki.qt.io/**。