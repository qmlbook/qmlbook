===================
Introduzione a Qt 5
===================

.. sectionauthor:: `jryannel <https://github.com/jryannel>`_, `marco-piccolino <https://github.com/marco-piccolino>`_

.. issues:: ch01

.. note::

    Il codice sorgente associato a questo capitolo è disponibile nella cartella `assets <../../assets>`_.

Questo libro vuole offrire una panoramica sui diversi aspetti legati allo sviluppo di applicazioni con Qt, versione 5.x. Il libro è incentrato sulla nuova tecnologia di Qt Quick, ma allo stesso tempo fornisce le informazioni necessarie per scrivere back-end in C++, come anche estensioni per Qt Quick.

Questo capitolo fornisce una visione d'insieme di Qt 5. Il capitolo mostra sia le varie tipologie di applicazione a disposizione degli sviluppatori che un'applicazione dimostrativa, in modo da fornire un'anteprima degli argomenti che verranno affrontati. Inoltre, il capitolo vuole offrire una panoramica sul contenuto di Qt 5 e mostrare come entrare in contatto con i suoi creatori.


Prefazione
==========

.. rubric:: Storia

Qt 4 ha visto un progresso costante dal 2005, ed ha rappresentato una base solida per migliaia di applicazioni, e persino sistemi desktop e mobile completi.- Negli ultimi anni, gli utenti dei personal computer hanno modificato considerevolmente le proprie abitudini di utilizzo. Dai PC da tavolo si è passati ai notebook portatili e, infine, ai computer tascabili. Il desktop classico viene via via rimpiazzato da schermi portatili, basati sul touch e costantemente connessi. Questi cambiamenti vanno di passo con cambiamenti nella User Experience anche su desktop. Mentre nel passato le interfacce utente di Windows dominavano il mondo, oggigiorno spendiamo più tempo su schermi di altro tipo e interfacce che utilizzano un linguaggio differente.

Qt 4 è stato disegnato per soddisfare il mondo desktop e per fornire un set di widget per interfacce utente su tutte le maggiori piattaforme. La sfida per gli utenti di Qt oggi è cambiata, e la sfida principale è quella di fornire interfacce utente basate sul touch, i cui requisiti vengono definiti dai clienti, e che devono essere in grado di fornire un'esperienza d'uso moderna su tutti i maggiori sistemi desktop e mobile. Qt 4.7 ha introdotto la tecnologia QtQuick, che permette agli utenti di creare una serie di componenti UI partendo da elementi semplici, per poter così ottenere interfacce utente completamente nuove, definite dalle richieste dei clienti.

Il focus di Qt5
---------------

Qt 5 è una versione completamente rinnovata rispetto alla release di grande successo di Qt 4. Con la versione 4.8, Qt 4 ha ormai 7 anni. Era quindi il momento di rendere un toolkit eccezionale ancora migliore. Qt 5 è incentrato sui seguenti aspetti:

* **Grafica eccellente**: Qt Quick 2 si appoggia su OpenGL (ES) e utilizza un'implementazione basata su scene graph. Questa nuova composizione dello stack grafico consente di raggiungere nuovi livelli in termini di effetti grafici, combinati ad una semplicità di utilizzo mai vista prima in questo campo.

* **Produttività degli sviluppatori**: QML e JavaScript sono gli strumenti principali per la creazione delle UI. Il back-end sarà gestito dal codice in C++. La divisione netta tra JavaScript e C++  consente iterazioni rapide sia per gli sviluppatori front-end, che possono così concentrarsi sulla creazione di interfacce utente eleganti, sia per gli sviluppatori back-end in C++, che si possono concentrare su stabilità, performance ed estensioni del runtime.

* **Portabilità cross-platform**: Con la tecnologia consolidata della Qt Platform Abstraction, è ora possibile portare Qt su una gamma più ampia di piattaforme in maniera più semplice e rapida. Qt 5 si fonda sul concetto di Qt Essentials e di Add-ons, che consente agli sviluppatori OS di concentrarsi sui moduli essenziali e permette inoltre di ottenere dei runtime di dimensioni inferiori.

* **Sviluppo Open**: Qt è ora veramente un progetto di tipo open-governance, ospitato su `Qt-Project <http://qt-project.org>`_. Lo sviluppo è open e guidato dalla community.



Introduzione a Qt5
==================


Qt Quick
--------

Qt Quick è il termine onnicomprensivo per la tecnologia dell'interfaccia utente utilizzata in Qt5. Qt Quick di per sé è una collezione di diverse tecnologie:

* QML - Linguaggio markup per interfacce utente
* JavaScript - Il linguaggio di scripting dinamico
* Qt C++ - La libreria c++ avanzata altamente portabile

