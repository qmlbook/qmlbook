=============
Quick Starter
=============

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_ , `katecpp <https://github.com/katecpp>`_

.. issues:: ch04

.. note::

    Last Build: |today|

    Kod źródłowy przykładów z tego rozdziału znajduje się w `folderze assets <../../assets>`_.


W tym rozdziale dokonamy przeglądu QMLa, deklaratywnego języka do tworzenia interfejsów użytkownika z Qt 5. Omówimy jego składnię z drzewiastą hierarchią elementów na czele, a następnie przedstawimy najczęściej używane elementy. Pokażemy też pokrótce, jak stworzyć własne elementy (tzw. komponenty) i jak je przetwarzać, edytując ich właściwości. Na samym końcu przyjrzymy się metodom rozmieszczania elementów w layoutach, a także zaprezentujemy komponenty, za pomocą których użytkownik może wprowadzać do aplikacji dane wejściowe.

Składnia QML
============

.. issues:: ch04

.. index:: qmlscene, properties, scripting, binding, syntax


QML jest językiem deklaratywnym, używanym do tworzenia interfejsów użytkownika. Wyodrębnia on z interfejsu mniejsze elementy, które mogą być łączone do postaci komponentów. QML opisuje wygląd i zachowanie tych elementów. Interfejs QML może być wzbogacany kodem Javascript, co pozwala na zaimplementowanie zarówno prostej logiki, jak i bardziej skomplikowanej. Przypomina to odrobinę współpracę HTML z Javascriptem, jednak w przeciwieństwie do HTML, QML jest stworzony do opisywania interfejsów użytkownika, a nie dokumentów tekstowych.

Najprościej mówiąc, QML jest hierarchią elementów. Elementy potomne dziedziczą system koordynatów po rodzicach. Koordynaty ``x,y`` zawsze rozumiane są jako względne wobec rodzica.


.. figure:: ../../en/ch04/assets/scene.png


Zacznijmy od prostego przykładu obrazującego składnię QML.


.. literalinclude:: ../../en/ch04/src/concepts/RectangleExample.qml
    :start-after: M1>>
    :end-before: <<M1


* Komenda ``import`` ładuje konkretną wersję danego modułu. Najczęściej importowany jest *QtQuick 2.0*, który zawiera podstawowy zestaw elementów.
* Komentarze robi się tak jak w C/C++ i w Javascripcie - za pomocą ``//`` (pojedyncza linia) lub  ``/* */`` (wiele linii).
* Każdy plik QML musi posiadać dokładnie jeden element główny (tzw. **root**), tak jak w HTML.
* Deklaracja elementu składa się z nazwy typu elementu i następujących po niej nawiasów klamrowych ``{ }``.
* Elementy posiadają właściwości w postaci ``name : value``.
* Do elementów w dokumencie QML można odwoływać się używając ich ``id`` (przy id nie używamy cudzysłowów).
* Elementy mogą być zagnieżdżane, tzn. że element-rodzic może posiadać elementy-dzieci. Do elementu-rodzica można odwoływać się z poziomu dziecka za pomocą słowa kluczowego ``parent``.

.. tip::
    
    Często będziesz odnosić się do konkretnego elementu w dokumencie używając jego id lub słowa kluczowego ``parent``. Dobrym zwyczajem jest nadanie swojemu elementowi głównemu identyfikatora ``id: root``. Dzięki temu nie będziesz miał problemem z przypomnieniem sobie jego id.

.. hint::

    Możesz uruchamiać przykłady Qt Quick z linii komend w następujący sposób::

        $ $QTDIR/bin/qmlscene RectangleExample.qml


    Gdzie *$QTDIR* należy zastąpić ścieżką instalacji Qt. Program *qmlscene* interpretuje i uruchamia dostarczony plik QML.

    Możesz też otworzyć odpowiedni plik projektu w Qt Creatorze i wczytać dokument ``RectangleExample.qml``.

Właściwości
-----------


.. issues:: ch04

Elementy deklarowane są przy użyciu ich nazw, a definiowane poprzez użycie ich właściwości lub przez tworzenie dla nich nowych właściwości. Właściwość (ang. *property*) to po prostu para klucz-wartość, np. ``width : 100``, ``text: 'Greetings'``, ``color: '#FF0000'``. Właściwość jest konkretnego typu i może posiadać wartość początkową.


.. literalinclude:: ../../en/ch04/src/concepts/PropertiesExample.qml
    :start-after: M1>>
    :end-before: <<M1

Przyjrzyjmy się dokładniej różnym cechom właściwości:

(1) ``id`` jest szczególną wartością przypominającą właściwość. Jest ona używana podczas odwoływania się do poszczególnych elementów w pliku QML (inaczej "dokumencie" QML). ``id`` nie jest stringiem, a bardziej identyfikatorem, i stanowi część składni QML. ``id`` musi być unikalne w ramach dokumentu i nie może być zmienione po ustawieniu go, a także nie można go odczytać z obiektu. (``id`` zachowuje się bardziej jak wskaźnik w świecie C++.)

(2) Do właściwości można przypisać wartość odpowiedniego typu. Jeśli żadna wartość nie została przypisana do danej właściwości, zostanie wybrana domyślna wartość początkowa. W dokumentacji poszczególnych elementów znajdziesz informacje na temat wartości początkowych dla właściwości.

(3) Właściwość może zależeć od innej (jednej lub wielu) właściwości. Nazywa się to wiązaniem właściwości (ang. *property binding*). Wiązana właściwość jest aktualizowana, kiedy zmienia się właściwość od której jest zależna. W tym przypadku ``height`` będzie zawsze dwa razy większa od ``width``.

