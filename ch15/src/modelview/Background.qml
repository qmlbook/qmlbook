import QtQuick 2.2
import QtQuick.Window 2.0

import org.example 1.0

Rectangle {
    id: root
    anchors.fill: parent
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#4a4a4a" }
        GradientStop { position: 1.0; color: "#2b2b2b" }
    }
}
