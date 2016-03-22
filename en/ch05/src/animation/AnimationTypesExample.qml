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

// animationtypes.qml

import QtQuick 2.5

Item {
    id: root
    width: background.width; height: background.height

    Image {
        id: background
        source: "assets/background_medium.png"
    }


    //M4>>
    MouseArea {
        anchors.fill: parent
        onClicked: {
            greenBox.y = blueBox.y = redBox.y = 205
        }
    }
    //<<M4

    //M1>>
    ClickableImageV2 {
        id: greenBox
        x: 40; y: root.height-height
        source: "assets/box_green.png"
        text: "animation on property"
        NumberAnimation on y {
            to: 40; duration: 4000
        }
    }
    //<<M1

    //M2>>
    ClickableImageV2 {
        id: blueBox
        x: (root.width-width)/2; y: root.height-height
        source: "assets/box_blue.png"
        text: "behavior on property"
        Behavior on y {
            NumberAnimation { duration: 4000 }
        }

        onClicked: y = 40
        // random y on each click
//        onClicked: y = 40+Math.random()*(205-40)
    }
    //<<M2

    //M3>>
    ClickableImageV2 {
        id: redBox
        x: root.width-width-40; y: root.height-height
        source: "assets/box_red.png"
        onClicked: anim.start()
//        onClicked: anim.restart()

        text: "standalone animation"

        NumberAnimation {
            id: anim
            target: redBox
            properties: "y"
            to: 40
            duration: 4000
        }
    }
    //<<M3

}
