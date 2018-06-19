=======
入门基础
=======

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_

.. issues:: ch02

.. |creatorrun| image:: assets/qtcreator-run.png

这一章会介绍如何使用 Qt 5 进行开发。我们将展示如何安装 Qt SDK 以及如何使用 Qt Creator 集成开发环境创建和运行简单的 *hello world* 应用。

.. note::

    本章源代码收录于 `资源目录 <../../assets>`_。


安装 Qt 5 SDK
============

.. issues:: ch02

Qt SDK 包含了构建桌面或嵌入式应用的工具，其最新版本可在 `Qt主页 <http://qt.io>`_ 上下载。可以选择离线安装和在线安装两种方式。作者本人更喜欢并推荐读者使用在线安装方式，因为在线安装可以一并安装和更新 Qt 发行版。SDK 本身包含一个维护工具用于更新SDK到最新版本。

Qt SDK 安装简便，并附带了用于快速开发的集成开发环境 - *Qt Creator*，其开发效率非常高，推荐所有用户使用它进行 Qt 开发。当然也有许多开发者在命令行环境中使用 Qt，并且使用自己喜欢的文本编辑器编写代码。

在安装 SDK 时，用户最好选择默认选项以确保 Qt 5.x 部署到位，然后我们就可以开始了。

Hello World
===========

.. issues:: ch02

为了验证安装，我们先创建一个 *hello world* 应用。打开 Qt Creator，创建一个 Qt Quick UI 项目（ :menuselection:`File --> New File or Project --> Qt Quick Project --> Qt Quick UI` ），项目名称为``HelloWorld``。

.. note::

    Qt Creator 可以创建多种类型的应用。后文若没有明确说明，均使用 :guilabeL:`Qt Quick UI` 项目类型。

.. hint::

    一个典型的 Qt Quick 应用由可以加载 QML 代码的 ``QmlEngine`` 在运行时创建。开发者可以使用 C++ 接口绑定本地的代码。C++ 程序也可以封装到插件中，然后使用 ``import`` 语句动态加载。``qmlscene`` 和 ``qml`` 是已经预编译的运行时工具，可以直接使用。在入门阶段，我们暂时不涉及到本地端的开发，而是聚焦于 Qt 5 的 QML 这一块。

Qt Creator 会自动创建若干项目文件，项目文件 ``HelloWorld.qmlproject`` 保存了项目配置信息，这个文件由 Qt Creator 管理，最好不要手动编辑。

另外，``HelloWorld.qml`` 文件是应用代码，打开并试着看看这个应用做了什么，往下阅读代码。

.. code-block:: js

    // HelloWorld.qml

    import QtQuick 2.5

    Rectangle {
        width: 360
        height: 360
        Text {
            anchors.centerIn: parent
            text: "Hello World"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.quit();
            }
        }
    }

``HelloWord.qml`` 文件使用 QML 语言书写，我们将在后续章节中详细讨论 QML 语言。QML 将用户界面描述为层级元素的一个树。在示例中，创建了 360 x 360 像素大小的正方形，以及正方形中心位置的"Hello World" 文本。为了捕捉到用户的鼠标点击行为，鼠标区域覆盖了整个正方形，当用户点击鼠标时，应用将会退出。

点击界面上的 |creatorrun| :guilabel:`Run` 来运行应用，这个按钮在界面的左侧，或者可以在 :menuselection:`Build --> Run` 菜单中找到。

Qt Creator 启动 ``qmlscene`` 并且将 QML 文档作为第一个参数传给它，随后 ``qmlscene`` 会解析文档并加载用户界面。应用程序看起来差不多是这个样子：

.. figure:: assets/example.png
    :scale: 50%

看来来 Qt 5 没什么问题，我们可以继续往下看。

.. tip::

    如果你是系统集成人员，你不仅需要安装最新稳定版本的 Qt，还需要针对特定的目标设备编译源代码以得到可以运行在目标机器上的二进制版本。

