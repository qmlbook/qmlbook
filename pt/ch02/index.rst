===========
Primeiros passos
===========

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_

.. issues:: ch02

.. |creatorrun| image:: assets/qtcreator-run.png

Este capítulo tem como principal propósito iniciá-lo no desenvolvimento em Qt 5. Iremos mostrar como instalar o SDK do Qt, e como criar assim como correr uma aplicação do tipo “hello world” usando o IDE do Qt Creator.

.. Nota::

    O código fonte deste capítulo pode ser encontrado na pasta assets  <../../assets>`_.


Instalar o SDK do Qt 5
===================

.. issues:: ch02

O SDK do Qt inclui as ferramentas necessárias para compilar aplicações para desktop ou versões mobile. A última versão pode ser descarregada da página oficial do `Qt <http://qt.io>`_ . Existe uma versão online e offline do instalador, caso o autor prefira, num plano pessoal, usar o instalador do pacote e actualizar as várias versões do Qt. Isto será recomendado como ponto de partida. O SDK tem uma ferramenta de manutenção que permite actualizar o SDK para a versão mais recente.

O SDK do Qt é de fácil instalação e vem com o seu próprio IDE para desenvolvimento rápido denominado *Qt Creator*. O IDE é um ambiente altamente produtivo para programar em Qt e recomendado para todos os leitores. Muitos developers usam o Qt a partir da linha de comandos, o que permite editar um editor da sua preferência.

Quando instalar o SDK, seleccione a opção pré-definida e garanta-se que tem o Qt 5.x activado. Poderá então começar a desenvolver na plataforma.


Hello World
===========

.. issues:: ch02


Para testar a sua instalação, crie uma pequena aplicação do tipo **hello world**. Abra o Qt Creator e crie um Project QT Quick UI ( :menuselection:`File --> New File or Project --> Qt Quick Project --> Qt Quick UI` ) e dê-lhe o nome ``HelloWorld``.

.. nota::

O IDE do Qt Creator permite criar vários tipos de aplicações. Se não declarado, use sempre o projecto :guilabeL:`Qt Quick UI`.

.. dica::

  Uma aplicação típica de Qt Quick é composta por um runtime denominado de QmlEngine que carrega o código QML inicial. O developer pode registar tipos C++ qdos quais o runtime tira proveito com o código nativo. Estes tipos C++ podem ser algomerados num plugin e carregados dinamicamente usando um import statement. A ferramenta ``qmlscene`` e  ``qml`` são runtimes pré-construíos que podem ser usados directamente. Para começar, não iremos cobrir o aspecto de desenvolvimento nativo e desenvolvimento e vamos focar-nos nos aspectos do Qt 5.

O Qt Creator irá criar várias cópias dos ficheiros para si. O ficheiro ``HelloWorld.qmlproject`` é o ficheiro do projecto onde os projectos relevastes são configurados e armazenados. O ficheiro é gerido pelo Qt Creator, portanto, não o edite.

Outro ficheiro, o ``HelloWorld.qml``, é o nosso código de aplicaãço. Abra-o e tente adivinhar o que é que a aplicação faz e continue a lê-lo.

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

O ``HelloWord.qml`` é escrito na linguagem QML. Iremos discustir a linguagem QML em maior profundidade no próximo capítulo. O QML descreve o interface de utilizador como uma árvore hierárquica de elementos. Neste caso, o rectângulo de 360 x 360 px contém um texto centrado, onde se pode ler "Hello World". Para capturar os cliques do utilizador, uma área de rato cobre todo e rectângulo, e assim que o utilizador carrega nesta, a aplicação fecha.

Para correr a aplicação por si, por favor carregue no ícone  |creatorrun| :guilabel:`Run` do lado esquerdo e seleccione :menuselection:`Build --> Run` a partir do menu.

O Qt Creator erá começar a ``qmlscene`` e a passa o documentdo do QML como primeiro argumento. A ``qmlscene`` irá fazer parsing do documento e carregar o user interface. Derá agora ver algo idêntico ao que se vê na imagem abaixo:

.. figure:: assets/example.png
    :scale: 50%

O Qt 5 parece trabalhar e nós estaremos prontos a continuar.

.. dica::

Se for um integrado de sistem, irá querer  abrir o SDK do Qt instalado para conseguir a release mais recente e estável do Qt assim como uma versão do Qt compilada a partir do source para sua device específica.

.. topic:: Compilar de raíz

Se tiver interesse em compilar o Qt 5 a partir da linha  decomandos, tera primeiro de transferir uma cópia do repositório e compilá-la.

    .. code-block:: sh

        git clone git://gitorious.org/qt/qt5.git
        cd qt5
        ./init-repository
        ./configure -prefix $PWD/qtbase -opensource
        make -j4

