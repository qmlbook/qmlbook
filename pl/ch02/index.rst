===========
Zaczynamy!
===========

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_ , `katecpp <https://github.com/katecpp>`_

.. issues:: ch02

.. |creatorrun| image:: ../../en/ch02/assets/qtcreator-run.png

Ten rozdział wprowadzi Cię do programowania z użyciem Qt. Pokażemy Ci, jak zainstalować Qt SDK oraz jak stworzyć i uruchomić prostą aplikację *hello world*  z użyciem środowiska Qt Creator.

.. note::

    Kod źródłowy przykładów z tego rozdziału znajduje się w folderze `assets <../../assets>`_.


Instalacja Qt SDK
=================

.. issues:: ch02

Qt SDK zawiera narzędzia niezbędne do budowania aplikacji desktopowych i embedded. Najnowsza wersja jest dostępna do pobrania na `stronie domowej Qt-Company <http://qt.io>`_. Są tam dostępne zarówno instalatory online jak i offline. Osobiście autor preferuje instalator online, ponieważ umożliwiają one jednoczesną instalację kilku wersji Qt. Polecamy instalowanie Qt SDK właśnie w ten sposób. SDK wyposażone jest także w narzędzie umożliwiające łatwą aktualizację do najnowszej wersji.

Do programowania z Qt SDK dedykowane jest środowisko *Qt Creator*. Qt Creator to IDE umożliwiające bardzo produktywną pracę z Qt, dlatego polecamy wybór właśnie tego narzędzia. Możliwe jest jednak również kompilowanie Qt z konsoli i używanie dowolnego edytora własnego wyboru.

Podczas instalacji Qt SDK możesz pozostawić wszystkie opcje wybrane domyślnie. Upewnij się tylko, że zaznaczona do instalacji jest wersja Qt 5.x. To wszystko!


Hello World
===========

.. issues:: ch02

Przetestujemy teraz, czy Twoja instalacja Qt przebiegła pomyślnie, tworząc małą aplikację *Hello world*. Otwórz Qt Creator i stwórz nowy projekt Qt Quick UI Project ( :menuselection:`File --> New File or Project --> Qt Quick Project --> Qt Quick UI` ). Nazwij go ``HelloWorld``.


.. note::

    Qt Creator umożliwia tworzenie różnych typów aplikacji. Tutaj zawsze używamy :guilabeL:`Qt Quick UI` project, chyba że podano inaczej.


Qt Creator automatycznie stworzył dla Ciebie kilka plików. Plik ``HelloWorld.qmlproject`` to tzw. plik projektu, gdzie przechowywana jest konfiguracja projektu. Nie edytuj tego pliku -- jest on zarządzany automatycznie przez środowisko Qt Creator.

Plik ``HelloWorld.qml`` zawiera kod Twojej aplikacji. Zanim zaczniesz czytać dalej, otwórz go i spróbuj zgadnąć, co ta aplikacja robi.

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

Plik ``HelloWord.qml`` napisany jest w języku QML. Składnię języka QML omówimy dokładniej następnym rozdziale. Ten przykład przedstawia interfejs użytkownika jako szereg elementów podlegających pewnej hierarchii. W tym przypadku jest to prostokąt o wymiarach 360 x 360 pikseli z wypośrodkowanym napisem "Hello World". Powierzchnia ``MouseArea`` pokrywa cały obszar prostokąta i po kliknięciu na niej myszką aplikacja się zamyka.

Aby uruchomić aplikację, wciśnij |creatorrun| :guilabel:`Run` po lewej stronie albo wybierz z menu opcję :menuselection:`Build --> Run`.

Jeśli wszystko przebiegnie zgodnie z planem, ukaże Ci się poniższy widok:  


.. figure:: ../../en/ch02/assets/example.png
    :scale: 50%

Oznacza to, że Qt 5 jest zainstalowane poprawnie, a my możemy kontynuować.

.. tip::

    Jeśli jesteś integratorem, prawdopodobnie będziesz chciał mieć zarówno zainstalowane Qt SDK, jak i wersję Qt dla konkretnego urządzenia kompilowalną ze źródeł.