.. image:: ../../en/ch01/assets/qt5_overview.png


Similmente ad HTML, QML è un linguaggio di markup. E' costituito da tags che in QtQuick vengono chiamati elementi, i quali vengono racchiusi in parentesi graffe ``Item {}``. E' stato progettato fin dall'origine per la creazione di interfacce utente, per la velocità e per essere di facile lettura per gli sviluppatori. L'interfaccia utente può essere potenziata tramite l'utilizzo di codice JavaScript. Qt Quick è facilmente estendibile con funzionalità native custom tramite Qt C++. Sinteticamente, la UI dichiarativa viene chiamata front-end e le parti native vengono chiamate back-end. La distinzione permette di separare le operazioni native e computazionalmente onerose di un'applicazione dalla parte dell'interfaccia grafica.

In un progetto tipico, il front-end viene sviluppato in QML/JavaScript, mentre il codice back-end, che si interfaccia col sistema e si occupa del lavoro pesante, viene sviluppato usando Qt C++. Ciò permette una divisione naturale tra gli sviluppatori più orientati al design e gli sviluppatori funzionali. Tipicamente, il back-end viene testato utilizzando il testing framework proprio di Qt, e viene quindi esportato per l'utilizzo da parte degli sviluppatori front-end.


Assimilare un'Interfaccia Utente
--------------------------------

Usando QtQuick, creeremo ora una semplice interfaccia utente che dimostra alcuni aspetti del linguaggio QML. Il risultato finale sarà una girandola con le pale che ruotano.


.. image:: ../../en/ch01/assets/scene.png
    :scale: 50%


Cominciamo da un documento vuoto che chiamiamo ``main.qml``. Tutti i file QML conterranno l'estensione ``.qml``. Essendo un linguaggio di markup (come l'HTML) un documento QML deve avere uno e uno solo elemento radice che, nel nostro caso, è l'elemento ``Image``, che ha larghezza e altezza basate sulla geometria dell'immagine di sfondo:

.. code-block:: qml

    import QtQuick 2.3

    Image {
        id: root
        source: "images/background.png"
    }

Poiché il QML non pone alcun tipo di restrizione sul tipo di elemento che può essere l'elemento radice, utilizziamo un elemento ``Image`` con la proprietà source (sorgente) settata all'immagine di background.


.. image:: ../../en/ch01/src/showcase/images/background.png


.. note::

    Ogni elemento ha diverse proprietà, per esempio un'immagine ha le proprietà ``width``, ``height`` come anche altre proprietà, quali ``source``.  Le dimensioni dell'elemento Image vengono desunte automaticamente dalle dimensioni dell'immagine sorgente. In alternativa, dovremmo settare le proprietà ``width`` e ``height`` a valori in pixel che siano ragionevoli.

    Gli elementi più comuni sono localizzati nel modulo ``QtQuick`` che abbiamo incluso nella prima riga con la dichiarazione di import.

    La proprietà speciale ``id`` è opzionale e contiene un identificativo per fare riferimento all'elemento in altre sezioni del documento. Importante: Una proprietà ``id`` non può venire modificata dopo che è stata creata, e non può venire settata al runtime. L'utilizzo di ``root`` come id per l'elemento radice è solo un'abitudine dell'autore che permette di fare riferimento all'elemento più in alto nella gerarchia in documenti QML di una certa lunghezza.

Gli elementi in primo piano dell'interfaccia utente (l'asta e la girandola) sono localizzati in immagini separate.

.. image:: ../../en/ch01/src/showcase/images/pole.png
.. image:: ../../en/ch01/src/showcase/images/pinwheel.png

L'asta (pole) va posizionata al centro orizontale dello sfondo, verso il basso. E la girandola (pinwheel) va posizionata al centro dello sfondo.

Di regola l'interfaccia utente sarà composta da molti elementi di tipo differente, e non solo immagini come in questo esempio.


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



Per posizionare la girandola al centro utilizziamo una proprietà complessa chiamata ``anchor``. L'ancoraggio permette di specificare relazioni geometriche tra oggetti che hanno relazione padre-figlio e fratelli. Es.: Posizionami al centro di un altro elemento (``anchors.centerIn:parent``). Da entrambe le parti, sono disponibili le seguenti relazioni: left, right, top, bottom, centerIn, fill, verticalCenter e horizontalCenter. E' necessario che le relazioni siano concordanti: per esempio, non ha senso ancorare il lato sinistro (left) di un elemento al lato superiore (top) di un altro elemento.

Quindi, andiamo a settare la girandola come centrata rispetto al genitore (parent), l'immagine di sfondo.

