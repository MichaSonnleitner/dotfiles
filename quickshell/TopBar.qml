import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


Rectangle {
    id: root

    property var audioSink: Pipewire.defaultAudioSink
    property string mode: "clock"
    property int rad: 48
    property bool audioReady: false


    color: Theme.background
    radius: rad


    implicitWidth: row.implicitWidth + 48
    implicitHeight: row.implicitHeight + 24



    Timer {
        interval: 2000
        running: true
        repeat: false

        onTriggered: {
            audioReady = true
        }
    }



    Connections {
        target: Pipewire

        function onDefaultAudioSinkChanged() {
            audioSink = Pipewire.defaultAudioSink
        }
    }



    Connections {
        target: audioSink?.audio

        function onVolumesChanged() {
            if (!audioReady)
                return

            mode = "volume"
            volumeTimer.restart()
        }


        function onMutedChanged() {
            if (!audioReady)
                return

            mode = "volume"
            volumeTimer.restart()
        }
    }



    Behavior on implicitWidth {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }


    Behavior on implicitHeight {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }


    MouseArea {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: content.width + 48


        onClicked: {

            if (mode === "clock")
                mode = "battery"

            else if (mode === "battery")
                mode = "network"

            else
                mode = "clock"


            if (mode !== "clock")
                clockReturnTimer.restart()
        }
    }


    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 8

        Loader {
            id: content

            opacity: 1
            scale: 1



            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }


            Behavior on scale {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutBack
                }
            }



            onSourceComponentChanged: {
                opacity = 0
                scale = 0.8
                restartAnimation.start()
            }



            Timer {
                id: restartAnimation

                interval: 50

                onTriggered: {
                    content.opacity = 1
                    content.scale = 1
                }
            }



            sourceComponent:

                mode === "clock" ? clockComponent :

                mode === "battery" ? batteryComponent :

                mode === "network" ? networkComponent :

                mode === "workspace" ? workspaceComponent :

                mode === "volume" ? volumeComponent :

                null
        }

        Rectangle {
            visible: media.hasPlayer
            width: 1
            height: 20
            radius: 1
            color: Theme.border
        }

        MediaPlayer {
            id: media
        }

        Rectangle {
            visible: trayRepeater.count > 0
            width: 1
            height: 20
            radius: 1
            color: Theme.border
        }

        Repeater {
            id: trayRepeater
            model: SystemTray.items

            Rectangle {
                id: trayItem
                required property SystemTrayItem modelData

                implicitWidth: 20
                implicitHeight: 20
                radius: 6
                color: trayHover.containsMouse ? Theme.surface : "transparent"

                Image {
                    anchors.centerIn: parent
                    source: trayItem.modelData.icon
                    sourceSize.width: 14
                    sourceSize.height: 14
                }

                MouseArea {
                    id: trayHover
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked: function(mouse) {
                        if (mouse.button === Qt.RightButton) {
                            trayItem.modelData.activate()
                        } else {
                            trayItem.modelData.secondaryActivate()
                        }
                    }
                }

                ToolTip {
                    visible: trayHover.containsMouse
                    text: trayItem.modelData.title
                }
            }
        }
    }




    Component {
        id: clockComponent
        Clock {}
    }


    Component {
        id: batteryComponent
        Battery {}
    }


    Component {
        id: networkComponent
        Network {}
    }


    Component {
        id: workspaceComponent
        Workspace {}
    }


    Component {
        id: volumeComponent
        Volume {}
    }




    Timer {
        id: workspaceTimer

        interval: 1500
        repeat: false

        onTriggered: {
            mode = "clock"
        }
    }



    Timer {
        id: clockReturnTimer

        interval: 5000
        repeat: false

        onTriggered: {
            mode = "clock"
        }
    }



    Timer {
        id: volumeTimer

        interval: 5000
        repeat: false

        onTriggered: {
            mode = "clock"
        }
    }



    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }



    Connections {
        target: Hyprland


        function onRawEvent(event) {

            if (event.name === "workspace") {

                mode = "workspace"

                workspaceTimer.restart()
            }
        }
    }
}
