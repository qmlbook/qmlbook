import QtQuick 2.2
import QtQuick.Window 2.0

import org.example 1.0

Rectangle {
    id: root
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#fed958" }
        GradientStop { position: 1.0; color: "#fecc2f" }
    }
}
