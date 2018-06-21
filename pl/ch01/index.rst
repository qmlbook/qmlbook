===========
Poznaj Qt 5
===========

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_ , `katecpp <https://github.com/katecpp>`_

.. issues:: ch01

.. note::

    Kod źródłowy przykładów z tego rozdziału znajduje się w folderze `assets <../../assets>`_.

Ta książka zapozna Cię z różnymi aspektami tworzenia oprogramowania z użyciem Qt 5. Tematyka książki skupia się głównie na nowej technologii Qt Quick, jednak omawiane są również niezbędne informacje na temat tworzenia back-endu oraz rozszerzeń dla Qt Quick w języku C++.

Poniższy rozdział stanowi ogólny przegląd biblioteki Qt 5. Prezentuje on różne typy aplikacji i przykładowe programy stworzone w Qt 5, dając przedsmak rzeczy możliwych do osiągnięcia przy użyciu tej biblioteki. Na końcu dowiesz się, jak skontaktować się z twórcami Qt 5.


Przedmowa
=========

.. rubric:: Historia

Qt 4 ewoluowało od 2005 roku i stanowiło w tym czasie solidną podstawę do zbudowania tysięcy aplikacji, a nawet całych systemów desktopowych i mobilnych. Zwyczaje ludzi zmieniły się jednak w ostatnich latach i ze stacjonarnych komputerów zwrócili się oni ku przenośnym laptopom i urządzeniom mobilnym, takim jak smartfony czy tablety. Klasyczne komputery są obecnie coraz częściej zastępowane mobilnym sprzętem z dotykowym ekranem i stałym dostępem do Internetu. To wszystko ma wpływ na postać tworzonych aplikacji. Tak jak w przeszłości Windowsowe programy zdominowały świat, tak obecnie spędzamy więcej czasu z innymi, inaczej obsługiwanymi systemami.

Celem Qt 4 było dostarczanie spójnego zestawu widgetów do tworzenia aplikacji desktopowych na wszystkie główne platformy. Obecnie wyzwanie stawiane przed deweloperami Qt zmieniło się i polega na zapewnieniu dotykowych, nowoczesnych interfejsów użytkownika na wszystkich głównych systemach stacjonarnych i mobilnych. Dlatego w wersji Qt 4.7 pojawiła się nowa technologia Qt Quick, pozwalająca na tworzenie za pomocą prostych elementów kompletnie świeżego UI, zgodnego z oczekiwaniami klienta.

Cele Qt 5
---------

Qt 5 jest odświeżeniem bardzo udanej wersji Qt 4. Wraz z wydaniem wersji 4.8, Qt 4 osiągnął wiek niemal 7 lat. Nastał czas na wprowadzenie ulepszeń do tego wspaniałego toolkitu. Qt 5 skupia się na następujących rzeczach:

* **Wybitna grafika**: Qt Quick 2 bazuje na OpenGL i oferuje zupełnie nowy poziom efektów graficznych, osiągalny tak łatwo jak nigdy przedtem.

* **Produktywność deweloperów**: Głównymi językami do tworzenia GUI są QML i Javascript. Back-end jest rozwijany w C++. Rozdzielenie na front-end tworzony w Javascripcie i back-end tworzony w C++ umożliwia przeprowadzanie szybkich iteracji deweloperom front-endu, którzy skupiają się głównie na przyjaznych dla użytkownika interfejsach, oraz programistom C++ koncentrującym się na stabilności i szybkości działania programu.

* **Przenośność**: Z nową Qt Platform Abstraction możliwe jest łatwiejsze i szybsze przenoszenie Qt do jeszcze większej liczby platform. Qt 5 zaprojektowane jest w oparciu o koncept podziału na Qt Essentials i dodatkowe moduły Add-on, co pozwala deweloperom na skupienie się jedynie na niezbędnych dla nich modułach i prowadzi do skrócenia czasu wykonywania się programu.

