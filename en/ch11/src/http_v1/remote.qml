// M1>>
// remote.qml
import QtQuick 2.5

Loader {
    id: root
    source: 'http://localhost:8080/main2.qml'
    onLoaded: {
        root.width = item.width
        root.height = item.height
    }
}
// <<M1
