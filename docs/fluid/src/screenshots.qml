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

Item {
    id: root

    ListModel {
        id: sourcesModel
        ListElement { source: "EasingCurves/EasingCurves.qml"; name: "easingcurves.png"; margin: 0; }
   }

    property int p: 0
    property string assetsource: ""
    property string assetname: ""
    property int shootmargin: 0

    Rectangle {
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.bottomMargin: 1

        border.color: "lightGray"
        border.width: 1

        Loader {
            id: loader

            x: 1; y: 1

            focus: true

            onLoaded: {
                if (loader.source != "") {
                    if (assetsource.indexOf("ss-") == -1) {
                        setSize(loader.item.width, loader.item.height);
                        shoot();
                    }
                }
            }
        }
    }

    function setSize(w,h)
    {
        loader.x = shootmargin;
        loader.y = shootmargin;
        root.width = w+2+shootmargin*2;
        root.height = h+2+shootmargin*2;
    }

    function shoot()
    {
        shootDelay.start();
    }

    function shootWithDelay(d)
    {
        shootDelay.interval = d;
        shoot();
    }

    Timer {
        id: shootDelay
        interval: 100
        repeat: false;
        onTriggered: takeScreenshot();
    }

    Component.onCompleted: {
        prepareScreenshot();
    }

    function prepareScreenshot()
    {
        shootDelay.interval = 100;
        console.log("SS: " + p);
        assetsource = sourcesModel.get(p).source;
        assetname = "../assets/automatic/" + sourcesModel.get(p).name;
        shootmargin = sourcesModel.get(p).margin;
        p += 1;
        loader.source = assetsource;
        console.log("    " + assetname);
        console.log("    " + loader.source);
    }

    function takeScreenshot()
    {
        console.log("TS: " + assetname);

        shorty.shootFull(assetname);
        if (p < sourcesModel.count)
        {
            loader.source = "";
            prepareScreenshot();
        }
        else
            Qt.quit();
    }
}