* **Open Development**: Qt jest prawdziwie otwartym projektem hostowanym na stronie `qt.io <http://qt.io>`_ . Rozwój Qt napędzany jest przez społeczność.


Wstęp do Qt 5
=============


Qt Quick
--------

Qt Quick to określenie na technologię do tworzenia interfejsów użytkownika w Qt 5. Qt Quick samo w sobie stanowi kolekcję kilku technologii:

* QML - Język znaczników dla UI,
* JavaScript - Dynamiczny język skryptowy,
* Qt C++ - Przenośna, ulepszona biblioteka C++.

.. figure:: ../../en/ch01/assets/qt5_overview.png

QML to język znaczników, podobnie jak HTML. Tagi QML nazywane są w Qt Quick *elementami*. Ciało elementów zawarte jest wewnątrz nawiasów klamrowych, następujących po nazwie elementu: ``Item {}``. Język QML został zaprojektowany do tworzenia UI w sposób szybki i czytelny dla deweloperów. Interfejs użytkownika może być ulepszany z użyciem kodu Javascript, a sam Qt Quick rozwijany z pomocą Qt C++. Krótko mówiąc, deklaratywne UI nazywamy front-endem, a części natywne back-endem. Taki podział pozwala na odseparowanie intensywnych operacji obliczeniowych i natywnych od części interfejsu użytkownika.

W typowym projekcie front-end jest rozwijany z użyciem QML/Javascript, zaś back-end z Qt C++. Skutkuje to naturalnym oddzieleniem deweloperów zorientowanych na design od deweloperów funkcjonalności. Zazwyczaj back-end testowany jest z użyciem frameworka Qt do testów jednostkowych i eksportowany do użycia przez deweloperów front-endu.


Tworzenie interfejsu użytkownika
--------------------------------

Stworzymy teraz prosty interfejs użytkownika używając technologii Qt Quick. Pozwoli nam to zapoznać się z niektórymi aspektami języka QML. Naszym celem jest stworzenie wiatraka z obracającymi się skrzydłami.

.. figure:: ../../en/ch01/assets/scene.png
    :scale: 50%

Zaczynamy od pustego dokumentu nazwanego ``main.qml``. Wszystkie pliki QML muszą mieć rozszerzenie ``.qml``. QML jako język znaczników (podobnie jak HTML) musi mieć dokładnie jeden element główny (tzw. *root element*). W naszym przypadku jest to element ``Image``.

.. code-block:: qml

    import QtQuick 2.5

    Image {
        id: root
        source: "images/background.png"
    }

QML nie stawia żadnych ograniczeń co do tego, jaki element może być głównym elementem, bez problemu zatem może w tej roli znaleźć się element ``Image`` . Właściwość ``source`` elementu ``Image`` wskazuje na obrazek *background.png*. Rozmiar elementu ``Image`` jest zależny od rozmiaru background.png.


.. figure:: ../../en/ch01/src/showcase/images/background.png


.. note::
    Każdy element ma swoje właściwości (ang. *properties*). Przykładowo obraz ma właściwości ``width``, ``height``, ale również inne, takie jak ``source`` zaprezentowane powyżej. Rozmiar elementu jest automatycznie kalkulowany na podstawie rozmiaru podanego obrazka źródłowego. Jeśli chcemy, aby nasz element miał inny rozmiar, musimy ustawić właściwości ``width`` i ``height`` do pożądanych przez nas wartości (w pikselach).

    Najpopularniejsze typy elementów są umieszczone w module ``QtQuick``, który importujemy w pierwszej linii powyższego kodu.

    Property ``id`` jest specjalną, opcjonalną właściwością elementu. Zawiera ono identyfikator, za pomocą którego można się odnosić do danego elementu z innych miejsc w dokumencie. Ważne: ``id`` nie może być zmienione po tym, jak zostanie ustawione, oraz nie może być ustawione w czasie wykonywania się programu. Użycie identyfikatora ``root`` dla głównego elementu nie jest koniecznością, a tylko dobrym zwyczajem, który ułatwia odwoływanie się do niego w dużych dokumentach QML.