.. note::

    A volte sarà necessario effettuare piccoli aggiustamenti rispetto alla centratura esatta. Questa operazione è resa possibile dalle proprietà ``anchors.horizontalCenterOffset`` e ``anchors.verticalCenterOffset``. Proprietà di aggiustamento simili sono disponibili anche per tutti gli altri punti di ancoraggio. Per una lista completa delle proprietà di ancoraggio, consultare la documentazione.

.. note::

    Posizionare un'immagine come elemento figlio del rettangolo radice mostra un aspetto importante dei linguaggi dichiarativi. L'interfaccia utente viene descritta seguendo l'ordine di livelli e gruppi, dove il livello più alto (il nostro rettangolo) è il primo ad essere disegnato, mentre i livelli figli vengono disegnati davanti ad esso, secondo il sistema di coordinate locale dell'elemento contenitore.

Per rendere questa dimostrazione più interessante, potremmo ora rendere la scena interattiva. L'idea è quella di rotare la girandola quando l'utente preme il tasto del mouse da qualche parte nella scena.


Per fare questo, utilizziamo l'elemento ``MouseArea`` e gli attribuiamo le stesse dimensioni dell'elemento radice.

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

L'area del mouse emette dei segnali (signals) quando l'utente clicca al suo interno. E' possibile intercettare questo segnale sovrascrivendo la funzione ``onClicked``. Nel caso specifico, facciamo riferimento alla girandola e ne modifichiamo la rotazione di +90 gradi.

.. note::

    Questo meccanismo funziona per ogni segnale, la convenzione per il nome della funzione è ``on`` + ``NomeDelSegnale``. Inoltre, tutte le proprietà emettono un segnale una volta che il loro valore è cambiato. La convenzione per il nome è:

        ``on`` + ``NomeProprietà`` + ``Changed``

    Per esempio, se una proprietà ``width`` cambia, è possibile osservarla con ``onWidthChanged: print(width)``.

Ora la girandola ruota, ma non in modo fluido. La proprietà rotation cambia immediatamente. Invece, vorremmo che la proprietà cambiasse di 90 gradi in un arco di tempo. A questo punto entrano in gioco le animazioni. Un'animazione definisce come il cambio di una proprietà debba essere distribuito lungo un periodo di tempo. Per abilitare questo comportamento, utilizziamo un tipo di animazione chiamato property behavior. Il ``Behaviour`` (comportamento) specifica un'animazione per una certa proprietà che si applica ad ogni cambiamento di quella proprietà. In breve, ogni volta che la proprietà cambia, l'animazione viene lanciata. Questo è solo uno dei tanti modi che esistono per dichiarare un'animazione in QML.

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

Ora, ogniqualvolta la proprietà rotation della girandola cambia, essa verrà animata utilizzando una ``NumberAnimation`` della durata di 250 ms. Ovvero, ogni rotazione di 90 gradi impiegherà 250 ms.

.. image:: ../../en/ch01/assets/scene2.png
    :scale: 50%

.. note:: In realtà, la girandola non apparirà sfocata. Lo sfocamento serve solo ad indicare la rotazione. Tuttavia, nella cartella degli assets è presente una girandola sfocata. Forse vuoi provare ad utilizzarla.


Ora la girandola ha già un aspetto molto migliore. Spero che questo esempio ti abbia dato una prima impressione di come funzioni la programmazione in Qt Quick.

Gli ingredienti di Qt
=====================

Qt 5 consiste di una grande quantità di moduli. Generalmente, un modulo è una libreria che può essere utilizzata dallo sviluppatore. Alcuni moduli sono obbligatori per ogni piattaforma che supporta Qt. Tali moduli formano un insieme chiamato *Qt Essentials Modules*. Molti moduli sono opzionali e formano i *Qt Add-On Modules*. E' probabile che la maggior parte degli sviluppatori non abbia bisogno di tali moduli, ma conoscerli è buona cosa in quanto essi forniscono soluzioni egregie a problemi ricorrenti.

I moduli Qt
-----------

I Qt Essentials modules sono obbligatori per ogni piattaforma che supporta Qt. Essi forniscono le basi per sviluppare un'applicazione Qt 5 moderna utilizzando Qt Quick 2.

.. rubric:: Core-Essential Modules

Il set minimo di moduli Qt 5 per iniziare la programmazione in QML.

