/* GCompris - Babymatch.qml
 *
 * Copyright (C) 2015 Ayush Agrawal <ayushagrawal288@gmail.com>
 *
 * Authors:
 *   Ayush Agrawal <ayushagrawal288@gmail.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.1
import GCompris 1.0

import "../../core"
import "../babymatch"
import "../babymatch/babymatch.js" as Activity

ActivityBase {
    id: activity

    // In most cases, these 3 are the same.
    // But for imageName for example, we reuse the images of babymatch, so we need to differentiate them
    property string imagesUrl: boardsUrl
    property string soundsUrl: boardsUrl
    property string boardsUrl: "qrc:/gcompris/src/activities/object_classification/resource/"
    property string bgImage: "qrc:/gcompris/src/activities/menu/resource/background.svg"
    property int levelCount: 5
    property bool answerGlow: true	//For highlighting the answers
    property bool displayDropCircle: true	//For displaying drop circles

    onStart: focus = true
    onStop: {}

    pageComponent: Image {
        id: background
        anchors.fill: parent
        source: bgImage

        signal start
        signal stop

        property bool vert: background.width > background.height ? false : true

        Component.onCompleted: {
            activity.start.connect(start)
            activity.stop.connect(stop)
        }

        // Add here the QML items you need to access in javascript
        QtObject {
            id: items
            property alias background: background
            property alias bar: bar
            property alias bonus: bonus
            property alias availablePieces: availablePieces
            property alias backgroundPiecesModel: backgroundPiecesModel
            property alias file: file
            property alias grid: grid
            property alias backgroundImage: backgroundImage
            property alias leftWidget: leftWidget
            property alias instruction: instruction
            property alias toolTip: toolTip
            property alias score: score
            property alias dataset: dataset
        }

        Loader {
            id: dataset
            asynchronous: false
        }

        onStart: { Activity.start(items, imagesUrl, soundsUrl, boardsUrl, levelCount, answerGlow, displayDropCircle) }
        onStop: { Activity.stop() }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level }
            onHelpClicked: {displayDialog(dialogHelp)}
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
        }

        Score {
            id: score
            visible: numberOfSubLevels > 1
        }

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextSubLevel)
        }

        File {
            id: file
            name: ""
        }

        Rectangle {
            id: leftWidget
            width: background.vert ?
                       90 * ApplicationInfo.ratio :
                       background.width
            height: background.vert ?
                        background.height :
                        90 * ApplicationInfo.ratio
            color: "transparent"
            border.color: "#FFD85F"
            border.width: 4
            anchors.top: instruction.bottom
            anchors.left: parent.left
            anchors.topMargin: 30 * ApplicationInfo.ratio
            ListWidget {
                id: availablePieces
                vert: background.vert
            }
        }

        Rectangle {
            id: toolTip
            anchors {
                bottom: bar.top
                bottomMargin: 10
                left: leftWidget.left
                leftMargin: 5
            }
            width: toolTipTxt.width + 10
            height: toolTipTxt.height + 5
            opacity: 1
            radius: 10
            z: 100
            border.width: 2
            border.color: "black"
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#000" }
                GradientStop { position: 0.9; color: "#666" }
                GradientStop { position: 1.0; color: "#AAA" }
            }
            property alias text: toolTipTxt.text
            Behavior on opacity { NumberAnimation { duration: 120 } }

            function show(newText) {
                if(newText) {
                    text = newText
                    opacity = 0.8
                } else {
                    opacity = 0
                }
            }

            GCText {
                id: toolTipTxt
                anchors.centerIn: parent
                fontSize: regularSize
                color: "white"
                style: Text.Outline
                styleColor: "black"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: TextEdit.WordWrap
                text: "coucou"
            }
        }


        Rectangle {
            id: grid

            color: "transparent"
            z: 2
            x: background.vert ? 90 * ApplicationInfo.ratio : 0
            y: background.vert ? 0 : 90 * ApplicationInfo.ratio
            width: background.width - 20 * ApplicationInfo.ratio
//            height: background.height - (bar.height * 1.1) - 150 * ApplicationInfo.ratio
            height: background.height / 2
            anchors.top: leftWidget.bottom
            anchors.horizontalCenter: instruction.horizontalCenter
            anchors.margins: 10 * ApplicationInfo.ratio


            Image {
                id: backgroundImage
                fillMode: Image.PreserveAspectFit
                property double ratio: sourceSize.width / sourceSize.height
                property double gridRatio: grid.width / grid.height
                property alias instruction: instruction
                source: ""
                z: 2
                width: source == "" ? grid.width : (ratio > gridRatio ? grid.width : grid.height * ratio)
                height: source == "" ? grid.height : (ratio < gridRatio ? grid.height : grid.width / ratio)
//                anchors.topMargin: 10
                anchors.centerIn: parent

                //Inserting static background images
                Repeater {
                    id: backgroundPieces
                    model: backgroundPiecesModel
                    delegate: piecesDelegate
                    z: 2

                    Component {
                        id: piecesDelegate
                        Image {
                            id: shapeBackground
                            source: Activity.imagesUrl + imgName
                            x: posX * backgroundImage.width - width / 2
                            y: posY * backgroundImage.height - height / 2

                            height:
                                imgHeight ?
                                    imgHeight * backgroundImage.height :
                                    (backgroundImage.source == "" ?
                                         backgroundImage.height * shapeBackground.sourceSize.height / backgroundImage.height :
                                         backgroundImage.height * shapeBackground.sourceSize.height /
                                         backgroundImage.sourceSize.height)

                            width:
                                imgWidth ?
                                    imgWidth * backgroundImage.width :
                                    (backgroundImage.source == "" ?
                                         backgroundImage.width * shapeBackground.sourceSize.width / backgroundImage.width :
                                         backgroundImage.width * shapeBackground.sourceSize.width /
                                         backgroundImage.sourceSize.width)

                            fillMode: Image.PreserveAspectFit
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: (instruction.opacity === 0 ?
                                    instruction.show() : instruction.hide())
                }
            }
        }

        Rectangle {
            id: instruction
            anchors.fill: instructionTxt
            opacity: 0.8
            radius: 10
            z: 3
            border.width: 2
            border.color: "black"
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#000" }
                GradientStop { position: 0.9; color: "#666" }
                GradientStop { position: 1.0; color: "#AAA" }
            }
            property alias text: instructionTxt.text

            Behavior on opacity { PropertyAnimation { duration: 200 } }

            function show() {
                if(text)
                    opacity = 1
            }
            function hide() {
                opacity = 0
            }
        }

        GCText {
            id: instructionTxt
            anchors {
                top: background.top
                margins: 10 * ApplicationInfo.ratio
                horizontalCenter: background.horizontalCenter
            }
            opacity: instruction.opacity
            z: instruction.z
            fontSize: regularSize
            color: "white"
            style: Text.Outline
            styleColor: "black"
            horizontalAlignment: Text.AlignHCenter
//            width: Math.max(Math.min(parent.width * 0.9, text.length * 11), parent.width * 0.3)
            width: background.width - 20 * ApplicationInfo.ratio
            wrapMode: TextEdit.WordWrap
        }


        ListModel {
            id: backgroundPiecesModel
        }
    }
}