.. topic:: Budowanie od zera

    Jeśli chcesz, możesz zbudować Qt 5 z konsoli. W tym celu pobierz kopię repozytorium Qt i uruchom budowanie.

    .. code-block:: sh

        git clone git://gitorious.org/qt/qt5.git
        cd qt5
        ./init-repository
        ./configure -prefix $PWD/qtbase -opensource
        make -j4


    Po pomyślnej kompilacji i 2 filiżankach kawy Qt 5 będzie dostępne w folderze ``qtbase`` (jakikolwiek inny napój również wystarczy, jednak w celu zapewnienia najlepszych wyników sugerujemy kawę).

    By przetestować swoją świeżo zbudowaną wersję Qt, uruchom któryś z przykładowych programów lub postępuj zgodnie z instrukcjami poniżej.

    W celach testowych stworzymy małą aplikację HelloWorld. Stwórz plik ``example.qml``, otwórz go przy pomocy swojego ulubionego edytora tekstu i wklej zawartość:

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

    Możesz teraz uruchomić tę aplikację za pomocą::

        $ qtbase/bin/qmlscene

Typy aplikacji
==============

.. issues:: ch02

Ten rozdział jest przeglądem różnych typów aplikacji, które można stworzyć z użyciem Qt 5. W rzeczywistości opcji jest więcej niż przedstawiono w tym rozdziale, jednak zapoznanie się z przytoczonymi przykładami powinno dać Ci ogólny pogląd na to możliwości Qt 5.

Aplikacje konsolowe
-------------------

.. issues:: ch02

Aplikacja konsolowa nie dostarcza żadnego graficznego interfejsu użytkownika i zazwyczaj jest uruchamiana z wiersza poleceń. Qt 5 posiada zestaw gotowych komponentów, które pomogą Ci w efektywny sposób tworzyć przenośne aplikacje konsolowe. Przykładowo Qt posiada API do sieci, obsługi stringów oraz od Qt 5.1 efektywny parser komend z wiersza poleceń. Z racji, że Qt jest wysokopoziomowym interfejsem dla języka C++, używając go skracasz czas trwania implementacji przy jednoczesnym zachowaniu szybkości wykonywania się programów. Nie myśl o Qt *tylko* jak o narzędziu do tworzenia UI -- Qt ma dużo więcej do zaoferowania.

.. rubric:: Obsługa stringów

W pierwszym przykładzie zademonstrujemy, jak w prosty sposób można dodać do siebie dwa stringi. Przedstawiona aplikacja nie jest zbyt przydatna, ale pokazuje jak może wyglądać aplikacja natywna bez pętli obsługi zdarzeń (*event loop*).


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

.. rubric:: Klasy kontenerów

Ten przykład wprowadza do aplikacji listę i iterowanie po liście. Qt zawiera dużą kolekcję kontenerów, które są proste w użyciu i posiadają API zgodne z pozostałymi klasami Qt.

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

Tutaj prezentujemy kolejną funkcję listy: łączenie listy stringów do postaci jednego stringa. Jest to bardzo poręczne przy przetwarzaniu tekstu podzielonego na linie. Odwrotna operacja (string do postaci listy stringów) jest również możliwa przy pomocy funkcji ``QString::split()``.

.. code-block:: cpp


    QString s1("Hello");
    QString s2("Qt");
    // convenient container classes
    QStringList list;
    list <<  s1 << s2;
    // join strings
    QString s = list.join(" ") + "!";
    cout << s << endl;


.. rubric:: Operacje IO na plikach

Poniższy fragment kodu przedstawia czytanie z pliku CSV znajdującego się w lokalnym folderze. Pętla przechodzi kolejno przez wszystkie wiersze w pliku i wydobywa z nich zawartość wszystkich komórek. Ta operacja pozwala na uzyskanie tablicy danych z pliku CSV przy użyciu zaledwie 20 linii kodu. Czytanie z pliku daje nam jedynie surowy ciąg bajtów. Żeby przekonwertować to na tekst Unicode, musimy użyć klasy *QTextStream* i podać do jej konstruktora otwarty plik jako argument. Pisanie do pliku CSV wymagałoby otwarcia pliku w trybie *write* i analogicznego podawania linii tekstu do *QTextStream*.

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

To już wszystko w tej sekcji na temat aplikacji konsolowych z Qt.


Aplikacje widgetowe
-------------------

.. issues:: ch02

