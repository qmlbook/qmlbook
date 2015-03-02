from paver.easy import *

@task
@needs('assets_init', 'build_html', 'build_pdf', 'build_epub', 'build_assets')
def build_all():
    pass

@task
def build_html():
    sh('make html')

@task
def build_pdf():
    sh('make latexpdf')
    path('_build/latex/qt5_cadaques.pdf').copy('assets')

@task
def build_epub():
    sh('make epub')
    path('_build/epub/qt5_cadaques.epub').copy('assets')

@task
def build_qt():
    sh('export QTHELP=True; make qthelp')
    sh('qcollectiongenerator _build/qthelp/Qt5CadaquesBook.qhcp')
    path('_build/qthelp/Qt5CadaquesBook.qhc').copy('assets')

@task
def show_qt():
    sh('assistant -collectionFile _build/qthelp/Qt5CadaquesBook.qhc')

@task
def clean():
    sh('make clean')
    path('assets').rmtree()

@task
def serve():
    with pushd('_build/html'):
        sh('python -m SimpleHTTPServer')


ROOT = path('.').abspath()
ASSETS = path('assets').abspath()


@task
def assets_init():
    path('assets').makedirs()


@task
def build_assets():
    for ch in path('.').dirs('ch??'):
        name = '%s-assets.tgz'%ch
        if ch.joinpath('src').isdir():
            sh('tar czvf assets/{0} --exclude=".*" {1}/src/'.format(name, ch))

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