Elementy na pierwszym planie naszego interfejsu, słup i skrzydła wiatraka, są umieszczone jako osobne obrazki.

.. figure:: ../../en/ch01/src/showcase/images/pole.png
.. figure:: ../../en/ch01/src/showcase/images/pinwheel.png

Słup wiatraka umieszczamy na środku, przy dolnej krawędzi obrazka tła. Skrzydła wiatraka są wycentrowane zarówno pionowo jak i poziomo względem tła.

Zazwyczaj elementy interfejsu użytkownika składają się z wielu różnych elementów, nie tylko obrazków, jak to jest w tym przykładzie.


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



Aby umieścić skrzydła wiatraka w centralnym punkcie elementu należy użyć właściwości ``anchor``, czyli tzw. zakotwiczenia. Zakotwiczenie pozwola na określenie dokładnego geometrycznego położenia elementu względem jego rodzica lub rodzeństwa. Na przykład: umieść mnie na środku mojego rodzica ( ``anchors.centerIn: parent`` ). Pozostałe możliwe opcje: left, right, top, bottom, centerIn, fill, verticalCenter, horizontalCenter. Oczywiście relacja musi geometrycznie pasować. Próby zakotwiczenia lewej strony jednego elementu do górnej krawędzi innego elementu nie miałyby sensu.


Umieszczamy zatem skrzydła wiatraka na środku jego rodzica, czyli obrazu tła.

.. note::

    Czasami może być konieczne wprowadzenie lekkich zmian (offsetów) do położenia wypośrodkowanych obiektów. Jest to możliwe z użyciem ``anchors.horizontalCenterOffset`` lub ``anchors.verticalCenterOffset``. Wszystkie inne wartości ``anchors`` również posiadają wersje z offsetami. Pełną listę możliwych właściwości ``anchor`` znajdziesz w dokumentacji.

.. note::

    Umieszczanie obrazka jako elementu potomnego - dziecka - względem elementu głównego (element ``Image``) ukazuje ważny koncept języków deklaratywnych. Deweloper opisuje interfejs w odpowiedniej kolejności warstw i grup, gdzie najwyższa warstwa (nasze tło) jest rysowana jako pierwsza, a kolejne warstwy rysowane są na jej wierzchu, w lokalnym dla niej układzie współrzędnych.

Żeby ożywić nieco naszą aplikację, wprowadzimy do niej interaktywny element. Kiedy użytkownik kliknie myszką na obszarze naszego interfejsu, wiatrak obróci się.


Potrzebny nam będzie element ``MouseArea`` pokrywający całą powierzchnię elementu ``root``.

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

``MouseArea`` emituje sygnał ``clicked``, kiedy użytkownik kliknie w obrębie pokrywanego przez nią obszaru. Możesz zaimplementować reakcję na ten sygnał, nadpisując funkcję ``onClicked``. W tym przypadku kliknięcie powoduje obrócenie obrazka ze skrzydłami wiatraka o +90 stopni.

.. note::

    Każdy sygnał może być obsłużony przy pomocy funkcji o nazwie: ``on`` + ``SignalName``. Ponadto każda właściwość emituje sygnał, kiedy zmienia się jej wartość. W tym przypadku nazwa funkcji obsługującej sygnał wygląda następująco:

        ``on`` + ``PropertyName`` + ``Changed``

    Na przykład, kiedy zmienia się property ``width``, możesz zobserwować to za pomocą funkcji ``onWidthChanged: print(width)``.