Aplikacje konsolowe są bardzo przydatne, ale czasami trzeba pokazać jakieś UI. Warto przy tym nie zapominać, że prawdopodobnie każda aplikacja z interfejsem graficznym będzie potrzebowała back-endu do operacji na plikach, komunikacji sieciowych czy po prostu przechowywania danych.

Poniższy fragment kodu przedstawia absolutne minimum niezbędne do stworzenia i wyświetlenia okna. Widget, który nie posiada rodzica w świecie Qt jest oknem. ``QScopedPointer`` zapewnia, że pamięć po widgetcie jest zwalniana, kiedy wyjdzie on z zakresu. Wywołanie metody ``exec()`` na obiekcie aplikacji powoduje uruchomienie pętli obsługi zdarzeń (*event loop*). Od tej pory aplikacja reaguje na zdarzenia takie jak kliknięcia myszą i na klawiaturze, lub też zdarzenia związane z komunikacją sieciową czy czytaniem/pisaniem do plików. Aplikacja zakończy swoje działanie dopiero wtedy, kiedy zakończy się działanie pętli obsługi zdarzeń, co można osiągnąć poprzez wywołanie funkcji ``quit()`` na obiekcie aplikacji lub przez zamknięcie okna aplikacji.

Kiedy uruchomisz ten program, zobaczysz okno o rozmiarze 240 x 120 pikseli. To wszystko.

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

.. rubric:: Własne widgety

Pracując nad interfejsem użytkownika, trzeba tworzyć swoje własne widgety. Zazwyczaj widget to obszar w oknie głównym wypełniony grafiką. Ponadto widget "wie", jak ma obsługiwać sygnały z klawiatury, myszy i reagować na inne zewnętrzne zdarzenia. Widget musi dziedziczyć po klasie ``QWidget`` i nadpisywać kilka funkcji wirtualnych z klasy bazowej, odpowiedzialnych za rysowanie i obsługę *eventów*.

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


W tej implementacji narysowaliśmy cienką ramkę wokół naszego widgeta oraz mały prostokąt położony w miejscu ostatniej pozycji kursora myszy. Jest to bardzo typowe dla niskopoziomowych implementacji widgetów. Zdarzenia z myszy lub klawiatury zmieniają stan wewnętrzny widgeta i wymuszają odświeżenie widoku. Nie chcemy się zanadto zagłębiać w szczegóły, ale warto żebyś wiedział, że masz możliwość tworzenia widgetów od zera. Niemniej Qt oferuje duży zestaw widgetów gotowych do użycia, więc prawdopodobnie nie będziesz musiał tego robić.

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

.. rubric:: Desktopowe Widgety

Deweloperzy Qt zrobili już za Ciebie kawał roboty i stworzyli zestaw widgetów desktopowych, które wyglądają natywnie na wielu różnych platformach. Twoje zadanie polega na pogrupowaniu potrzebnych widgetów do kontenerów i utworzeniu z nich większych paneli. Pojedynczy widget w Qt, dzięki hierarchii rodzic-dziecko, może być jednocześnie kontenerem na inne widgety. Oznacza to, że nowo dodawane widgety (np. przyciski, check boxy, listy...) powinny stać się dziećmi innych umieszczonych już widgetów. Jeden ze sposobów, żeby to osiągnąć, przedstawiony jest poniżej.

Oto plik nagłówkowy dla przykładowego kontenera widgetów.


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

Używamy tutaj *layoutów*, aby lepiej rozmieścić nasze widgety. Layout odpowiedzialny jest za ładne rozmieszczenie widgetów i dopasowywanie ich rozmiarów do rozmiarów widgetu-rodzica, kiedy jego rozmiar zmienia się. W tym przykładzie mamy listę, edytowalne pole i przycisk rozmieszczone pionowo. Widget służy do edycji listy miast. Do komunikacji między obiektami używamy sygnałów i slotów.


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

.. rubric:: Rysowanie kształtów

Niektóre problemy najlepiej przedstawić graficznie. Jeśli dany problem na pierwszy rzut oka wygląda jak obiekt geometryczny, dobrym kandydatem do użycia może być QGraphicsView, który umożliwia wyświetlanie prostych kształtów geometrycznych. Ich pozycja może być ustawiana ręcznie przez użytkownika, albo mogą być rozmieszczane zgodnie z jakimś algorytmem. Do stworzenia widoku zużyciem QGraphicsView potrzebny jest również przypisany mu obiekt QGraphicsScene (scena), który to jest wypełniany konkretnymi kształtami geometrycznymi.
Poniżej przedstawiony jest krótki przykład. Najpierw plik nagłówkowy z deklaracją widoku i sceny.

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

