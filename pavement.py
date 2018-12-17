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
    pass # needs to be fixed
#    sh('make latexpdf')
#    path('_build/latex/qt5_cadaques.pdf').copy('_build/html/assets')


@task
def build_epub():
    pass # needs to be fixed
#    sh('make epub')
#    path('_build/epub/qt5_cadaques.epub').copy('_build/html/assets')


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
    with pushd('docs'):
        path('assets').rmtree()


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
    server.watch('en', shell('paver build_html', cwd='.'))
    server.serve(root='_build/html', open_url_delay=True)


@task
def assets_init():
    # copy template index.rst into assets
    with pushd('docs'):
        path('assets').makedirs()
    path('assets/index.rst').copy('docs/assets')

    # create _build path assets for generated contents
    path('_build').makedirs()
    with pushd('_build'):
        path('html').makedirs()
        with pushd('html'):
            path('assets').makedirs()


@task
@needs('assets_init')
def build_assets():
    with pushd('docs'):
        examples = []
        for ch in path('.').dirs('ch??-*'):
            name = '%s-assets.tgz' % ch
            if ch.joinpath('src').isdir():
                examples.append((int(ch[4:6]), name))
                sh('tar czf ../_build/html/assets/{0} --exclude=".*" {1}/src/'.format(name, ch))
                
        # files to include from the indexes as all chapters does not have examples
        f = open('examples-list.txt', 'w')
        g = open('assets/examples-list.txt', 'w')
        examples.sort(key=lambda e: e[0])
        for c, n in examples:
            f.write("* `Chapter %s examples (%s) <%s>`_\n" % (c, n, "assets/" + n))
            g.write("* `Chapter %s examples (%s) <%s>`_\n" % (c, n, n))
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
