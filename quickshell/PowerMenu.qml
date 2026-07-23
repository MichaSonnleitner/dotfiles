import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Scope {
    id: root

    property bool isOpen: false

    IpcHandler {
        target: "power-menu"

        function toggle(): void {
            root.isOpen = !root.isOpen
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: powerWindow
            required property var modelData
            screen: modelData

            visible: root.isOpen
            focusable: true
            color: "#88000000"

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            WlrLayershell.namespace: "quickshell-power-menu"

            exclusionMode: ExclusionMode.Ignore

            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.isOpen = false
            }

            Rectangle {
                anchors.centerIn: parent
                width: 320
                height: col.implicitHeight + 40
                radius: 20
                color: Theme.surface
                border.color: Theme.border
                border.width: 1

                ColumnLayout {
                    id: col
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 12

                    Text {
                        text: "Ausschalten"
                        color: Theme.text
                        font.family: "JetBrains Mono Nerd Propo"
                        font.pixelSize: 18
                        font.weight: 700
                        Layout.alignment: Qt.AlignHCenter
                        Layout.bottomMargin: 8
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 50
                        radius: 12
                        color: shutdownHover.containsMouse ? "#FF5555" : Theme.background

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 10

                            Text {
                                text: "⏻"
                                color: shutdownHover.containsMouse ? Theme.text : "#FF5555"
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 18
                            }

                            Text {
                                text: "Herunterfahren"
                                color: shutdownHover.containsMouse ? Theme.text : Theme.textMuted
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 14
                                font.weight: 600
                            }
                        }

                        MouseArea {
                            id: shutdownHover
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 50
                        radius: 12
                        color: rebootHover.containsMouse ? Theme.accent : Theme.background

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 10

                            Text {
                                text: "󰜉"
                                color: rebootHover.containsMouse ? Theme.text : Theme.accent
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 18
                            }

                            Text {
                                text: "Neustarten"
                                color: rebootHover.containsMouse ? Theme.text : Theme.textMuted
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 14
                                font.weight: 600
                            }
                        }

                        MouseArea {
                            id: rebootHover
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Quickshell.execDetached(["systemctl", "reboot"])
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 50
                        radius: 12
                        color: logoutHover.containsMouse ? Theme.accent : Theme.background

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 10

                            Text {
                                text: "󰍃"
                                color: logoutHover.containsMouse ? Theme.text : Theme.accent
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 18
                            }

                            Text {
                                text: "Abmelden"
                                color: logoutHover.containsMouse ? Theme.text : Theme.textMuted
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 14
                                font.weight: 600
                            }
                        }

                        MouseArea {
                            id: logoutHover
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Quickshell.execDetached(["bash", "-c", "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"])
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 50
                        radius: 12
                        color: lockHover.containsMouse ? Theme.accent : Theme.background

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 10

                            Text {
                                text: "󰌾"
                                color: lockHover.containsMouse ? Theme.text : Theme.accent
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 18
                            }

                            Text {
                                text: "Sperren"
                                color: lockHover.containsMouse ? Theme.text : Theme.textMuted
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 14
                                font.weight: 600
                            }
                        }

                        MouseArea {
                            id: lockHover
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.isOpen = false
                                Quickshell.execDetached(["hyprlock"])
                            }
                        }
                    }
                }
            }
        }
    }
}