Na początku obiekt sceny (QGraphicsScene) jest przypisywany do widoku (QGraphicsView). Widok jest widgetem, zatem jest dodawany do naszego widgetowego kontenera, czyli layoutu. Na końcu dodajemy mały prostokąt do sceny, który jest następnie rysowany na obrazie.

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

Adaptacja danych
----------------

.. issues:: ch02


Dotychczas dyskutowaliśmy głównie o podstawowych typach danych i o tym, jak używać widgetów i widoków. Nie wspominaliśmy jednak o tym, co zrobić gdy w swoich aplikacjach spotkasz się z koniecznością obsługi dużej ilości danych, przechowywanych w pamięci trwałej. Takie dane również muszą być często wyświetlane. Qt do obsługi tego typu danych używa *modeli*. Najprostszym modelem jest model listy stringów, który wypełniany jest stringami, a następnie przypisywany do widoku listy *QListView*.

.. code-block:: cpp

    m_view = new QListView(this);
    m_model = new QStringListModel(this);
    view->setModel(m_model);

    QList<QString> cities;
    cities << "Munich" << "Paris" << "London";
    model->setStringList(cities);

Innym popularnym sposobem na zapisywanie i odczytywanie danych jest SQL. Qt ma wbudowaną bibliotekę SQLite, a także zaimplementowaną obsługę dla innych silników baz danych (MySQL, PostgresSQL, …). Bazę danych możesz stworzyć używając komend SQL, np. w taki sposób:

.. code-block:: sql

    CREATE TABLE city (name TEXT, country TEXT);
    INSERT INTO city value ("Munich", "Germany");
    INSERT INTO city value ("Paris", "France");
    INSERT INTO city value ("London", "United Kingdom");

Aby odblokować obsługę SQL w projekcie Qt, do pliku .pro należy dodać linijkę odpowiadającą za załączanie do projektu modułu sql:

.. code-block:: cpp

    QT += sql

Teraz już możemy obsługiwać bazę danych w naszym projekcie. Pierwszym krokiem jest stworzenie obiektu klasy bazy danych dla używanego przez nas silnika bazodanowego. Z pomocą tego obiektu otwieramy rzeczywistą bazę danych. W przypadku baz SQLite, podczas tworzenia wystarczy podać scieżkę do pliku .db. Qt dostarcza kilku wysokopoziomowych modeli baz danych. Jednym z nich jest model tabeli QSqlTableModel, który wykorzystuje identyfikator tabeli i opcjonalnie klauzulę WHERE, definiującą które dane mają zostać wyświetlone. Otrzymany model danych może zostać przypisany do widoku listy i tam wyświetlony.

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

Do operacji wyższego poziomu może posłużyć QSortFilterProxyModel, który pozwala Ci na podstawowe sortowanie i filtrowanie danych z innego modelu.

.. code-block:: cpp

    QSortFilterProxyModel* proxy = new QSortFilterProxyModel(this);
    proxy->setSourceModel(m_model);
    view->setModel(proxy);
    view->setSortingEnabled(true);

Aby przeprowadzić filtrowanie danych, należy zdefiniować kolumnę, która ma być przefiltrowana oraz podać string pełniący rolę filtra.

.. code-block:: cpp

    proxy->setFilterKeyColumn(0);
    proxy->setFilterCaseSensitive(Qt::CaseInsensitive);
    proxy->setFilterFixedString(QString)

Możliwości klasy QSortFilterProxyModel są dużo większe niż tu zaprezentowano. Na tę chwilę wystarczy Ci jednak świadomość, że coś takiego istnieje.