.. topic:: 构建源代码

    如果你想在命令行中编译 Qt 5，首先你得从代码仓库中把源代码抓取下来。

    .. code-block:: sh

        git clone git://gitorious.org/qt/qt5.git
        cd qt5
        ./init-repository
        ./configure -prefix $PWD/qtbase -opensource
        make -j4


    差不多过两柱香的时间，Qt 5 就会被成功编译到 ``qtbase`` 目录中。当然喝两杯咖啡或者其它饮料也是可以的，喝咖啡的话编译成功的可能性要大一点。

    为了验证编译，运行 ``qtbase/bin/qmlscene`` 并选择一个 Qt Quick 示例看看能否运行，没问题的话可以跳到下一节了。

    为了验证安装，我们先创建一个小型的 hello world 应用，使用你最喜爱的文本编辑器创建一个  ``example.qml`` 文件，把下面的代码粘贴进去：

    .. code-block:: js

        // HelloWorld.qml

        import QtQuick 2.5

        Rectangle {
            width: 360
            height: 360
            Text {
                anchors.centerIn: parent
                text: "Greetings from Qt 5"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.quit();
                }
            }
        }

    现在你可以通过 Qt 5 默认的运行时来运行示例::

        $ qtbase/bin/qmlscene

应用类型
=======

.. issues:: ch02

这一节列举了 Qt 5 支持的不同应用类型，虽然可能并没有完全覆盖所有内容，但是应该能使得读者对于 Qt 5 有更好的了解。

控制台应用
--------

.. issues:: ch02

控制台程序没有图形用户界面，通常作为系统服务的一部分或者在命令行中调用。Qt 5 具有一系列现成的组件，用于帮助用户高效地创建跨平台的控制台应用。例如，网络编程接口以及字符串编程接口，以及 Qt 5.1 版本引入的高效命令行参数解析器。因为 Qt 是建立在 C++ 上的高级 API，用户既能快速编程，也能保证程序的运行效率。千万别以为 Qt 仅仅是用户界面组件，它可以做的还多着呢。

.. rubric:: 字符串处理

首先我们展示如何拼接两个字符串常量，这虽然没什么用，却可以展示一个没有事件循环的本地 C++ 应用程序看起来是什么样的。

.. code-block:: cpp

    // module or class includes
    #include <QtCore>

    // text stream is text-codec aware
    QTextStream cout(stdout, QIODevice::WriteOnly);

    int main(int argc, char** argv)
    {
        // avoid compiler warnings
        Q_UNUSED(argc)
        Q_UNUSED(argv)
        QString s1("Paris");
        QString s2("London");
        // string concatenation
        QString s = s1 + " " + s2 + "!";
        cout << s << endl;
    }

.. rubric:: 容器类

这个示例使用了链表和链表迭代器，Qt 附带了大量易用的容器类，并且和其他 Qt 类一样，使用了统一的 API 模式。

.. code-block:: cpp

    QString s1("Hello");
    QString s2("Qt");
    QList<QString> list;
    // stream into containers
    list <<  s1 << s2;
    // Java and STL like iterators
    QListIterator<QString> iter(list);
    while(iter.hasNext()) {
        cout << iter.next();
        if(iter.hasNext()) {
            cout << " ";
        }
    }
    cout << "!" << endl;

接着我们展示一些高级的链表函数，允许用户将字符串链表的元素组合成单一的字符串。这在处理行文本输入时特别方便，其逆操作可以使用 ``QString::split()`` 函数来实现（字符串转换为链表）。

.. code-block:: cpp


    QString s1("Hello");
    QString s2("Qt");
    // convenient container classes
    QStringList list;
    list <<  s1 << s2;
    // join strings
    QString s = list.join(" ") + "!";
    cout << s << endl;


.. rubric:: 文件 IO

下面我们会从本地目录中读取一个 CSV 文件，并且遍历每一行，从其中提取信息单元。CSV 文件中大概能读取出20行文本。文件读取将会返回一个比特流，为了将其转换为有效的 Unicode 文本，我们需要使用文本流，并且将文件作为底层流数据传递。写 CSV 文件只需要以只写模式打开文件，然后把文本一行一行地传递给文件流。

.. code-block:: cpp


    QList<QStringList> data;
    // file operations
    QFile file("sample.csv");
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        // loop forever macro
        forever {
            QString line = stream.readLine();
            // test for null string 'String()'
            if(line.isNull()) {
                break;
            }
            // test for empty string 'QString("")'
            if(line.isEmpty()) {
                continue;
            }
            QStringList row;
            // for each loop to iterate over containers
            foreach(const QString& cell, line.split(",")) {
                row.append(cell.trimmed());
            }
            data.append(row);
        }
    }
    // No cleanup necessary.

关于 Qt 的控制台应用编程，我们暂时告一段落。

窗口部件应用
----------

.. issues:: ch02

控制台程序开发起来简单，但也少不了用户界面用于展示。反过来说，基于用户界面的应用也需要一个能够读/写文件、网络通信、数据存储的后端。