Depois de uma compilação bem sucedida e 2 chavenas deé caf, o Qt 5 ira estar disponível na pasta ``qtbase``. Sugerimos, para todos os efeitos, café para melhores resultados.

Se quiser testar a sua compilação, simplesmente inicie o  ``qtbase/bin/qmlscene`` e seleccione um exemplo de Qt Quick para carrer ou siga-nos para melhores exemplos.

Para testar a sua instalação, iremos criar uma pequena aplicação do tipo hello world. Por favor cria um ficheiro simples com o nome ``example.qml`` usando o seu editor de text preferido e copie para lá o seguinte bloco de código:

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

Poderá entretanto correr o seguinte o seguinte exemplo usando o runtime pré-definidido que vem com o Qt 5::

        $ qtbase/bin/qmlscene

Tipos de Aplicação
=================

.. issues:: ch02

Esta secção trata-se de um olhar breve sobre diferentes possíveis tipos de aplicações que podem ser escritas com o Qt 5. O intuito da apresentação deste breve capítulo, prende-se apenas com o dar a entender as possibilidades da plataforma, e não limitar creativamente os utilizadores da mesma.

Aplicações de consola
-------------------

.. issues:: ch02

Uma aplicação do tipo bash não disponibiliza nenhuma forma interface gráfico, e será normalmente integrada numa para num serviço do sistema no qual é implementada. O Qt 5 vem com uma série de componentes pré-implementados que auxiliam, de algma forma, o processo de criação de aplicações bastante eficientes do tipo de consola para diferentes tipos de plataforma. Por exemplo ficheiros para navegação em APIs. de igual modo manipuladores de strings e, desde o Qt 5.1, parsers de command line eficientes. Como o Qt é uma API de alto-nível a correr em C++, consegue-se velocidade de programação amparada com velocidade de execução. Não pense no Qt como apenas mais um toolkit para UI - tem, na verdade, muito mais para oferecer.

.. rubric:: Manipulação de Strings

No primeiro exemplo demonstrámos como alguém pode de forma muito simples adicionar 2 strings de constantes. Não se trata de algo de um tipo de aplicação particularmente interessante, mas dá uma idea de tipos de aplicações de C++ nativas, como aplicações sem loops um loop de eventos.

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

.. rubric:: Container Classes

Es

Este exemplo adiciona uma lista e uma iteração de listas à aplicação. O Qt vem com uma grande colecção de classes de containers que são fáceis de usar e usam os mesmos paradigmas de API que o resto das classes de Qt.

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

Aqui mostramos algumas listas de funções avançadas, que permitem unir uma lista de strings a outra string. Isto é particularmente útil quando precisas de executar input de text. O inverso (strings para lista de strings) também é possível usando a função ``QString::split()``.

.. code-block:: cpp


    QString s1("Hello");
    QString s2("Qt");
    // convenient container classes
    QStringList list;
    list <<  s1 << s2;
    // join strings
    QString s = list.join(" ") + "!";
    cout << s << endl;


.. rubric:: File IO

No próximo fragmento de código lemmos um ficheiro CSV para uma directoria local e corremos um loop de colunas para extrair as células de cada coluna. Fazendo isto conseguimos a tabela de informação do ficheiro CSV em cerca de 20 linhas de código.

A leitura de ficheiros devolve um pequeno stream, para que o possamos converter em código de texto Unicode válido para usarmos o stream de textoe passar o ficheir como um stream de baixo nível. Pa escrever fichieros CSV, apenas tem que abrir um ficheiro em modo de escrita e adicionar as linhas ao stream de texto.

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

Isto conclui as nossas secções sobre aplicaõçes baseadas em consola com Qt.

Aplicações do tipo Widget
------------------

.. issues:: ch02

Aplicações baseadas em consola são normalmente bastante úteis, mas, por vezes, é necessário uma UI para as exibir. Para além disso, aplicações baseadas em UI, precisarão, na maior parte dos cases, de um backend, para ler/escrever ficheiros, comunicar com a rede, manter informação num reservatório.

neste primeiro fragmento para aplições do tipo widget fazemos o minimo necesário para criar uma gganela, e exibi-la. Uma widget sem um parente no universo Qt é uma window. Iremos usar um ponteiro para garantir que a widget é apagada quando o ponteiro não é alocado. O objecto da aplicação encapsula os runtimes de Qt e com a função ``exec()`` chama-nos o evento em loop. A partir daqui a aplicação reage apenas a eventos trigados com o rato e o teclado ou outros facultadores de eventos como a navegação ou input e output de ficheiros. A aplicação irá sair quando o loop do evento sair. Isto é feito chamando a função ``quit()`` na aplicação ou fechando a window. Quando correr o código irá ver uma window com um tamanho de 240*120 pixeis. É tudo.

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