.. note::

    W tym rozdziale dokonaliśmy przeglądu różnych typów klasycznych aplikacji, które możesz stworzyć z użyciem Qt 5. Rozwój jednak idzie do przodu i wkrótce aplikacje desktopowe zostaną zastąpione przez aplikacje mobilne. Aplikacje mobilne zaś charakteryzują się zupełnie innym interfejsem użytkownika -- są znacznie uproszczone w porównaniu do aplikacji desktopowych. Robią one jedną rzecz naraz. Animacje zaś są ważnym aspektem wpływającym na zadowolenie użytkownika z pracy z aplikacją. Interfejs użytkownika powinien być żywy i płynny. Tradycyjne techniki Qt nie były w stanie zaspokoić potrzeb tego rynku.

    Do akcji wchodzi Qt Quick

Aplikacje Qt Quick
------------------

.. issues:: ch02

Z wytwarzaniem nowoczesnego oprogramowania wiąże się jeden nieodłączny problem. Wymagania do interfejsu użytkownika mogą zmieniać się zbyt szybko, aby możliwe było nadążanie za nimi w dobrym tempie z odpowiednimi zmianami back-endu. To wywołuje trudności, kiedy klient chce zmienić lub dopiero definiować interfejs użytkownika w trakcie trwania projektu. Projekty prowadzone z metodyką *agile* wymagają równie "zwinnych" technologii.

Qt Quick dostarcza deklaratywnego środowiska, dzięki któremu front-end jest deklarowany jak HTML, a back-end pozostaje napisany w natywnym kodzie C++. To pozwala na wyciśnięcie tego co najlepsze z obydwu światów.

Poniżej zaprezentowano proste UI stworzone z Qt Quick

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

Aby przetestować kod QML nie mając jeszcze ukończonej aplikacji, można użyć funkcjonalności Qt ``qmlscene``. Możliwe jest również stworzenie swojego własnego narzędzia do uruchamiania kodu QML. Potrzebny do tego jest jedynie obiekt klasy QQuickView, na którym wywołujemy metodę ustawiającą źródło na pożądany plik .qml. Metoda *show()* wyświetli efekt na ekranie.

.. code-block:: cpp

    QQuickView* view = new QQuickView();
    QUrl source = QUrl::fromLocalFile("main.qml");
    view->setSource(source);
    view.show();

Wróćmy jeszcze na chwilę do naszych poprzednich przykładów. W jednym z nich tworzyliśmy w C++ model zawierający listę miast. Byłoby super, gdybyśmy mogli użyć tego modelu z poziomu kodu QML.

Aby to zrobić, najpierw tworzymy interfejs, który docelowo będzie korzystał z naszego modelu. W tym przypadku front-end będzie oczekiwał obiektu o nazwie ``cityModel``, który może zostać wyświetlony za pomocą widoku listy.


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

Do stworzenia obiektu ``cityModel`` możemy wykorzystać większość kodu z poprzedniego przykładu. Następnie niezbędne jest ustawienie właściwości *ContextProperty* o nazwie ``cityModel`` tak by wskazywała ona na właściwy obiekt modelu ``QSqlTableModel``.

.. code-block:: cpp

    m_model = QSqlTableModel(this);
    ... // some magic code
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole+1] = "city";
    roles[Qt::UserRole+2] = "country";
    m_model->setRoleNames(roles);
    view->rootContext()->setContextProperty("cityModel", m_model);

.. hint::
    Nie jest to w pełni poprawne, gdyż `QSqlTableModel` zawiera dane w postaci kolumn a model QML oczekuje danych w postaci ról (*roles*). Z tego względu wymagane jest mapowanie kolumn do postaci ról. Więcej szczegółów na stronie wiki `QML and QSqlTableModel <http://wiki.qt.io/QML_and_QSqlTableModel>`_ .


Podsumowanie
============

.. issues:: ch02

W tym rozdziale pokazaliśmy jak zainstalować Qt SDK i jak stworzyć naszą pierwszą aplikację. Następnie przedstawiliśmy różne typy aplikacji, jakie można stworzyć z użyciem Qt. Prawdopodobnie widzisz już, że Qt jest bardzo bogatym narzędziem, które oferuje programiście wszystko o czym może on tylko pomarzyć i jeszcze więcej. Jednocześnie Qt nie uzależnia Cię od żadnych konkretnych bibliotek; zawsze możesz użyć innych rozwiązań, jak i samemu rozwijać biblioteki Qt. Qt również wspiera wiele różnych modeli aplikacji: konsolowe, klasyczne desktopowe oraz dotykowe interfejsy użytkownika.




