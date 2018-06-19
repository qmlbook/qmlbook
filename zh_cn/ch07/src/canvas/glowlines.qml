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

Canvas {
    id: canvas
    width: 800; height: 450

    property real hue: 0
    property real lastX: width * Math.random()
    property real lastY: height * Math.random()

    // M1>>
    property bool requestLine: false
    property bool requestBlank: false
    // <<M1

    // M2>>
    Timer {
        id: lineTimer
        interval: 40
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            canvas.requestLine = true
            canvas.requestPaint()
        }
    }

    Timer {
        id: blankTimer
        interval: 50
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            canvas.requestBlank = true
            canvas.requestPaint()
        }
    }
    // <<M2

    onPaint: {
        var context = getContext('2d')
        if(requestLine) {
            line(context)
            requestLine = false
        }
        if(requestBlank) {
            blank(context)
            requestBlank = false
        }
    }

    function line(context) {
        context.save()
        context.translate(canvas.width/2, canvas.height/2)
        context.scale(0.9, 0.9)
        context.translate(-canvas.width/2, -canvas.height/2)
        context.beginPath()
        context.lineWidth = 5 + Math.random() * 10
        context.moveTo(lastX, lastY)
        lastX = canvas.width * Math.random()
        lastY = canvas.height * Math.random()
        context.bezierCurveTo(canvas.width * Math.random(),
                              canvas.height * Math.random(),
                              canvas.width * Math.random(),
                              canvas.height * Math.random(),
                              lastX, lastY);

        hue += Math.random()*0.1
        if(hue > 1.0) {
            hue -= 1
        }
        context.strokeStyle = Qt.hsla(hue, 0.5, 0.5, 1.0)
        context.shadowColor = 'white';
        context.shadowBlur = 10;
        context.stroke()
        context.restore()
    }

    function blank(context) {
        context.fillStyle = Qt.rgba(0,0,0,0.1)
        context.fillRect(0, 0, canvas.width, canvas.height)
    }

    Component.onCompleted: {
        lineTimer.start()
        blankTimer.start()
    }

}