.. rubric:: Custom Widgets

Quando trabalhar com interfaces de utilizador, iremos precisar de criar aplicações customizadas. Tipicamente, uma widget é uma área de window preenchida com chamadas desenhadas. Aicionalmente a widget tem conhecimento interno sobre como lidar com o input do rato ou do teclado para reagir a triggers externos. Para fazer isto no Qt, iremos precisar de derivar a  `QWidget` e modificar algumas funções para pintar um manuseamento de eventos.

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

Na implementação, desenhamos uma pequena borda para a nossa aplicaãço e um pequeno rectângulo na última posição do rato. Isto é muito típico para aplicações customizadas de baixo nível. Os eventos do rato e do teclado mudam o estado interno da widget e trigam um uddate que as desenha. Não queremos abordar com demasiado detalhe este fragmento decódigo, mas é bom saber que existe esta possibilidade no ambiente. O Qt vem com um grande número de widgets de desktop implementadas, para que a probilidade se revela lata para que não tenha de fazer isto.

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

.. rubric:: Widgets de Desktop

Os developers de Qt têm feito tudo para que si e desponibilizam widegets de desktop, que tem um look nativo nos diferentes sistemas operativos. O seu trabalho reside em organizar estas diferentes widgets num contentor com painéis maiores. Uma widget em Qt pode também ser um contentor para outras widgets. Tudo isto é conseguido através de relações hierárquicas. Isto significa que precisamos de fazer com que as nossas widgets, como butões, check boxes, butões de rádio, mas também listas colunas numa relação hierárquica com outra widget. Um pequeno modo de conseguir isto é demonstrada abaixo.

Abaixo é possível ver um ficheiro do tipo header para um widget container.

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

Na implementação, usamos layouts para melhor organizar os nossos widgets. Os layout managers re--organizam as widgets de acordo com políticas de dimensão ãespecíficas quando o contentnor da widget é re-dimensionado. Neste exemplo, temos uma lista, um edit de linha, e um botão organizados verticalmente para permitir a edição de uma lista de cidades. Usamos o ``sinal`` do Qt e ``slots`` para contar o envio com os obggectos de recepção.

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

.. rubric:: Drawing Shapes

Alguns problems são melhor visualizados. Se o aquilo que se pretende, é organizar a UI da sua aplicação ede acordo com fórmas geométricas específicas, o Qt pode ser um excelente candidato, uma vez que implementa OpenGL ES (Khronos Group). Uma graphics view organiza formas geométricas simples numa cena. O utilizador pode interagir com estas formas ou posicioná-las usando um algoritmo. Para popular uma visualização de gráficos e uma cena cena de grfaicos. A cena é indexada na view e popula esta com items gráficos. Aqui está um pequeno exemplo. Primeiro o header com as declarações de view e cena.

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

A implementação de cenas é anexada à primeira vista. A vista é um widget e é arranggado com o contentor de widgets. No final, adicionamos um pequeno rectâgulo à cena, que é depois renderizado na view.

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

Adaptação de informação
-------------

.. issues:: ch02

Até agora cobrimos os principais tipos de data e a forma como usar wigets e visualização gráficas. Normalmente, a sua aplicação irá precisar de uma maior número de estruturas de dados, para também ter ou ser persistentemente aramazenada. A informação também precisa de ser visualizada. Para isto o Qt usa modelos, Um modelo simpelsé  uma modelo de lista de strings, que e preenchido com strings e anexado à vista de lista.

.. code-block:: cpp

    m_view = new QListView(this);
    m_model = new QStringListModel(this);
    view->setModel(m_model);

    QList<QString> cities;
    cities << "Munich" << "Paris" << "London";
    model->setStringList(cities);

Outra forma possível de armazenar e devolver informação é o SQL. O Qt vem com SQLite encapsulado e também com outros motores de bases de dados (MySQL, PostgresSQL, ...). Primeiro, precisa de cirar uma base de dados usando um esquema, como o presente abaixo:

.. code-block:: sql

    CREATE TABLE city (name TEXT, country TEXT);
    INSERT INTO city value ("Munich", "Germany");
    INSERT INTO city value ("Paris", "France");
    INSERT INTO city value ("London", "United Kingdom");

Para usar sql iremos precisar de adicionar o módulo de sq ao nosso ficheiro .pro.

.. code-block:: cpp

    QT += sql

A partir daí podemos abrir a nossa base de dados usando C++. Primeiro, precisamos de devolver uma nova base de dados com obggectos para uma engine de base de dados específica. Com este objecto de base dados seremos capazes abrir a base de dados. Para SQLite é suficiente especificar o caminho para a base de dados do ficheiro. O Qt disponibilza alguns modelos de base de dados de alto nível, um deles é uma tabela de modelos, que usa um identificador de tabelas e uma opção para albergar a data seleccionada. O resultado pode ser anexado a uma list view e a outro modelo antes.

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

