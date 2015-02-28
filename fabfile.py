from fabric.api import *
import os
import sys
import time
import logging
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# run shorty on all screenshot files
# call it with fab shoot


def shoot():
    for root, dirs, names in os.walk('.'):
        for name in names:
            if name == 'screenshots.qml':
                with lcd(root):
                    local('shorty screenshots.qml')

def build():
    local('make html')

def clean():
    local('make clean')

def serve():
    with lcd('_build/html'):
        local('python -m SimpleHTTPServer')
