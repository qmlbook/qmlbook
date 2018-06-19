/*
 * Copyright (c) 2013, Juergen Bocklage-Ryannel, Johan Thelin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the editors nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick 2.5

Rectangle {
    id: container

    width: 600
    height: 400

    color: "white"

    Column {
        anchors.top: parent.top
        anchors.left: parent.left

        spacing: 20

        Rectangle {
            width: 290
            height: 50

            color: "lightGray"

            MouseArea {
                anchors.fill: parent
                onClicked: container.state = "left"
            }

            Text {
                anchors.centerIn: parent
                font.pixelSize: 30
                text: container.state==="left"?"Active":"inactive";
            }
        }

        // M1>>
        Rectangle {
            id: leftRectangle

            width: 290
            height: 200

            color: "green"

            MouseArea {
                id: leftMouseArea
                anchors.fill: parent
                onClicked: leftClickedAnimation.start();
            }

            Text {
                anchors.centerIn: parent
                font.pixelSize: 30
                color: "white"
                text: "Click me!"
            }
        }
        // <<M1
    }

    Column {
        anchors.top: parent.top
        anchors.right: parent.right

        spacing: 20

        Rectangle {
            width: 290
            height: 50

            color: "lightGray"

            MouseArea {
                anchors.fill: parent
                onClicked: container.state = "right"
            }

            Text {
                anchors.centerIn: parent
                font.pixelSize: 30
                text: container.state==="right"?"Active":"inactive";
            }
        }

        Rectangle {
            id: rightRectangle

            width: 290
            height: 200

            color: "blue"

            MouseArea {
                id: rightMouseArea
                anchors.fill: parent
                onClicked: rightClickedAnimation.start();
            }

            Text {
                anchors.centerIn: parent
                font.pixelSize: 30
                color: "white"
                text: "Click me!"
            }
        }
    }

    Text {
        id: activeText

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50

        font.pixelSize: 30
        color: "red"
        text: "Active area clicked!"

        opacity: 0
    }

    SequentialAnimation {
        id: leftClickedAnimation

        PropertyAction {
            target: leftRectangle
            property: "color"
            value: "white"
        }
        ColorAnimation {
            target: leftRectangle
            property: "color"
            to: "green"
            duration: 3000
        }
    }

    SequentialAnimation {
        id: rightClickedAnimation

        PropertyAction {
            target: rightRectangle
            property: "color"
            value: "white"
        }
        ColorAnimation {
            target: rightRectangle
            property: "color"
            to: "blue"
            duration: 3000
        }
    }

    SequentialAnimation {
        id: activeClickedAnimation

        PropertyAction {
            target: activeText
            property: "opacity"
            value: 1
        }
        PropertyAnimation {
            target: activeText
            property: "opacity"
            to: 0
            duration: 3000
        }
    }

    // M2>>
    Connections {
        id: connections
        onClicked: activeClickedAnimation.start();
    }
    // <<M2

    // M3>>
    states: [
        State {
            name: "left"
            StateChangeScript {
                script: connections.target = leftMouseArea
            }
        },
        State {
            name: "right"
            StateChangeScript {
                script: connections.target = rightMouseArea
            }
        }
    ]
    // <<M3

    Component.onCompleted: {
        state = "left";
    }
}