.. list-table::
    :widths: 20 80
    :header-rows: 1

    *   - Modulo
        - Descrizione
    *   - Qt Core
        - Le classi fondamentali non grafiche utilizzate dagli altri moduli
    *   - Qt GUI
        - Classi base per componenti di interfaccia grafica utente (GUI). Include OpenGL.
    *   - Qt Multimedia
        - Classi per funzionalità audio, video, radio e camera.
    *   - Qt Network
        - Classi che rendono la programmazione di rete più semplice e portabile.
    *   - Qt QML
        - Classi per i linguaggi QML e JavaScript.
    *   - Qt Quick
        - Framework dichiarativo per la costruzione di applicazioni altamente dinamiche con interfacce utente personalizzate.
    *   - Qt SQL
        - Classi per l'integrazione di database utilizzando SQL.
    *   - Qt Test
        - Classi per lo unit testing di applicazioni e librerie Qt.
    *   - Qt WebKit
        - Classi per un'implementazione basata su WebKit2 ed una nuova API in QML. Vedi anche Qt WebKit Widgets nei moduli add-on.
    *   - Qt WebKit Widgets
        - Classi di Qt 4 basate su WebKit1 e QWidget.
    *   - Qt Widgets
        - Classi per estendere Qt GUI con widget C++.


.. digraph:: essentials

    QtGui -> QtCore
    QtNetwork ->QtCore
    QtMultimedia ->QtGui
    QtQml -> QtCore
    QtQuick -> QtQml
    QtSql -> QtCore


.. rubric:: Moduli Addon Qt

Oltre ai moduli essenziali, Qt offre agli sviluppatori software moduli addizionali che non fanno parte della distribuzione. Ecco un breve elenco di moduli addizionali disponibili.

* Qt 3D - Una serie di API che rendono la programmazione grafica 3D semplice e dichiarativa.
* Qt Bluetooth - API in C++ e QML per piattaforme che utilizzano la tecnologia wireless Bluetooth.
* Qt Contacts - API in C++ e QML per accedere alle rubriche e ai database dei contatti.
* Qt Location - Mette a disposizione posizionamento, mappe, navigazione e ricerca dei luoghi tramite interfacce QML e C++. back-end NMEA per il posizionamento
* Qt Organizer - API in C++ e QML per accedere agli eventi dell'agenda (memo, eventi, etc.).
* Qt Publish and Subscribe.
* Qt Sensors - Accesso ai sensori tramite interfacce QML e C++.
* Qt Service Framework -  Permette alle applicazioni di leggere, sfogliare e sottoscrivere notifiche di cambiamento.
* Qt System Info - Per accedere alle informazioni e capacità del sistema.
* Qt Versit - Supporto per i formati vCard e iCalendar.
* Qt Wayland - Solo per Linux. Include l'API Qt Compositor (server), e il plugin per piattaforme Wayland (clients).
* Qt Feedback - Riscontro tattile e audio alle azioni degli utenti.
* Qt JSON DB - Un sistema di immagazzinamento dati non basato su SQL.

.. note::

    Poiché questi moduli non fanno parte della distribuzione, il loro stato varia, a seconda di quanti contributori siano attivi e di quanto vengano testati.

Piattaforme Supportate
----------------------

Qt supporta numerose piattaforme. Tutte le maggiori piattaforme sia desktop che embedded sono supportate. Tramite la Qt Application Abstraction, oggi risulta più semplice portare Qt sulla tua piattaforma, se necessario.

Testare Qt 5 su una piattaforma è dispendioso in termini di tempo. Un sottoinsieme delle piattaforme è stato selezionato dal qt-project per costituire il gruppo delle piattaforme di riferimento. Queste piattaforme vengono testate approfonditamente per assicurarne la qualità. Ma attenzione: non esiste codice completamente privo di errori.




Il Qt Project
=============

Dalla `wiki del qt-project <http://wiki.qt-project.org>`_:

"Il Qt Project è una community meritocratica e basata sul consenso interessata a Qt. Chiunque sia interessato può unirsi alla community, partecipare ai processi decisionali, e contribuire allo sviluppo di Qt."

Il Qt-Project è un'organizzazione che porta avanti lo sviluppo della parte open-source di Qt. Costituisce la base a cui altri utenti possono contribuire. Il contributore maggiore è DIGIA, che detiene anche i diritti commerciali di Qt.

Qt ha un lato open-source e un lato commerciale. Il lato commerciale è riservato a quelle aziende che non soddisfano le licenze di tipo open-source. Senza l'aspetto commerciale, queste aziende non sarebbero in grado di usare Qt, e DIGIA non sarebbe in grado di contribuire con così tanto codice al Qt-Project.

Ci sono molte aziende in tutto il modo che sussistono grazie alle consulenze e allo sviluppo di prodotti con Qt sule varie piattaforme. Ci sono molti progetti e sviluppatori open-source che si affidano a Qt come libreria principale per lo sviluppo. E' bello far parte di questa comunità molto attiva e lavorare con tool e librerie eccezionali. Questo ti rende una persona migliore? Forse :-)

**Contribuisci qui: http://wiki.qt-project.org**