Teraz skrzydła wiatraka będą się obracać, ale wciąż nie jest to płynny ruch. Właściwość ``rotation`` zmienia się skokowo, a nie -- jak byśmy woleli -- stopniowo. Tutaj do gry wchodzą animacje. Animacja definiuje, jak zmiana właściwości przebiega w czasie. Aby uzyskać efekt animacji używamy typu ``Behaviour``. ``Behaviour`` odpowiada za animację uruchamianą dla danej właściwości za każdym razem, kiedy zmieni się jej wartość. Poniżej przedstawiony jest jeden z kilku sposobów deklarowania animacji w QML.

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

Teraz za każdym razem, gdy wartość property ``rotation`` zmieni się, zmiana ta będzie ilustrowana z użyciem animacji ``NumberAnimation``, trwającej 250 ms. Zatem każdy obrót o 90 stopni będzie trwał 250 ms.

.. figure:: ../../en/ch01/assets/scene2.png
    :scale: 50%

.. note:: W rzeczywistej aplikacji wiatrak nie będzie rozmyty. Rozmycie na powyższym obrazku ma sygnalizować trwający obrót. Jeśli jednak chcesz użyć obrazka z rozmytym wiatrakiem, znajdziesz go w folderze assets.

Teraz wiatrak wygląda dużo lepiej. Mam nadzieję, że przedstawiony przykład przybliżył Ci ogólną ideę programowania w Qt Quick.


Budowa Qt 5
===========

W skład Qt 5 wchodzi wiele modułów. Ogólnie rzecz biorąc, moduł to biblioteka, której może użyć deweloper. Niektóre z modułów są obligatoryjne na każdej platformie z dostępnym Qt. Formują one zestaw tzw. *Qt Essentials Modules*. Wiele innych modułów jest opcjonalnych i tworzą one zestaw *Qt Add-On Modules*. Najprawdopodobniej większość programistów nie będzie potrzebowała używać modułów *Add-On*, jednakże dobrze jest je znać, gdyż dostarczają one wartościowych rozwiązań na powszechne problemy.

Moduły Qt
---------

Moduły Qt Essentials są standardowo na każdej platformie z dostępnym Qt. Oferują one podstawowe narzędzia do rozwijania nowoczesnych aplikacji Qt 5 używając Qt Quick 2.

.. rubric:: Moduły Core-Essential

Minimalny zestaw modułów Qt 5 niezbędnych do programowania w QML.

.. list-table::
    :widths: 20 80
    :header-rows: 1

    *   - Moduł
        - Opis
    *   - Qt Core
        - Rdzeń Qt. Niegraficzne klasy używane przez inne moduły.
    *   - Qt GUI
        - Klasy bazowe dla komponentów interfejsu graficznego (GUI).
    *   - Qt Multimedia
        - Klasy do obsługi dźwięku, filmów, radio i kamery.
    *   - Qt Network
        - Klasy do łatwego tworzenia przenośnego oprogramowania sieciowego.
    *   - Qt QML
        - Klasy niezbędne do programowania w QML i Javascripcie.
    *   - Qt Quick
        - Deklaratywny framework do budowania dynamicznych aplikacji z interfejsem użytkownika.
    *   - Qt SQL
        - Klasy do obsługi baz danych przy użyciu SQL.
    *   - Qt Test
        - Klasy do unit testów dla aplikacji i biliotek Qt.
    *   - Qt WebKit (przestarzałe)
        - Klasy do implementacji opartych na WebKit2. Zapoznaj się również z Qt WebKit Widgets.
    *   - Qt WebKit Widgets (przestarzałe)
        - WebKit1 i klasy bazujące na QWidget z Qt 4.
    *   - Qt Widgets
        - Klasy do tworzenia Qt GUI z użyciem widgetów C++.

.. digraph:: essentials

    QtGui -> QtCore
    QtNetwork ->QtCore
    QtMultimedia ->QtGui
    QtQml -> QtCore
    QtQuick -> QtQml
    QtSql -> QtCore


.. rubric:: Moduły Qt Add-on

