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
        
        // Signal argument names are not propagated from Python to QML, so we need to re-emit the signal
        signal reNextNumber(int number)
        Component.onCompleted: numberGenerator.nextNumber.connect(reNextNumber)
    }
    
    Connections {
        target: numberGenerator
        onReNextNumber: numberLabel.text = number
    }
}