(4) Dodawanie własnych właściwości do elementu odbywa się z użyciem kwalifikatora ``property``, po którym podawany jest typ, nazwa i opcjonalnie wartość początkowa właściwości (``property <type> <name> : <value>``). Jeśli nie podano wartości początkowej, to zostanie wybrana wartość systemowa.

    .. note:: Jedna wybrana właściwość obiektu może być właściwością domyślną, do której zostanie przypisana wartość, gdy nie zostanie podana żadna nazwa właściwości. Domyślną właściwość deklarujemy za pomocą słowa kluczowego ``default``. Jest to używane na przykład podczas dodawania elementów-dzieci do obiektu -- elementy-dzieci, jeśli są obiektami graficznymi, są automatycznie dodawane do domyślnej właściwości ``children`` typu lista.

(5) Innym sposobem deklarowania właściwości jest użycie słowa kluczowego ``alias`` (``property alias <name> : <reference>``). Słowo kluczowe ``alias`` pozwala na przekazywanie właściwości obiektu lub samego obiektu z wnętrza typu na zewnątrz. Będziemy używali tej techniki podczas definiowania komponentów, aby eksportować ich wewnętrzne właściwości lub id do poziomu roota. Do zdefiniowania aliasu nie podajemy typu właściwości -- typ ten jest automatycznie dedukowany na podstawie typu oryginalnej zmiennej, do której alias się odnosi.

(6) Właściwość ``text`` zależy od właściwości ``times`` typu int. Wartość zmiennej int jest automatycznie konwertowana do typu ``string``. Wyrażenie to samo w sobie jest kolejnym przykładem wiązania właściwości i skutkuje odświeżaniem ``text`` za każdym razem, gdy wartość ``times`` się zmieni.

(7) Niektóre właściwości są właściwościami zgrupowanymi. Właściwości zgrupowane są używane, gdy kilka właściwości jest ze sobą powiązanych i powinny być przechowywane razem. Innym sposobem na osiągnięcie tego samego jest: ``font { family: "Ubuntu"; pixelSize: 24 }``.

(8) Niektóre właściwości są związane na sztywno z konkretnym elementem. Jest tak w przypadku globalnych elementów, które zdefiniowane są tylko raz dla całej aplikacji (np. dane z klawiatury). Piszemy wtedy ``<Element>.<property>: <value>``.

(9) Dla każdej właściwości możesz dostarczyć metodę, która będzie wołana przy każdej zmianie jej wartości. Tutaj na przykład chcemy być powiadamiani o każdej zmianie ``height`` w formie loga wypisywanego w konsoli.

.. warning:: ``id`` elementu powinno być używane do odwoływania się tylko w zakresie jednego dokumentu (np. obecnego pliku). QML dostarcza mechanizmu dynamicznego określania zakresu (``dynamic-scoping``) przez co dokumenty załadowane później nadpisują ``id`` z dokumentów załadowanych wcześniej. Jest przez to możliwe odwołanie się do ``id`` elementu z wcześniej załadowanych dokumentów, jeśli nie zostały one nadpisane. Przypomina to tworzenie zmiennych globalnych. Niestety, często to prowadzi w praktyce do bardzo złego kodu, gdzie wynik programu zależy od kolejności wykonania. Mechanizmu tego nie da się wyłączyć. Używaj tej techniki z dużą uwagą, lub lepiej nie używaj jej w ogóle. Elementy, które chcesz udostępnić światu zewnętrznemu, lepiej jest wyeksportować przy pomocy właściwości elementu głównego w danym dokumencie.


Pisanie skryptów
----------------

.. issues:: ch04


QML i JavaScript (również znany jako ECMAScript) są najlepszymi przyjaciółmi. Szczegóły tej współpracy zostaną przedstawione w rozdziale *JavaScript*. W tej chwili naszym celem jest jedynie uświadomienie Ci istnienia tej relacji.


.. literalinclude:: ../../en/ch04/src/concepts/ScriptingExample.qml
    :start-after: M1>>
    :end-before: <<M1


(1) Za każdym razem, gdy właściwość ``text`` zmieni się wskutek wciśnięcia spacji, handler ``onTextChanged`` wyświetli w konsoli aktualną wartość ``text``.

(2) Kiedy element ``text`` otrzymuje powiadomienie o wciśnięciu spacji, wywoływana jest funkcja ``increment()`` napisana w JavaScripcie.

(3) Definicja funkcji w JavaScript ma formę ``function <name>(<parameters>) { ... }``. Funkcja ``increment()`` zwiększa licznik ``spacePresses`` o jeden. Za każdym razem gdy zmienia się wartość ``spacePresses``, aktualizowane są również powiązane z nią właściwości.

.. note::

    Różnica pomiędzy QML-owym ``:`` (wiązanie) a JavaScriptowym ``=`` (przypisanie) jest taka, że wiązanie jest trwałym kontraktem, który obowiązuje do czasu jego zerwania, podczas gdy JavaScriptowe przypisanie (`=`) jest jednorazowym przypisaniem wartości.
    Życie wiązania kończy się w momencie ustawienia nowego wiązania do danej własciwości lub gdy zostanie do niej przypisana wartość w JavaScripcie. Na przykład taka metoda reagująca na wciśnięcie przycisku przypisaniem pustego stringa zniszczy nasze zliczanie wciśniętych spacji::

        Keys.onEscapePressed: {
            label.text = ''
        }

    Po wciśnięciu Escape, przyciskanie spacji nie będzie już aktualizowało wyświetlanego tekstu, ponieważ poprzednie wiązanie właściwości ``text`` (*text: "Space pressed: " + spacePresses + " times"*) zostało zniszczone.

    Kiedy stosujesz różne techniki aktualizowania właściwości tak jak w tym przypadku (tekst jest aktualizowany przy inkrementacji poprzez utworzone wiązanie, a czyszczony przez JavaScriptowe przypisanie) to musisz zrezygnować z użytego wiązania. Używaj JavaScriptowego przypisania w obu przypadkach, ponieważ inaczej przypisanie będzie niszczyło stworzone wiązanie (tzw. *broken contract*).