在第一个代码片段中我们仅仅创建一个窗口并展示它。在 Qt 中，没有父元素的窗口部件本身即是窗口。我们使用智能指针来确保窗口部件对象在合适的时候被删除掉。应用对象封装了 Qt 运行时，并且可以通过调用``exec()`` 开启事件循环，之后应用仅在事件被鼠标、键盘或类似于网络或文件 IO 之类的事件提供者触发时响应事件，并且仅在事件循环退出后应用才会退出。调用 ``quit()`` 或关闭窗口可以退出事件循环。

运行代码，将出现一个 240 x 120 像素大小的窗口。

.. code-block:: cpp

    #include <QtGui>

    int main(int argc, char** argv)
    {
        QApplication app(argc, argv);
        QScopedPointer<QWidget> widget(new CustomWidget());
        widget->resize(240, 120);
        widget->show();
        return app.exec();
    }

.. rubric:: 自定义部件

在与用户界面打交道的过程中可能需要创建自定义的窗口部件，一个典型的部件是填充了绘制调用的窗口区域。另外，部件本身应该知道如何去处理键盘、鼠标输入并且响应外部触发。为此，我们用自定义部件继承 `QWidget` 类并重写用于绘制和事件处理的几个函数。

.. code-block:: cpp

    #ifndef CUSTOMWIDGET_H
    #define CUSTOMWIDGET_H

    #include <QtWidgets>

    class CustomWidget : public QWidget
    {
        Q_OBJECT
    public:
        explicit CustomWidget(QWidget *parent = 0);
        void paintEvent(QPaintEvent *event);
        void mousePressEvent(QMouseEvent *event);
        void mouseMoveEvent(QMouseEvent *event);
    private:
        QPoint m_lastPos;
    };

    #endif // CUSTOMWIDGET_H


在接口实现中，我们在部件的边界绘制较窄的边界，并且在鼠标停留的最后位置绘制一个小矩形。这些操作对于底层自定义部件来说是非常典型的。鼠标或键盘事件改变部件的内部状态并触发更新绘制函数。在这一部分不必过于细究。Qt 附带了大量的开箱可用的桌面部件，有很大可能性开发者并不需要涉及到这一部分。

.. code-block:: cpp


    #include "customwidget.h"

    CustomWidget::CustomWidget(QWidget *parent) :
        QWidget(parent)
    {
    }

    void CustomWidget::paintEvent(QPaintEvent *)
    {
        QPainter painter(this);
        QRect r1 = rect().adjusted(10,10,-10,-10);
        painter.setPen(QColor("#33B5E5"));
        painter.drawRect(r1);

        QRect r2(QPoint(0,0),QSize(40,40));
        if(m_lastPos.isNull()) {
            r2.moveCenter(r1.center());
        } else {
            r2.moveCenter(m_lastPos);
        }
        painter.fillRect(r2, QColor("#FFBB33"));
    }

    void CustomWidget::mousePressEvent(QMouseEvent *event)
    {
        m_lastPos = event->pos();
        update();
    }

    void CustomWidget::mouseMoveEvent(QMouseEvent *event)
    {
        m_lastPos = event->pos();
        update();
    }

.. rubric:: 桌面部件

Qt 开发者非常关怀地提供了桌面部件集合，这些部件在不同的操作系统下可以自动调整为原生界面。用户需要做的就是将部件容器中不同的部件组织进一个更大的面板中。Qt 中的部件可以作为其他部件的容器，这种机制采用父-子部件关系实现。也就是说，我们需要将这些部件（按钮、多选框、单选框、列表、网格等）作为其他部件的子部件。一种可行的实践如下所示。

下面是部件容器的头文件。

.. code-block:: cpp

    class CustomWidget : public QWidget
    {
        Q_OBJECT
    public:
        explicit CustomWidget(QWidget *parent = 0);
    private slots:
        void itemClicked(QListWidgetItem* item);
        void updateItem();
    private:
        QListWidget *m_widget;
        QLineEdit *m_edit;
        QPushButton *m_button;
    };

在接口实现中，我们使用布局来更好地组织部件。布局管理器在容器部件的尺寸发生变化时根据尺寸规则来重新组织部件。在本例中我们需要纵向地组织列表、文本框、按钮部件，使用 Qt 的信号和信号槽机制来连接事件信号的发送对象和接收对象。

