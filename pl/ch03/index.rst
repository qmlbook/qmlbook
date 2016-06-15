==============
Qt Creator IDE
==============

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_ , `katecpp <https://github.com/katecpp>`_

.. issues:: ch03

Qt Creator jest domyślnym zintegrowanym środowiskiem napisanym przez deweloperów Qt dla deweloperów Qt. Jest on dostępny na wszystkich głównych platformach takich jak Windows/Mac/Linux. Widzieliśmy też przypadki używania Qt Creatora na urządzeniach embedded. Qt Creator wyróżnia się bardzo efektywnym interfejsem użytkownika i jest perłą wśród narzędzi poprawiających wydajność programisty. Za pomocą Qt Creatora możesz uruchamiać interfejsy napisane w Qt Quick i kompilować kod C++ - zarówno na swój obecny system, jak i na inne urządzenie przy pomocy kompilatora skrośnego (tzw. *cross-compiler*).

.. figure:: ../../en/ch03/assets/qtcreator-screenshots.png

.. note::

    Kod źródłowy przykładów z tego rozdziału znajduje się w `folderze assets <../../assets>`_.

Interfejs użytkownika
=====================

.. issues:: ch03

Po uruchomieniu Qt Creatora przywita Cię ekran *Welcome*. To tutaj znajdziesz najważniejsze porady na temat dalszej pracy z tym IDE oraz odnośniki do ostatnio otwieranych projektów. Tutaj również znajdziesz listę sesji *Sessions*, która może być u Ciebie pusta. Sesja to zbiór projektów powiązanych ze sobą w jakiś sposób. Jest to bardzo wygodne, kiedy jednocześnie prowadzisz projekty dla kilku klientów.

Po lewej stronie aplikacji znajduje się pasek wyboru trybu pracy. Poszczególne tryby odpowiadają typowym etapom pracy nad projektem:

* `Welcome`: Wstępna orientacja
* `Edit`: Edycja kodu
* `Design`: Edycja interfejsów graficznych
* `Debug`: Uzyskiwanie informacji o działającej aplikacji
* `Projects`: Edycja konfiguracji projektu
* `Analyze`: Profilowanie i wykrywanie wycieków pamięci
* `Help`: Łatwy dostęp do dokumentacji Qt

Poniżej znajdują się przyciski do wyboru aktualnej konfiguracji projektu i uruchamiania aplikacji w trybie zwykłym i debugowym.

.. figure:: ../../en/ch03/assets/creator-welcome.png
	:scale: 50%

Większość czasu spędzisz w trybie Edit, tworząc i modyfikując kod źródłowy swojego programu. Od czasu do czasu, kiedy niezbędne będzie wprowadzenie zmian do konfiguracji projektu, będziesz odwiedzał tryb Projects. Aby zbudować projekt, wystarczy wcisnąć ``Run``. Qt Creator jest na tyle mądry, że sam zadba o odpowiednie przebudowanie programu, zanim go uruchomi.

Na dole są okna z informacjami na temat problemów, wiadomości z aplikacji, kompilacji itp.

Zarejestrowanie Qt Kit
======================

.. issues:: ch03

Qt Kit jest początkowo najprawdopodobniej najtrudniejszym aspektem w pracy z Qt Creatorem. Qt Kit to zestaw zawierający wersję Qt, kompilator, docelowe urządzenie i inne ustawienia. Ustawienia te jednoznacznie określają zestaw narzędzi używanych do budowania Twojego projektu. Typowy zestaw dla aplikacji desktopowych zawiera kompilator GCC i wersję Qt (np. Qt 5.1.1) oraz urządzenie ("Desktop"). Po stworzeniu nowego projektu zawsze musisz przypisać jakiś Qt Kit, żeby móc budować projekt z poziomu Qt Creatora. Do stworzenia Qt Kit natomiast potrzebujesz zainstalowanego kompilatora i zarejestrowanej wersji Qt. Qt rejestrujesz poprzez podanie ścieżki do ``qmake``. Na podstawie ścieżki do ``qmake`` Qt Creator jest w stanie określić używaną przez Ciebie wersję Qt.

Dodawanie Qt Kit i rejestrowanie wersji Qt odbywa się w zakładce :menuselection:`Settings --> Build & Run`. Tam też możesz sprawdzić zarejestrowane kompilatory.


.. note::

    Sprawdź najpierw, czy masz zarejestrowaną wersję Qt w Qt Creatorze, a następnie zadbaj o odpowiedni Qt Kit dla wybranego przez Ciebie kompilatora, wersji Qt i docelowego urządzenia. Bez ustawionego Qt Kit nie zbudujesz projektu.


Zarządzanie projektami
======================

.. issues:: ch03

Qt Creator przechowuje Twój kod źródłowy w postaci poszczególnych projektów. Możesz stworzyć nowy projekt wybierając :menuselection:`File --> New File or Project`. Będziesz wtedy poproszony o wybór jednego z wielu szablonów aplikacji. Qt Creator może tworzyć aplikacje desktopowe i mobilne, zbudowane w oparciu o widgety lub o Qt Quick, samodzielne kontrolki albo nawet zwykłe C++ projekty bez Qt. Wspierane są również projekty oparte o HTML5 lub pythona. Początkującego taki wybór może przytłoczyć, dlatego teraz wskażemy Ci trzy najważniejsze dla Ciebie typy projektów.