Para um nível mais alto de operações de modelo o Qt disponibilza uma espécie de ficheiro do tipo proxy model, que permite uma forma básica de orgnaização e um filtro de outro modelo.

.. code-block:: cpp

    QSortFilterProxyModel* proxy = new QSortFilterProxyModel(this);
    proxy->setSourceModel(m_model);
    view->setModel(proxy);
    view->setSortingEnabled(true);

A filtragem é feita de acordo com a coluna para que os filtros e a string passem como um filtro de argumento.

.. code-block:: cpp

    proxy->setFilterKeyColumn(0);
    proxy->setFilterCaseSensitive(Qt::CaseInsensitive);
    proxy->setFilterFixedString(QString)

O filtro de modelo de proxy é muito mais poderoso do que demonstrado aqui. Por agora é sefuciente lembrar que o mesmo existe.


.. nota::

Isto foi uma overview de diferentes tipos de aplicações clássácas que podem ser desenvolvidas em Qt 5. O desktop esta a mudar e em breve os dispositivos mobile  serão os desktop do amanhã. Os dispositivos mobile tem um diferente tipo de design de interface. São mutio mais simples do que aplicações desktop. Fazem apenas uma coisa e fazem-no de forma simples e focada. As animações são uam pate importante da experiência. Um interface de utilizador precisa de se sentir vivo e fluente. As tecnologias tradicionais de Qt não são bem orientadas para este mercado.

    Coming next: Qt Quick for the rescue.

Aplicações QuickQt
--------------------

.. issues:: ch02

Existe um conflito inerente em desenvovlmento de software moderno. A user interface está a tornar-se em algo muito mais rápido do que os nossos serviços backend. NUma tecnologia tradicioanl desenvolve-se os chamados front-end e ao mesmo temo o back-end. Os resultados entram em conflito quando os cleintes querem mudar o user interface durante o projecto, ou desenvolver uma ideia de user interface durante o projecto. Projectos ágeis, requerem métodos ágeis.

O Qt Quick disponibiliza um ambient declarativo onde o seu interface de utilizador (front-end) é declarado como HTML e o seu backend é código C++ nativo. Isto permite conseguir o melhor dos dois mundos.

Isto e um exemplo de uma user interfacede Qt Quick simples:

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

A linguagem de declaração chama-se QML e precisa de um runtime para ser executada. O Qt disponibiliza um runtime standard chamado ``qmlscene``, apesar de não ser difícil escrever um runtime customizado. Para isto é preciso uma visão rápido e definir as principais fontes do documento de QML principal. A única coisa restante é mostrar o interface de utilizador.

.. code-block:: cpp

    QQuickView* view = new QQuickView();
    QUrl source = QUrl::fromLocalFile("main.qml");
    view->setSource(source);
    view.show();

Voltando aos nossos exemplos anteriores. Num exemplo usamos um modelo de cidade. Seria bom se pudéssemos usar este modelo dentro do nosso código de QML declarativo.

Para activar isto, precisamos primeiro do nosso front-end para ver como poderíamos querer usar um modelo de cidade. No caso do front-end é esperado um objecto chamado ``cityModel`` que pode ser usado numa list view..

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

Para activiar o ``cityModel`` podemos reutilizar o nosso modelo anterior e adicionar uma propriedade para o nosso contexto base (o root context é outro root-elemento do documento principal)

.. code-block:: cpp

    m_model = QSqlTableModel(this);
    ... // some magic code
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole+1] = "city";
    roles[Qt::UserRole+2] = "country";
    m_model->setRoleNames(roles);
    view->rootContext()->setContextProperty("cityModel", m_model);

.. pista::

Não é completamente correcto, como a table de modelos de SQL contém informação de colunas e o modelo de QML espera a informaaço como papéis. Portanto, tem que haver um mapeamento entre papéis. Por favor ver a página wikipedia de `QML e QSqlTableModel <http://wiki.qt.io/QML_and_QSqlTableModel>`_ .


Sumário
=======

.. issues:: ch02

Vimos como instlar o SDK do Qt e como criar a nossa primeria aplicação. Então passámos a partir de diferentes tipos de aplicação para permitir uma overview do Qt, mostrar algumas features para desenvolvimento de aplicação. Espero que tenha ficado com uma boa impressão do Qt que é um user interface bastante rico e oferece tudo o que um application developer pode esperar e mais. Para além disso, o Qt não o bloqueia em bibliotecas específicas, e pode sempre adicioanr outras bibliotecas e estender o Qt. Também é particularmente rico quado suporta o desenvolvimento de diferentes modelos de aplicaãço: consola, desktop clássico e user interface e aplicações sensíveis a toque.
