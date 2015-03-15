import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

RowLayout {
    id: root
    signal append(string text)
    signal edit(int index, string text)

    signal up()
    signal down()

    function setEditValue(index, text) {
        internal.index = index
        textField.text = text
    }

    function setAppendValue(text) {
        textField.text = text
    }

    QtObject {
        id: internal
        property int index
    }

    TextField {
        id: textField
        Layout.fillWidth: true
        text: 'orange'
        focus: true
        onAccepted: {
            root.clicked(textField.text)
            selectAll()
        }
        Keys.onUpPressed: root.up()
        Keys.onDownPressed: root.down()
    }
    Button {
        id: button
        text: 'Edit'
        onClicked: {
            root.edit(internal.index, textField.text)
        }
    }
    Button {
        text: 'Append'
        onClicked: {
            root.append(textField.text)
        }
    }
}