Poza modułami Qt Essentials, Qt oferuje również dodatkowe moduły, które nie są częścią release'u. Poniżej znajduje się krótka lista dostępnych modułów Add-on.

* Qt 3D - Zestaw API do łatwego i deklaratywnego programowania grafiki 3D.
* Qt Bluetooth - C++ i QML API dla platform używających bezprzewodowej techniki Bluetooth.
* Qt Contacts - C++ i QML API do obsługi książek adresowych / baz danych kontaktów.
* Qt Location - Dostarcza pozycjonowanie lokalizacji, mapy, nawigację i szukanie miejsc z użyciem interfejsów QML i C++. NMEA do pozycjonowania
* Qt Organizer - C++ i QML API do zarządzania organizerem (wydarzenia, todo, itd.)
* Qt Publish and Subscribe
* Qt Sensors - Dostęp do czujników przez interfejsy QML i C++.
* Qt Service Framework - Ułatwia komunikację międzyprocesową. Pozwala aplikacjom m.in. nasłuchiwać sygnałów i uruchamiać sloty.
* Qt System Info - Odkrywa informacje na temat systemu i jego możliwości.
* Qt Versit - Wsparcie dla formatów vCard i iCalendar.
* Qt Wayland - Tylko dla Linuxa. Zawiera Qt Compositor API (serwer) i plugin Wayland (klient).
* Qt Feedback - Dotykowy i dźwiękowy feedback na akcje użytkownika.
* Qt JSON DB - Baza danych no-SQL dla Qt.

.. note::

    Z racji, że te moduły nie są częścią release'u, mogą być one w różnym stanie, w zależności od tego ilu deweloperów uczestniczy aktywnie w procesie implementacji i jak dokładnie są testowane.


Wspierane platformy
-------------------

Qt wspiera wiele różnych platform, w tym wszystkie główne platformy desktopowe i embedded. Obecnie, dzięki Qt Application Abstraction, przenoszenie Qt na Twoją własną platformę jest jeszcze łatwiejsze.

Testowanie Qt 5 na nowej platformie jest czasochłonne. Wyznaczyliśmy pewien pozdbiór platform, które tworzą zestaw platform rekomendowanych. Te platformy są dokładnie testowane w celu zapewnienia najwyższej jakości. Miej jednak na uwadze, że bezbłędny kod nie istnieje.




Qt Project
==========

Cytat z `Qt Project wiki <http://wiki.qt.io/>`_:

"Qt Project jest merytokratyczną, opartą na konsensusie społecznością ludzi zainteresowanych Qt. Każdy, kto podziela to zainteresowanie, może dołączyć do społeczności, uczestniczyć w podejmowaniu decyzji i mieć swój udział w rozwoju Qt."

Qt Project to organizacja, która rozwija open-source'ową część Qt. Stanowi ona podstawę dla innych użytkowników, którzy chcą mieć swój wkład w implementację Qt. Największy wkład w rozwój Qt wnosi DIGIA, która również jest właścicielem komercyjnych praw do Qt.

Qt dla firm może być dostępne na licencji open-source lub na licencji komercyjnej. Komercyjna licencja jest wymagana, jeśli firma nie może lub nie chce dostosować się do licencji open-source. Bez komercyjnej licencji takie firmy nie mogłyby używać Qt, a DIGIA nie byłaby w stanie rozwijać Qt Project z taką intensywnością, jak obecnie.

Jest bardzo dużo firm na całym świecie, które utrzymują się z konsultingu i wytwarzania oprogramowania z użyciem Qt. Jest też dużo open-source'owych projektów i deweloperów, dla których Qt jest najczęściej stosowaną biblioteką. To świetne uczucie, być częścią tej tętniącej życiem społeczności i pracować z tymi wspaniałymi toolami i bibliotekami. Czy uczyni to z Ciebie lepszą osobę? Być może :-)

**Dołącz tutaj: http://wiki.qt.io/**
