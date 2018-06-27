# Translation

Book translation is done using the Transifex service. The project is located at https://www.transifex.com/qmlbookorg/qmlbookorg/dashboard/.

Please request for contribution and which language you would like to contribute. Translation is done by a community of people, so everyone can start translation a language. Only when the language is at least 80% translated it will be published.

Discussion is onging on the gitter account: http://gitter.im/qmlbook/qmlbook.

Please read https://docs.transifex.com/integrations/sphinx-doc and http://www.sphinx-doc.org/en/master/intl.html before contributing for translation.

## Build

To build your own translated version you need to pull your language and build the documentation with the correct language settings for German (de) this process would be:

    tx pull -l de
    make -e SPHINXOPTS="-D language='de'" html

And then you can load the HTML pages from `_buld/html`.

Note: This feature is rather new with the qmlbook so there will be questions :-)

/ jryannel


