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
    id: root
    width: 480; height: 240
    color: '#1e1e1e'
    property int step: 4

    Grid {
        anchors.centerIn: parent
        spacing: 20
        rows: 2; columns: 4
        Image {
            id: sourceImage
            width: 80; height: width
            source: 'assets/tulips.jpg'
        }
        ShaderEffect {
            id: effect1
            width: 80; height: width
            visible: root.step>0
            // M1>>
            fragmentShader: "
                uniform lowp float qt_Opacity;
                void main() {
                    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0) * qt_Opacity;
                }"
            // <<M1
        }
        // M2>>
        ShaderEffect {
            id: effect2
            width: 80; height: width
            property variant source: sourceImage
            visible: root.step>1
            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform sampler2D source;
                uniform lowp float qt_Opacity;
                void main() {
                    gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(1.0, 0.0, 0.0, 1.0) * qt_Opacity;
                }"
        }
        // <<M2
        // M3>>
        ShaderEffect {
            id: effect3
            width: 80; height: width
            property variant source: sourceImage
            property real redChannel: 0.3
            visible: root.step>2
            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform sampler2D source;
                uniform lowp float qt_Opacity;
                uniform lowp float redChannel;
                void main() {
                    gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(redChannel, 1.0, 1.0, 1.0) * qt_Opacity;
                }"
        }
        // <<M3
        // M4>>
        ShaderEffect {
            id: effect4
            width: 80; height: width
            property variant source: sourceImage
            property real redChannel: 0.3
            visible: root.step>3
            NumberAnimation on redChannel {
                from: 0.0; to: 1.0; loops: Animation.Infinite; duration: 4000
            }

            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform sampler2D source;
                uniform lowp float qt_Opacity;
                uniform lowp float redChannel;
                void main() {
                    gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(redChannel, 1.0, 1.0, 1.0) * qt_Opacity;
                }"
        }
        // <<M4
    }

}