.. code-block:: cpp

    CustomWidget::CustomWidget(QWidget *parent) :
        QWidget(parent)
    {
        QVBoxLayout *layout = new QVBoxLayout(this);
        m_widget = new QListWidget(this);
        layout->addWidget(m_widget);

        m_edit = new QLineEdit(this);
        layout->addWidget(m_edit);

        m_button = new QPushButton("Quit", this);
        layout->addWidget(m_button);
        setLayout(layout);

        QStringList cities;
        cities << "Paris" << "London" << "Munich";
        foreach(const QString& city, cities) {
            m_widget->addItem(city);
        }

        connect(m_widget, SIGNAL(itemClicked(QListWidgetItem*)), this, SLOT(itemClicked(QListWidgetItem*)));
        connect(m_edit, SIGNAL(editingFinished()), this, SLOT(updateItem()));
        connect(m_button, SIGNAL(clicked()), qApp, SLOT(quit()));
    }

    void CustomWidget::itemClicked(QListWidgetItem *item)
    {
        Q_ASSERT(item);
        m_edit->setText(item->text());
    }

    void CustomWidget::updateItem()
    {
        QListWidgetItem* item = m_widget->currentItem();
        if(item) {
            item->setText(m_edit->text());
        }
    }

.. rubric:: 绘制形状

有些问题若能可视化表示的话那是坠吼的。如果当前的问题看起来有点像几何对象，Qt 图形视图是一个不错的选择。图形视图可以将简单的集合形状组织在一个场景中，用户可以与这些形状交互，形状的位置摆放通过特定算法实现。图形视图需要使用一个图形场景和一个图形视图来填充，场景连接到视图上并使用图形对象填充。这里有一个简单示例，首先是声明视图和场景的头文件。

.. code-block:: cpp

    class CustomWidgetV2 : public QWidget
    {
        Q_OBJECT
    public:
        explicit CustomWidgetV2(QWidget *parent = 0);
    private:
        QGraphicsView *m_view;
        QGraphicsScene *m_scene;

    };

在接口实现中，场景首先连接到视图。视图是一个放置于容器部件内的部件。最后我们在场景中添加一个小矩形，然后渲染到视图上。

.. code-block:: cpp

    #include "customwidgetv2.h"

    CustomWidget::CustomWidget(QWidget *parent) :
        QWidget(parent)
    {
        m_view = new QGraphicsView(this);
        m_scene = new QGraphicsScene(this);
        m_view->setScene(m_scene);

        QVBoxLayout *layout = new QVBoxLayout(this);
        layout->setMargin(0);
        layout->addWidget(m_view);
        setLayout(layout);

        QGraphicsItem* rect1 = m_scene->addRect(0,0, 40, 40, Qt::NoPen, QColor("#FFBB33"));
        rect1->setFlags(QGraphicsItem::ItemIsFocusable|QGraphicsItem::ItemIsMovable);
    }

数据适配
-------

.. issues:: ch02


目前为止我们已经了解了基本的数据类型以及如何使用窗口部件和图形视图。通常在应用中会涉及到更大量的结构型数据，需要进行持续的存储。另外，一些数据需要进行可视化。为此 Qt 使用了模型的概念。如下是一个字符串链表的简单模型，首先按位填充字符串，然后绑定到一个列表视图上。

.. code-block:: cpp

    m_view = new QListView(this);
    m_model = new QStringListModel(this);
    view->setModel(m_model);

    QList<QString> cities;
    cities << "Munich" << "Paris" << "London";
    model->setStringList(cities);

另外一种流行的存储和获取数据的思路是使用 SQL 语言，Qt 附带了 SQLite，并且支持其他数据库引擎（MySQL、PostgresSQL等）。首先需要使用模式来创建一个数据库，如下：

.. code-block:: sql

    CREATE TABLE city (name TEXT, country TEXT);
    INSERT INTO city value ("Munich", "Germany");
    INSERT INTO city value ("Paris", "France");
    INSERT INTO city value ("London", "United Kingdom");

为了使用 SQL 语言，我们需要将 ``sql`` 模块添加到 ``.pro`` 文件中。

.. code-block:: cpp

    QT += sql

然后使用 C++ 打开数据库，首先我们需要从特定的数据库引擎中获取一个新的数据库对象，使用该数据库对象即可打开数据库。对于 SQLite 来说，只需要指定数据库文件的路径即可。Qt 还提供了一些高级的数据库模型，其中一个是表模型，使用一个表标识符和一个选项分支语句来选择数据，然后像之前那样将得到的结果绑定到列表视图上。

.. code-block:: cpp

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName('cities.db');
    if(!db.open()) {
        qFatal("unable to open database");
    }

    m_model = QSqlTableModel(this);
    m_model->setTable("city");
    m_model->setHeaderData(0, Qt::Horizontal, "City");
    m_model->setHeaderData(1, Qt::Horizontal, "Country");

    view->setModel(m_model);
    m_model->select();

