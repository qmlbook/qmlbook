import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

Window {
    id: root
    
    width: 640
    height: 480
    visible: true
    title: "Hello Python World!"
    
    Column {
        Flow {
            Button {
                text: "Give me a number!"
                onClicked: numberGenerator.updateNumber();
            }
            Label {
                id: numberLabel
                text: numberGenerator.number
            }
        }
        Flow {
            Slider {
                from: 0
                to: 99
                value: numberGenerator.maxNumber
                onValueChanged: numberGenerator.setMaxNumber(value)
            }
        }
    }
}
