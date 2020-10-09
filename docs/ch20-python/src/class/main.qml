import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

import Generators 1.0

Window {
    id: root
    
    width: 640
    height: 480
    visible: true
    title: "Hello Python World!"
    
    Flow {
        Button {
            text: "Give me a number!"
            onClicked: numberGenerator.giveNumber();
        }
        Label {
            id: numberLabel
            text: "no number"
        }
    }
    
    NumberGenerator {
        id: numberGenerator
    }
    
    Connections {
        target: numberGenerator
        function onNextNumber(number) {
            numberLabel.text = number
        }
    }
}
