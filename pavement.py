from paver.easy import *
from livereload import Server, shell


@task
@needs('assets_init', 'build_html', 'build_pdf', 'build_epub', 'build_qt', 'build_assets')
def build_all():
    pass

@task
@needs('build_assets')
def build_html():
    sh('make html')


@task
def build_pdf():
    sh('make latexpdf')
    path('_build/latex/qt5_cadaques.pdf').copy('_build/html/assets')


@task
def build_epub():
    sh('make epub')
    path('_build/epub/qt5_cadaques.epub').copy('_build/html/assets')


@task
def build_qt():
    pass # needs to be fixed
#    sh('export QTHELP=True; make qthelp')
#    sh('qcollectiongenerator _build/qthelp/Qt5CadaquesBook.qhcp')
#    path('_build/qthelp/Qt5CadaquesBook.qch').copy('_build/html/assets')


@task
@needs('build_qt')
def show_qt():
    sh('assistant -collectionFile _build/qthelp/Qt5CadaquesBook.qch')


@task
def clean():
    sh('make clean')


@task
def shoot():
    for doc in path('.').walkfiles('screenshots.qml'):
        with pushd(doc.dirname()):
            sh('shorty screenshots.qml')


@task
def serve():
    with pushd('_build/html'):
        sh('python -m SimpleHTTPServer')


@task
@needs('build_html')
def live():
    server = Server()
    server.watch('docs', shell('paver build_html', cwd='.'))
    server.serve(root='_build/html', open_url_delay=True)


@task
def assets_init():
    # create _build path assets for generated contents
    path('_build/intermediate').makedirs_p()
    path('_build/html/assets').makedirs_p()


@task
@needs('assets_init')
def build_assets():
    with pushd('docs'):
        examples = []
        for ch in path('.').dirs('ch??-*'):
            name = '%s-assets.tgz' % ch
            if ch.joinpath('src').isdir():
                examples.append((int(ch[4:6]), name))
                sh('tar czf ../_build/html/assets/{0} {1}/src/'.format(name, ch))

    with pushd('_build'):
        with pushd('intermediate'):
            # files to include from the indexes as all chapters does not have examples
            f = open('assets-list.txt', 'w')
            g = open('assets-assets-list.txt', 'w')
            examples.sort(key=lambda e: e[0])
            for c, n in examples:
                f.write("* `Chapter %s examples (%s) <%s>`_\n" % (c, n[2:], "assets/" + n[2:]))
                g.write("* `Chapter %s examples (%s) <%s>`_\n" % (c, n[2:], n[2:]))
            f.close()
            g.close()

@task
@needs('build_all')
def publish():
    with pushd('../qmlbook.github.io'):
        sh('git pull')
        sh('git checkout master')
        sh('cp -rf ../qmlbook/_build/html/* .')
        sh('cp -rf ../qmlbook/assets .')
        sh('git add .')
        sh('git commit -m "update"')
        sh('git push')
