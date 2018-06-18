from invoke import task
from path import Path


@task
def build(c):
    c.run('make html')


@task
def serve(c):
    c.run('sphinx-autobuild --port 8080 --open-browser . _build/html')


@task
def clean(c):
    c.run('make clean')


@task
def shoot(c):
    for path in Path('.').walkfiles('screenshots.qml'):
        with c.cd(path.dirname()):
            c.run('shorty screenshots.qml')
