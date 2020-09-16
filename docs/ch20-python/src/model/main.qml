import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

import PsUtils 1.0

Window {
    id: root
    
    width: 640
    height: 480
    visible: true
    title: "CPU Load"
    
    ListView {
        anchors.fill: parent
        model: CpuLoadModel { }
        delegate: Rectangle { 
            width: parent.width; 
            height: 30;
            color: "white"
            
            Rectangle {
                id: bar
                
                width: parent.width * display / 100.0
                height: 30
                color: "green"
            }
            
            Text {
                anchors.verticalCenter: parent.verticalCenter
                x: Math.min(bar.x + bar.width + 5, parent.width-width)
                
                text: display + "%"
            }   
        }
    }
}