* **Applications / Qt Quick 2.0 UI**: To stworzy dla Ciebie projekt dla QML/JS, bez fragmentów C++. Wybierz tę opcję jeśli chcesz naszkicować nowy interfejs użytkownika lub planujesz stworzyć nowoczesną aplikację z UI, gdzie natywne części funkcjonalności dostarczane są przez pluginy.
* **Libraries / Qt Quick 2.0 Extension Plug-in**: Użyj tej opcji, jeśli chcesz stworzyć plugin dla swojej aplikacji Qt Quick UI. Plugin jest używany do rozszerzania Qt Quick elementami natywnymi.
* **Other Project / Empty Qt Project**: Zupełnie pusty projekt. Wybierz tę opcję jeśli chcesz programować swoją aplikację w C++ od zera.

.. note::

    W początkowych częściach tej książki będziemy używali głównie projektów typu Qt Quick 2.0 UI. Później, by opisać pewne aspekty C++, będziemy używali także Empty-Qt-Project lub podobnych. W celu rozszerzania Qt Quicka swoimi własnymi natywnymi pluginami będziemy używali typu *Qt Quick 2.0 Extension Plug-in*.


Obsługa edytora
===============

.. issues:: ch03

Po otworzeniu lub stworzeniu nowego projektu Qt Creator przełączy się w tryb edycji. Po lewej powinieneś teraz widzieć pliki wchodzące w skład projektu, a na środku edytor kodu. Zaznaczenie pliku po lewej otworzy ten plik w edytorze. Edytor koloruje składnię, dostarcza mechanizmy automatycznego uzupełniania kodu i szybkiego poprawiania błędów. Wspiera również kilka poleceń do refaktorowania kodu. Pracując z Qt Creatorem będziesz miał wrażenie, że wszystko reaguje natychmiastowo. To dzięki programistom Qt, którzy nadali temu narzędziu tak żwawy charakter.

.. figure:: ../../en/ch03/assets/creator-editor.png
	:scale: 50%


Lokalizator
===========

.. issues:: ch03

Lokalizator jest centralnym komponentem Qt Creatora. Pozwala on deweloperowi w szybki sposób poruszać się pomiędzy specyficznymi miejscami w kodzie lub w dokumentacji. Aby otworzyć lokalizator, wciśnij :kbd:`Ctrl+K`.


.. figure:: ../../en/ch03/assets/locator.png
	:scale: 50%

W lewym dolnym rogu pojawi się pop-up z listą opcji. Jeśli szukasz pliku ze swojego projektu, zacznij wpisywać początkowe litery nazwy pliku, a plik zostanie wyfiltrowany. Lokalizator również akceptuje znaki wieloznaczne (tzw. wildcard), a zatem ``*main.qml`` także zadziała.


.. figure:: ../../en/ch03/assets/creator-locator.png
	:scale: 50%

Teraz samemu poeksperymentuj z lokalizatorem. Na przykład, aby odnaleźć dokumentację dla QML-owego elementu **Rectangle**, otwórz lokalizator i wpisz ``? rectangle``. Podczas gdy Ty wpisujesz kolejne litery, lokalizator odświeża sugerowane odnośniki, aż znajdziesz ten jeden, którego szukasz.


Debugowanie
===========

.. issues:: ch03

Qt Creator wspiera debugowanie C++ oraz QMLa.

.. note::

    Hmm, właśnie zauważyłem, że nie używałem zbyt wiele funkcji debugowania. Mam nadzieję, że jest to dobry znak. Muszę tutaj kogoś poprosić o pomoc. W międzyczasie poczytaj sobie `dokumentację Qt Creatora <http://http://doc.qt.io/qtcreator/index.html>`_.


Skróty klawiszowe
=================

.. issues:: ch03

Skróty klawiszowe są tym co wyróżnia systemy wygodne w użyciu. Jako zawodowy programista spędzisz setki godzin pracując ze swoją aplikacją. Każdy skrót klawiszowy, który przyspiesza Twoją pracę, ma ogromne znaczenie. Na szczęście deweloperzy Qt Creatora mają to samo zdanie i dodali dosłownie setki skrótow do tego IDE.

Na początek kolekcja najbardziej podstawowych skrótow (notacja Windowsowa):

* :kbd:`Ctrl+B` - Buduj projekt
* :kbd:`Ctrl+R` - Uruchom projekt
* :kbd:`Ctrl+Tab` - Przełączaj się między otwartymi dokumentami
* :kbd:`Ctrl+K` - Otwórz lokalizator
* :kbd:`Esc` - Powrót (wciśnij kilka razy by powrócić do trybu edycji)
* :kbd:`F2` - Idź do definicji symbolu pod kursorem
* :kbd:`F4` - Przełącz między nagłówkiem a źródłem (przydatne tylko dla kodu C++)

Lista `skrótów klawiszowych Qt Creatora <http://doc.qt.io/qtcreator/creator-keyboard-shortcuts.html>`_ z dokumentacji.


.. note::

    Możesz edytować skróty klawiszowe w ustawieniach Qt Creatora.

        .. figure:: ../../en/ch03/assets/creator-edit-shortcuts.png
		:scale: 50%

