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
import QtQuick.Particles 2.0

Rectangle {
    id: root
    width: 400; height: 400
    color: "#333333"

    property var images: [
        "box_blue.png",
        "box_red.png",
        "box_green.png",
        "circle_blue.png",
        "circle_red.png",
        "circle_green.png",
        "triangle_blue.png",
        "triangle_red.png",
        "triangle_green.png",

    ]

    // M1>>
    ParticleSystem {
        id: particleSystem
    }

    Emitter {
        id: emitter
        anchors.fill: root
        anchors.margins: 32
        system: particleSystem
        emitRate: 4
        lifeSpan: 2000
    }
    // <<M1


    // M2>>
    ItemParticle {
        id: particle
        system: particleSystem
        delegate: itemDelegate
    }
    // <<M2

    // M3>>
    Component {
        id: itemDelegate
        Item {
            id: container
            width: 32*Math.ceil(Math.random()*3); height: width
            Image {
                anchors.fill: parent
                anchors.margins: 4
                source: 'assets/'+images[Math.floor(Math.random()*9)]
            }
        }
    }
    // <<M3
}