Podstawowe elementy
===================

.. issues:: ch04

.. index:: Item, Rectangle, Text, MouseArea, Image, gradients

Elementy można podzielić na graficzne i niegraficzne. Graficzny element (jak ``Rectangle``) ma swoją geometrię i jest prezentowany na obszarze ekranu. Niegraficzny element (jak ``Timer``) dostarcza funkcjonalności, które są używane do manipulowania elementami graficznymi.

Teraz skupimy się na podstawowych elementach graficznych, takich jak ``Item``, ``Rectangle``, ``Text``, ``Image`` i ``MouseArea``.

Element Item
------------

.. issues:: ch04

``Item`` jest elementem bazowym wszystkich elementów graficznych - wszystkie elementy graficzne dziedziczą po nim. ``Item`` sam w sobie nic nie rysuje, lecz definiuje wszystkie właściwości wspólne dla elementów graficznych:

.. list-table::
    :widths: 20,80
    :header-rows: 1

    *   - Grupa
        - Właściwości
    *   - Geometria
        - ``x`` i ``y`` określające pozycję lewego górnego rogu, ``width`` i ``height`` jako rozmiar elementu a także ``z`` jako kolejność układania elementów i przenoszenia ich na wierzch/ pod spód względem ich naturalnego położenia
    *   - Zarządzenie layoutem
        - ``anchors`` (*left*, *right*, *top*, *bottom*, *vertical* i *horizontal center*) do pozycjonowania elementów względem innych elementów z zachowaniem ich marginesów (``margins``)
    *   - Obsługa klawiszy
        - właściwości ``Key`` i ``KeyNavigation`` do obsługi wciskanych klawiszy i przełączania focusa pomiędzy elementami
    *   - Transformacje
        - Transformacje ``scale`` i ``rotate`` oraz właściwość ``transform`` zawierająca listę transformacji dla *x,y,z* oraz odpowiadających im punktów początkowych ``transformOrigin``
    *   - Wizualne
        - ``opacity`` określające przezroczystość, ``visible`` definiujące czy element jest widoczny czy ukryty, ``clip`` ograniczający obszar rysowania (przez element i jego dzieci) do rozmiarów danego elementu, oraz ``smooth`` polepszające jakość renderowania
    *   - Definicja stanu
        - właściwość ``states`` zawiera listę możliwych stanów w jakich może znaleźć się element, ``state`` określa obecny stan a ``transistions`` zawiera listę animacji wykonujących się podczas przechodzenia z jednego stanu do drugiego.

Dla lepszego opanowania tematu właściwości, omówimy je w tym rozdziale przy okazji omawiania poszczególnych elementów. Pamiętaj, że te podstawowe właściwości są dostępne w każdym elemencie graficznym i dla różnych elementów zachowują się tak samo.

.. note::

	Element ``Item`` często jest używany jako kontener na inne elementy, podobnie jak element *div* w HTML. 

Element Rectangle
-----------------

.. issues:: ch04

``Rectangle`` (ang. prostokąt) jest podklasą ``Item``, która dodaje do ``Item`` wypełnienie kolorem. Ponadto obsługuje też modyfikacje w wyglądzie brzegów elementu przy użyciu ``border.color`` i ``border.width``. Aby stworzyć zaokrąglony prostokąt, można użyć właściwości ``radius``.


.. literalinclude:: ../../en/ch04/src/concepts/RectangleExample2.qml
    :start-after: M1>>
    :end-before: <<M1

.. figure:: ../../en/ch04/assets/rectangle2.png

