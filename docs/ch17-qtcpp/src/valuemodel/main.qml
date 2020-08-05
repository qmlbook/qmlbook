import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.2

// our module
import org.example 1.0

Window {
    id: root
    visible: true
    width: 480
    height: 480

    property alias letter: letterFilter.text
    onLetterChanged: {
        print('filter letter: ' + letter)
    }


    Background { // a dark background
        id: background
    }

    // our dyanmic model
    ValueModel {
        id: valueModel
        QtObject {
            property string text: "One"
            property string group: 'A'
        }
        QtObject {
            property string text: "Two"
            property string group: 'A'
        }
    }

    property var filterCallback: function(v) {
        return v.group === root.letter
    }
    AdaptiveModel {
        id: adaptiveModel
        source: valueModel
        property var filter: function(v) { return v.group === root.letter }
        onFilterChanged: print('new filter' + filter)
        function filter(v) {
            console.log('called filter');
            return true;
        }

    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 8
        SplitView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollView {
                Layout.fillHeight: true
                Layout.fillWidth: true
                ListView {
                    id: view
                    // set our dynamic model to the views model property
                    model: valueModel
                    delegate: ListDelegate {
                        width: ListView.view.width
                        // construct a string based on the models proeprties
                        text: object.text + ' / ' + object.group

                        onClicked: {
                            // make this delegate the current item
                            ListView.view.currentIndex = index
                            ListView.view.focus = true
                            var text = JSON.stringify(valueModel.get(index))
                            textEntry.setEditValue(index, text)
                        }
                        onRemove: {
                            // remove the current entry from the model
                            valueModel.remove(index)
                        }
                    }
                    highlight: ListHighlight {
                    }
                }
            }
            ScrollView {
                Layout.fillHeight: true
                Layout.fillWidth: true
                ListView {
                    id: rightView
                    // set our dynamic model to the views model property
                    model: adaptiveModel
                    delegate: ListDelegate {
                        width: ListView.view.width
                        // construct a string based on the models proeprties
                        text: object.text + ' / ' + object.group

                        onClicked: {
                            // make this delegate the current item
                            ListView.view.currentIndex = index
                            ListView.view.focus = true
                            var text = JSON.stringify(valueModel.get(index))
                            textEntry.setEditValue(index, text)
                        }
                        onRemove: {
                            // remove the current entry from the model
                            var sourceRow = adaptiveModel.mapToSourceRow(index)
                            valueModel.remove(sourceRow)
                        }
                    }
                    highlight: ListHighlight {
                    }
                }
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Label {
                text: 'Filter:'
                color: '#ffffff'
            }
            TextField {
                id: letterFilter
                Layout.fillWidth: true
                text: 'A'
            }
        }
        TextEntry {
            id: textEntry
            onAppend: {
                var js = JSON.parse(text)
                valueModel.append(js)
            }
            onEdit: {
                var js = JSON.parse(text)
                valueModel.set(index,js)
            }

            onUp: {
                // called when the user presses up while the text field is focused
                view.decrementCurrentIndex()
            }
            onDown: {
                // same for down
                view.incrementCurrentIndex()
            }

            Component.onCompleted: {
                setAppendValue('{ "text": "Three", "group": "A" }')
            }
        }
    }
}