对于更高级的模型操作，Qt 提供了排序文件代理模型，允许用户使用基础的排序和过滤范式来操作模型。

.. code-block:: cpp

    QSortFilterProxyModel* proxy = new QSortFilterProxyModel(this);
    proxy->setSourceModel(m_model);
    view->setModel(proxy);
    view->setSortingEnabled(true);

过滤操作基于列编号和一个字符串作为数据过滤的参数。

.. code-block:: cpp

    proxy->setFilterKeyColumn(0);
    proxy->setFilterCaseSensitive(Qt::CaseInsensitive);
    proxy->setFilterFixedString(QString)

过滤代理模型比这里展示的还要强大许多，这里就此打住，知道这个东西的存在就行了。


.. note::

    前面的内容概述了使用 Qt 5 开发不同的传统应用的场景，传统的桌面程序正在向移动设备迁移，移动设备将逐渐占领了传统桌面程序的地位。移动设备的用户界面设计与桌面用户界面设计不同，要简单许多，通常只需要完成一件事情。动画是移动用户界面体验的重要一环，用户界面需要看起来更加灵动。传统的 Qt 技术并不适用于这一市场领域。

    接下来: Qt Quick 拯救世界。

Qt Quick 应用
--------------------

.. issues:: ch02

现代化的软件开发存在一个内在冲突，用户界面的迭代更新速度远胜于后端的服务程序。传统技术中前端和后端的开发步调是一致的，这将在用户需要在项目中改变用户界面或实现新的想法时导致冲突。敏捷项目开发，需要配套敏捷的方法。

Qt Quick 提供了使用类似于 HTML 的方式声明用户界面的环境，以及使用本地 C++ 代码开发后端的接口。这样在前端和后端都可以发展得游刃有余。

下面是一个简单的 Qt Quick 用户界面

.. code-block:: qml

    import QtQuick 2.5

    Rectangle {
        width: 240; height: 1230
        Rectangle {
            width: 40; height: 40
            anchors.centerIn: parent
            color: '#FFBB33'
        }
    }

如上的声明式语言称为 QML，需要使用相因的运行时来执行。Qt 提供了一个标准运行时，叫做 ``qmlscene``，同时自己实现一个运行时看起来也不是那么难。使用快速视图并设置相应的 QML 文档作为源文件，接下来就可以展示用户界面了。

.. code-block:: cpp

    QQuickView* view = new QQuickView();
    QUrl source = QUrl::fromLocalFile("main.qml");
    view->setSource(source);
    view.show();


回到我们之前的某个例子，我们使用了一个 C++ 城市数据模型，如果我们能够在QML代码中使用它那就好了。

为了实现这个目标，我们首先要编写前端代码以确定展示城市数据模型的方式。在这一个例子中前端指定了一个对象叫做 ``cityModel``，我们可以在链表视图（list view）中使用它。

.. code-block:: qml

    import QtQuick 2.5

    Rectangle {
        width: 240; height: 120
        ListView {
            width: 180; height: 120
            anchors.centerIn: parent
            model: cityModel
            delegate: Text { text: model.city }
        }
    }

为了使用 ``cityModel``，我们可以尽可能地重用之前的模型，在根内容中添加一个内容属性（根内容在主文档中）。

.. code-block:: cpp

    m_model = QSqlTableModel(this);
    ... // some magic code
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole+1] = "city";
    roles[Qt::UserRole+2] = "country";
    m_model->setRoleNames(roles);
    view->rootContext()->setContextProperty("cityModel", m_model);

.. hint::

    这里并不完全正确，因为 SQL 表包含了按列组织的数据，而 QML 模型期望的是具体的数据，所以需要有一个列数据和具体数据之间的映射表，可以参考 `QML 和 QSqlTableModel <http://wiki.qt.io/QML_and_QSqlTableModel>`_ 文档。


总结
====

.. issues:: ch02

我们已经了解到如何安装 Qt SDK 以及如何创建应用程序。然后对不同的应用类型做了一个概览，以让读者对 Qt 有一个大致的了解，并展示 Qt 在应用开发中的一些特性。希望读者对 Qt 有一个不错的印象，因为 Qt 拥有强大的用户界面工具箱，并向应用开发者提供了他们所期望的东西。当然，Qt 不会限制用户使用特定的库，而是允许开发者使用其它库来扩展 Qt。Qt 在支持不同类型的应用方面也堪称强大：对于控制台应用、经典桌面程序用户界面以及触屏用户界面等方面都表现得游刃有余。