.. note::

	Poprawnymi kolorami są wartości z palety SVG (zobacz http://www.w3.org/TR/css3-color/#svg-color). Możesz również podawać kolory do QML w innym formacie, ale najpopularniejszym sposobem jest string RGB ('#FF4444') lub nazwa koloru (np. 'white').

Poza wypełnieniem kolorem i obramowaniem prostokąta, ``Rectangle`` wspiera również stosowanie niestandardowych gradientów.


.. literalinclude:: ../../en/ch04/src/concepts/RectangleExample3.qml
    :start-after: M1>>
    :end-before: <<M1

.. figure:: ../../en/ch04/assets/rectangle3.png

Gradient jest zdefiniowany poprzez serię punktów o określonej pozycji i kolorze. Pozycja określa położenie na osi y (0 = góra, 1 = dół). Kolor elementu ``GradientStop`` odpowiada kolorowi gradientu na tej pozycji.

.. note::

	``Rectangle`` bez określonych szerokości i wysokości nie będzie widoczny. Taki błąd często występuje, gdy masz kilka prostokątów o wymiarach zależnych od siebie nawzajem i coś pójdzie nie tak wewnątrz logiki kompozycji. Także uważaj!

.. note::
	
	W przedstawiony sposób nie da się stworzyć gradienta przebiegającego pod kątem. W tym celu lepiej jest użyć predefiniowanych obrazów. Inną możliwością jest obrócić prostokąt z gradientem. Z puntu widzenia programisty jednak w tym przypadku lepiej jest używać zaprojektowanych obrazów z gradientem.

Element Text
------------

.. issues:: ch04

Do wyświetlania tekstu służy element typu ``Text``. Jego najbardziej znanym zastosowaniem jest właściwość ``text`` typu ``string``. Element ten oblicza swoją początkową wysokość i szerokość na podstawie przypisanego tekstu i wybranej czcionki. Sama czcionka może być edytowana przy użyciu grupy właściwości ``font`` (np. ``font.family``, ``font.pixelSize``, ...). Aby zmienić kolor tekstu, edytuj właściwość ``color``.


.. literalinclude:: ../../en/ch04/src/concepts/TextExample.qml
    :start-after: M1>>
    :end-before: <<M1

|

.. figure:: ../../en/ch04/assets/text.png

Tekst możed być wyrównany do dowolnej strony lub do środka przy użyciu własciwości ``horizontalAlignment`` i ``verticalAlignment``. Do dalszej obróbki tekstu można użyć właściwości ``style`` i ``styleColor``, które pozwalają wyświetlić tekst w postaci konturu albo w formie wypukłej i wklęsłej. Dla dłuższych tekstów często przydatne jest wycinanie/wykropkowanie fragmentów, by odpowiadały potrzebnej długości, tak jak np. w *Bardzo długi ... tekst*, co może być osiągnięte z użyciem właściwości ``elide`` (ang. opuszczać). Właściwość ``elide`` pozwala na ustawienie pozycji, od której tekst będzie skracany: od lewej, od prawej lub na środku. W przypadku kiedy nie chcesz skracać tekstu przy pomocy '...', możesz także zawinąć tekst przy użyciu właściwości ``wrapMode`` (działa tylko przy jawnie ustawionej szerokości tekstu)::

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

Element ``Text`` jedynie wyświetla zadany tekst. Nie rysuje żadnych dekoracji tła -- poza wyświetlonym tekstem, element ``Text`` jest przezroczysty. Dostarczenie tła dla elementu tekstowego to zadanie ogólnego designu.

.. note::
	
	Bądź świadomy, że domyślna szerokość i wysokość elementu ``Text`` zależy od zadanego stringa i wybranej czcionki. Element ``Text`` bez ustawionej szerokości i bez tekstu nie będzie widoczny, gdyż jego domyślna szerokość będzie równa 0.

.. note::

        Podczas rozmieszczania elementów ``Text``, często będziesz musiał rozróżniać pomiędzy wyrównywaniem tekstu wew. elementu ``Text``, a wyrównywaniem samego elementu ``Text`` (z krawędziami). W tym pierwszym przypadku należy użyć właściwości ``horizontalAlignment`` i ``verticalAlignment``, w drugim musisz modyfikować geometrię elementu lub używać ``anchors``.

Element Image
-------------

.. issues:: ch04

Element ``Image`` służy do wyświetlania obrazów w różnych formatach (np. PNG, JPG, GIF, BMP, WEBP). *Pełna lista wspieranych formatów znajduje się w dokumentacji Qt*. Poza oczywistą właściwością ``source``, która dostarcza URL źródła obrazu, ``Image`` posiada również właściwość ``fillMode``, która kontroluje zachowanie obrazu podczas rozciągania okna.

.. literalinclude:: ../../en/ch04/src/concepts/ImageExample.qml
    :start-after: M1>>
    :end-before: <<M1

.. figure:: ../../en/ch04/assets/image.png

.. note::

    URL może być ścieżką lokalną poprzedzoną slashem ( "./images/home.png" ) albo adresem internetowym (np. "http://example.org/home.png").

.. note::

    Elementy z ustawioną właściwością ``PreserveAspectCrop`` powinny również odblokować przycinanie obrazu (*clipping*), aby zapobiec renderowaniu się obrazu poza brzegami elementu. Domyślnie przycinanie jest wyłączone (``clip : false``). Odblokowanie go (``clip : true``) ograniczy rysowanie obrazu do wnętrza ograniczającego prostokąta. Taka operacja może być wykonana na każdym elemencie graficznym.

.. tip::

    Przy pomocy C++ jesteś w stanie stworzyć swoją własną obsługę obrazów używając  :qt5:`QQmlImageProvider <qqmlimageprovider>`. To pozwoli Ci na tworzenie obrazów w locie i ładowanie obrazów w osobnym wątku.


Element MouseArea
-----------------

.. issues:: ch04

Do interakcji z różnymi elementami będziesz często używał ``MouseArea``. Jest to niewidoczny prostokąt, wewnątrz którego możesz przechwytywać zdarzenia pochodzące z myszy. MouseArea często jest używana razem z widocznym elementem graficznym, by obsługiwać komendy wydawane przez użytkownika korzystającego z interfejsu graficznego programu.

.. literalinclude:: ../../en/ch04/src/concepts/MouseAreaExample.qml
    :start-after: M1>>
    :end-before: <<M1

.. list-table::
    :widths: 50 50

    *   - .. figure:: ../../en/ch04/assets/mousearea1.png
        - .. figure:: ../../en/ch04/assets/mousearea2.png

.. note::

    To ważny aspekt QtQuick: obsługa wejściowych danych/sygnałów jest oddzielona od warstwy graficznej. Dzięki temu powierzchnia interakcji z użytkownikiem nie musi ograniczać się do powierzchni elementów graficznych.

Komponenty
==========

.. issues:: ch04

.. index:: components

Komponent to element do wielokrotnego użycia. QML dostarcza kilku różnych sposóbów na stworzenie komponentu. Nas póki co interesuje tylko jeden sposób - komponent w osobnym pliku. Taki komponent tworzy się poprzez umieszczenie elementu QML w osobnym pliku i nadanie temu plikowi nazwy (np. ``Button.qml``). Takiego stworzonego komponentu używa się tak samo jak każdego innego elementu z modułu QtQuick, w tym przypadku będzie to po prostu ``Button { ... }``.

Dla przykładu stwórzmy prostokąt zawierający element tekstowy i MouseArea. Wynik powinien przypominać prosty guzik.


.. literalinclude:: ../../en/ch04/src/elements/InlinedComponentExample.qml
    :start-after: M1>>
    :end-before: <<M1

UI będzie wyglądało podobnie do tego. Po lewej jest stan początkowy, zaś po prawej stan po kliknięciu guzika.


.. list-table::
    :widths: 50 50

    *   - .. figure:: ../../en/ch04/assets/button_waiting.png
        - .. figure:: ../../en/ch04/assets/button_clicked.png

Naszym zadaniem jest wydobycie GUI buttona do postaci reużywalnego komponentu. W tym celu najpierw krótko przemyślmy możliwe API naszego guzika. Spróbujmy sobie wyobrazić, jak powinno się używać tego guzika. Oto co wymyśliłem:


.. code-block:: js

    // minimal API for a button
    Button {
        text: "Click Me"
        onClicked: { // do something }
    }

Chciałbym ustawiać tekst na guziku przy użyciu właściwości ``text`` oraz zaimplementować własną obsługę kliknięcia. Ponadto oczekiwałbym, że guzik będzie miał sensowny rozmiar początkowy, który będę mógł nadpisać (przykładowo poprzez dodanie ``width: 240``). W tym celu tworzymy plik ``Button.qml`` i kopiujemy do niego kod naszego guzika. Musimy również wyeksportować właściwości, które użytkownik może chcieć zmieniać z poziomu nadrzędnego dokumentu.

.. literalinclude:: ../../en/ch04/src/elements/Button.qml
    :start-after: M1>>
    :end-before: <<M1

Wyeksportowaliśmy właściwość ``text`` i sygnał ``clicked``. Zazwyczaj nazywamy nasz główny element ``root``, aby ułatwić odwoływanie się do niego. Używamy też QMLowego mechanizmu ``alias``, co jest sposobem na eksportowanie właściwości zagnieżdżonych elementów do poziomu roota i udostępnienie ich światu zewnętrznemu. Należy pamiętać, że elementy spoza danego pliku będą miały dostęp tylko do właściwości wyeksportowanych do poziomu roota.

Aby użyć nowo stworzonego elementu ``Button``, wystarczy go zadeklarować w pożądanym pliku. To nieco uprości nasz poprzedni przykład.

.. literalinclude:: ../../en/ch04/src/elements/ReusableComponentExample.qml
    :start-after: M1>>
    :end-before: <<M1

Teraz możesz tworzyć tak wiele guzików jak tylko chcesz, poprzez deklarowanie ``Button { ... }``. Prawdziwy guzik mógłby być nieco bardziej zaawansowany, np. mógłby zmieniać się jakoś, gdy się na niego kliknie, lub mógłby po prostu być ładniejszy.

.. note::

    Mógłbyś również pójść krok dalej i używać ``Item`` jako elementu root. To uniemożliwiłoby użytkownikom zmianę koloru twojego guzika, a także pozwoliłoby na ściślejszą kontrolę eksportowanego API. Docelowo powinno się eksportować minimalne API. W praktyce oznacza to że mógłbyś zastąpić główny element ``Rectangle`` elementem ``Item`` i dodać ``Rectangle`` jako dziecko zagnieżdżone w głównym elemencie ``Item``.

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

Używając tej techniki w łatwy sposób można tworzyć całe serie reużywalnych komponentów.

Proste transformacje
====================

.. issues:: ch04

.. index:: Transformation, Translation, Rotation, Scaling, ClickableImage Helper, Stacking order

Transformacja manipuluje geometrią obiektu. Ogólnie rzecz biorąc, elementy ``Item`` mogą być transponowane, obracane i skalowane. Istnieją dwa podejścia do realizacji tych operacji: prosty i bardziej zaawansowany.

Zacznijmy od prostych transformacji.

Prostą transpozycję robi się poprzez modyfikację pozycji ``x,y``. Rotację -- poprzez edycję ``rotation``. Wartość rotacji podajemy w stopniach z zakresu (0 .. 360). Skalowanie robimy przy użyciu właściwości ``scale``, gdzie wartość ``<1`` oznacza, że obrazek jest pomniejszany, a ``>1`` że jest powiększany. Rotacja i skalowanie nie zmienia geometrii obrazu. Wartości ``x,y`` i ``width/height`` pozostają takie same jak na początku. Zmienia się jedynie sposób rysowania.

Zanim przejdziemy do prezentacji przykładu, chciałbym najpierw przedstawić pewną pomocną rzecz: element ``ClickableImage``. ``ClickableImage`` to po prostu obraz z wbudowanym elementem MouseArea. Zgodnie ze znaną zasadą - jeśli przekopiowałeś pewien fragment kodu trzykrotnie, wyodrębnij go do komponentu.


.. literalinclude:: ../../en/ch04/src/transformation/ClickableImage.qml
    :start-after: M1>>
    :end-before: <<M1


.. figure:: ../../en/ch04/assets/objects.png

Nasze klikalne obrazki przedstawiają trzy obiekty (okrąg, kwadrat i trójkąt). Każdy obiekt po kliknięciu na niego wykonuje pewną transformację. Kliknięcie na tło resetuje stan obrazu. 


.. literalinclude:: ../../en/ch04/src/transformation/TransformationExample.qml
    :start-after: M1>>
    :end-before: <<M1

.. figure:: ../../en/ch04/assets/objects_transformed.png

Okrąg po każdym kliknięciu zwiększa wartość swojej pozycji ``x`` o 5 px, kwadrat przy każdym kliknięciu obraca się o pewien kąt. Trójkąt zaś przy każdym kliknięciu będzie obracał się i powiększał. Przy operacjach skalowania i rotacji ustawiamy ``antialiasing: true``, żeby zaktywować anty-aliasing, który domyślnie jest wyłączony (tak samo jak właściwość przycinania ``clip``) z powodów wydajnościowych. Gdy zauważysz w swoim projekcie schodkowanie krawędzi figur na obrazie, prawdopodobnie powinieneś włączyć opcję ``antialiasing``.

.. note::

    Aby osiągnąć lepszą jakość obrazu przy skalowaniu, zaleca się skalowanie obrazów w dół zamiast w górę. Znaczne powiększenie obrazu spowoduje powstawanie artefaktów (rozmyty obraz). Skalując obraz również rozważ ustawienie ``antialiasing : true``, aby aktywować użycie filtrów wyższej jakości.


``MouseArea`` wypełnia całą powierzchnię tła. Kliknięcie na nią przywraca obiektom stan początkowy.

.. note::

    Kolejność układania elementów na obrazie jest zgodna z kolejnością w jakiej elementy pojawiały się w kodzie (tzw. `z-order`). Jeśli poklikasz na okrąg wystarczająco długo, zobaczysz jak chowa się pod kwadratem.

    .. figure:: ../../en/ch04/assets/objects_overlap.png

    Dzieje się tak dlatego, że kwadrat pojawia się później w kodzie. To samo tyczy się elementów ``MouseArea``. ``MouseArea`` występująca w kodzie później, będzie zachodziła (i tym samym zagrabiała sobie eventy z myszy) na ``MouseArea`` występującą wcześniej.

    Zapamiętaj: *Kolejność elementów w dokumencie ma znaczenie*.

Pozycjonowanie elementów
========================

.. issues:: ch04

.. index:: Row, Column, Grid, Repeater, Flow, Square Helper

Istnieje wiele elementów QML służących do pozycjonowania obiektów (tzw. pozycjonerów). W module QtQuick udostępnione są następujące pozycjonery: ``Row``, ``Column``, ``Grid`` i ``Flow``.

.. todo: illustration showing row, grid, column and flow side by side showing four images

.. note::
    
    Zanim wejdziemy w szczegóły, zacznijmy od przedstawienia pewnych elementów pomocniczych. Kwadraty: czerwony, niebieski, jaśniejszy i ciemniejszy. Każdy z nich składa się z kolorowego prostokąta o wymiarach 48x48 pikseli. Dla referencji, poniżej kod źródłowy elementu  ``RedSquare``:

    .. literalinclude:: ../../en/ch04/src/positioners/RedSquare.qml
        :start-after: M1>>
        :end-before: <<M1

Zwróć uwagę, że jaśniejszy kolor obramowania, zdefiniowany jako ``Qt.lighter(color)``, zależy od koloru wypełnienia elementu. Wytworzony element pomocniczy zaś przyda nam się w następnych przykładach, aby nieco skompresować rozmiar kodu źródłowego i, miejmy nadzieję, polepszyć jego czytelność. Zapamiętaj, że każdy prostokąt ma początkowy rozmiar 48x48 pikseli.

Element ``Column`` rozmieszcza elementy-dzieci w formie kolumny, umiejscawiając je jeden nad drugim. Właściwość ``spacing`` określa odległość dzielącą dwa sąsiednie elementy.

.. figure:: ../../en/ch04/assets/column.png

.. literalinclude:: ../../en/ch04/src/positioners/ColumnExample.qml
    :start-after: M1>>
    :end-before: <<M1

Element ``Row`` umieszcza swoje dzieci obok siebie, albo od lewej do prawej, albo od prawej do lewej, w zależności od właściwości ``layoutDirection``. Podobnie jak poprzednio, ``spacing`` używane jest do odseparowania od siebie sąsiadujących elementów-dzieci.

.. figure:: ../../en/ch04/assets/row.png

.. literalinclude:: ../../en/ch04/src/positioners/RowExample.qml
    :start-after: M1>>
    :end-before: <<M1

Element ``Grid`` rozmieszcza elementy w formie prostokątnej siatki. Liczba wierszy i kolumn może być ograniczana poprzez ustawienie właściwości ``rows`` i ``columns``. Jeśli nie zdefiniujesz którejś z tych wartości jawnie, zostanie ona obliczona na podstawie liczby elementów-dzieci. Na przykład, ustawienie ``rows`` do wartości 3 i dodanie 6 elementów do layoutu poskutkuje utworzeniem 2 kolumn. Właściwości ``flow`` i ``layoutDirection`` definiują kolejność, w której elementy są dodawane do siatki, podczas gdy ``spacing`` określa odległość dzielącą elementy w layoucie.


.. figure:: ../../en/ch04/assets/grid.png

.. literalinclude:: ../../en/ch04/src/positioners/GridExample.qml
    :start-after: M1>>
    :end-before: <<M1

Ostatnim z dostępnych pozycjonerów jest element ``Flow``. Dodaje on elementy jeden po drugim, niczym słowa na kartce, zawijając wiersz gdy to konieczne. Układ dodawania dzieci jest zdefiniowany przy użyciu właściwości ``flow`` i ``layoutDirection``. Może on przebiegać z jednego boku na drugi, lub z góry na dół. ``layoutDirection`` określa, czy elementy układane są z lewa na prawo czy na odwrót. Dokładane elementy formują nowe kolumny lub wiersze, gdy jest to konieczne. Warunkiem koniecznym do działania elementu ``Flow`` jest określenie jego szerokości lub wysokości. Może być to zrobione jawnie lub poprzez zakotwiczanie layoutów.

.. figure:: ../../en/ch04/assets/flow.png

.. literalinclude:: ../../en/ch04/src/positioners/FlowExample.qml
    :start-after: M1>>
    :end-before: <<M1

Elementy często są również pozycjonowane przy użyciu elementu ``Repeater``. Działa on jak pętla for, która iteruje po elementach modelu. W najprostszym przypadku model jest jedynie wartością określającą liczbę iteracji.


.. figure:: ../../en/ch04/assets/repeater.png

.. literalinclude:: ../../en/ch04/src/positioners/RepeaterExample.qml
    :start-after: M1>>
    :end-before: <<M1

W tym przykładzie wprowadzamy pewną magię. Zdefiniowaliśmy naszą własną właściwość, której używamy jako tablicy kolorów. ``Repeater`` tworzy zestaw prostokątów (16, zgodnie z modelem). W każdym przejściu pętli tworzy on prostokąt zdefiniowany jako jego dziecko. Kolor prostokąta wybierany jest przy użyciu matematycznych funkcji JS ``Math.floor(Math.random()*3)``. To daje nam losowy numer z zakresu 0..2, który używamy jako indeks wybranego koloru z tablicy kolorów. Jak już zauważyliśmy wcześniej, JavaScript jest częścią QtQuick, zatem takie standardowe biblioteki są dla nas dostępne.

W repeaterze dostępna jest właściwość ``index``. Odpowiada ona obecnemu indeksowi przejścia pętli (0,1,..15). Możemy używać go do dowolnych decyzji bazujących na indeksie, lub tak jak w naszym przypadku, do wydrukowania indeksu przy pomocy elementu ``Text``.

.. note::

    Bardziej zaawansowanej obsłudze większych modeli lub widoków z dynamicznymi delegatami jest poświęcony osobny rozdział o koncepcji model-view. Repeatery są dobrym wyborem, kiedy mamy do zaprezentowania niewielką ilość danych statycznych.


Layouty
=======

.. issues:: ch04

.. index:: anchors

.. todo:: do we need to remove all uses of anchors earlier?

QML dostarcza elastyczny sposób na rozmieszczanie elementów przy użyciu zakotwiczenia -- właściwości ``anchors``. Koncept zakotwiczania jest częścią podstawowych właściwości elementu ``Item`` i jest dostępny we wszystkich graficznych elementach QML. Zakotwiczenie zachowuje się jak kontrakt, który jest silniejszy niż zmiany w geometrii powiązanych elementów. Zakotwiczanie wyraża zależność położenia jednego elementu od drugiego, zawsze musi istnieć element względem którego chcesz coś ustawić.

.. figure:: ../../en/ch04/assets/anchors.png

Element ma 6 głównych linii zakotwiczenia (top, bottom, left, right, horizontalCenter, verticalCenter). Ponadto dla elementów ``Text`` istnieje jeszcze ``anchors.baseline``. Do każdej z linii zakotwiczenia można dodać jeszcze odstęp. W przypadku top, bottom, left i right nazywa się on ``margins``. Dla horizontalCenter, verticalCenter i baseline nazywa się ``offset``.

.. figure:: ../../en/ch04/assets/anchorgrid.png

#. Element wypełnia obszar swojego elementu-rodzica

    .. literalinclude:: ../../en/ch04/src/anchors/AnchorsExample.qml
        :start-after: M1>>
        :end-before: <<M1


#. Element jest wyrównany do lewej strony swojego rodzica

    .. literalinclude:: ../../en/ch04/src/anchors/AnchorsExample.qml
        :start-after: M2>>
        :end-before: <<M2

#. Element przylega swoim lewym brzegiem do prawego brzegu rodzica

    .. literalinclude:: ../../en/ch04/src/anchors/AnchorsExample.qml
        :start-after: M3>>
        :end-before: <<M3

#. Wyśrodkowane elementy. ``Blue1`` jest wyśrodkowane horyzontalnie względem rodzica. ``Blue2`` również jest wyśrodkowane horyzontalnie, ale względem ``Blue1``, a jego górny brzeg wyrównany jest do dolnej krawędzi ``Blue1``.

    .. literalinclude:: ../../en/ch04/src/anchors/AnchorsExample.qml
        :start-after: M4>>
        :end-before: <<M4


#. Element jest wypośrodkowany wewnątrz rodzica

    .. literalinclude:: ../../en/ch04/src/anchors/AnchorsExample.qml
        :start-after: M5>>
        :end-before: <<M5


#. Element jest wypośrodkowany wewnątrz rodzica i przesunięty w lewo

    .. literalinclude:: ../../en/ch04/src/anchors/AnchorsExample.qml
        :start-after: M6>>
        :end-before: <<M6

.. note:: Nasze kwadraty zostały wzbogacone o możliwość przeciągania ich. Uruchom kod z przykładów i poruszaj kwadratami. Zobaczysz, że kwadratu (1) nie da się poruszyć, ponieważ jest zakotwiczony ze wszystkich stron, jednak możesz poruszać rodzicem (1), który nie jest w ogóle zakotwiczony. (2) może być poruszany tylko z góry na dół, ponieważ tylko jego lewa strona jest zakotwiczona. To samo tyczy się (3). (4) również może być poruszany tylko pionowo, ponieważ oba prostokąty są wycentrowane horyzontalnie. (5) jest wyśrodkowany wewnątrz rodzica i dlatego w ogóle nie może być przeciągany, tak samo jak (6). Przeciąganie elementu oznacza zmienianie jego pozycji ``x,y``. Ponieważ zakotwiczenie jest silniejsze niż zmiany w geometrii takie jak zmiany ``x,y``, przeciąganie jest ograniczane przez istniejące relacje ``anchors``. Spotkamy się jeszcze z tym efektem później, przy okazji omawiania animacji.


Elementy wejścia
================

.. issues:: ch04

.. index:: TextInput, TextEdit, FocusScope, focus, Keys, KeyNavigation

Używaliśmy już ``MouseArea`` w roli elementu obsługującego wejście z myszy. Teraz skupimy się na wprowadzaniu danych z klawiatury. Zaczniemy od elementów do edycji tekstu: ``TextInput`` and ``TextEdit``.

TextInput
---------

.. issues:: ch04

``TextInput`` pozwala użytkownikowi na wpisanie linii tekstu. Element wspiera operacje na wejściu takie jak ``validator``, ``inputMask``, i ``echoMode``.

.. literalinclude:: ../../en/ch04/src/input/TextInputExample.qml
    :start-after: M1>>
    :end-before: <<M1

.. figure:: ../../en/ch04/assets/textinput.png

Użytkownik klikając na obszarze ``TextInput`` ustawia na nim focus. Aby było możliwe zmienianie focusa z klawiatury, możemy użyć dołączonej właściwości ``KeyNavigation``.

.. literalinclude:: ../../en/ch04/src/input/TextInputExample2.qml
    :start-after: M1>>
    :end-before: <<M1

Dołączona właściwość ``KeyNavigation`` zawiera zestaw przycisków z klawiatury. Do każdego z nich może być przypisane id elementu, do którego chcemy skierować focusa po wciśnięciu danego klawisza.

``TextInput`` nie ma żadnych wizualnych elementów poza mrugającym kursorem i wpisanym tekstem. Użytkownik zaś potrzebuje pewnych wizualnych dekoracji, aby rozpoznać element wejściowy, np. można go po prostu umieścić wewnątrz narysowanego prostokąta. Umieszczając ``TextInput`` wewnątrz innych elementów pamiętaj jednak abyś wyeksportował główne właściwości, które powinny być dostępne dla innych.

Zwiększmy reużywalność tego kodu i przeniesiemy go do nowego komponentu nazwanego ``TLineEditV1``.

.. literalinclude:: ../../en/ch04/src/input/TLineEditV1.qml
    :start-after: M1>>
    :end-before: <<M1

.. note::
    Jeśli chcesz całkowicie wyeksportować element ``TextInput`` z wnętrza elementu zewnętrznego, możesz to zrobić pisząc ``property alias input: input``. Pierwsze wystąpienie ``input`` oznacza nazwę nowej właściwości, podczas gdy drugie to id eksportowanego elementu.

Przepiszmy nasz przykład `KeyNavigation`` na nowo, tym razem używając komponentu ``TLineEditV1``.


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

.. figure:: ../../en/ch04/assets/textinput3.png

Teraz spróbuj przełączać aktywny element za pomocą klawisza Tab. Zobaczysz, że focus wcale nie przechodzi do elementu ``input2``. Proste zadeklarowanie ``focus:true`` nie wystarcza. Dzieje się tak dlatego, że focusa otrzymał element ``input2``, będący bezpośrednim dzieckiem prostokąta Rectangle, ale nie przekazał tego focusa do elementu TextInput. Aby uniknąć tego typu trudności QML oferuje element FocusScope.


FocusScope
----------

.. issues:: ch04

FocusScope zapewnia, że ostatnie z jego dzieci z właściwością ``focus:true`` otrzyma focusa, w momencie kiedy on sam otrzyma focusa. Zatem ten element przekazuje focusa do ostatniego dziecka, które go oczekuje. Stworzymy drugą wersję TLineEdit o nazwie TLineEditV2, której głównym elementem będzie FocusScope.


.. literalinclude:: ../../en/ch04/src/input/TLineEditV2.qml
    :start-after: M1>>
    :end-before: <<M1

Nasz przykład wygląda teraz tak:

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

Teraz zgodnie z oczekiwaniami wciskanie Taba powoduje przechodzenie focusa pomiędzy dwoma elementami i podświetlane jest właściwe dziecko wewnątrz danego komponentu.


TextEdit
--------

.. issues:: ch04

Element ``TextEdit`` jest bardzo podobny do ``TextInput``, jednak wspiera on dodatkowo obsługę wieloliniowego pola tekstowego. Stworzymy teraz komponent ``TTextEdit``, edytowalne pole tekstowe z kolorowym tłem, używające FocusScope dla łatwiejszego przekazywania focusa.

.. literalinclude:: ../../en/ch04/src/input/TTextEdit.qml
    :start-after: M1>>
    :end-before: <<M1

Możesz go używać tak samo jak komponentu ``TLineEdit``.

.. literalinclude:: ../../en/ch04/src/input/TextEditExample.qml
    :start-after: M1>>
    :end-before: <<M1

.. figure:: ../../en/ch04/assets/textedit.png

Element Keys
------------

.. issues:: ch04

Dołączona właściwość ``Keys`` umożliwia wykonywanie dowolnej reakcji w odpowiedzi na wciskanie klawiszy. Na przykład, możemy przesuwać kwadrat przy użyciu strzałek w górę, dół, lewo i prawo, oraz powiększać go i pomniejszać przy użyciu plusa i minusa.


.. literalinclude:: ../../en/ch04/src/input/KeysExample.qml
    :start-after: M1>>
    :end-before: <<M1

.. figure:: ../../en/ch04/assets/keys.png


Zaawansowane techniki
=====================

.. issues:: ch04

.. todo:: To be written







