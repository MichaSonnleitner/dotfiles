import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Scope {
    id: root

    property bool isOpen: false
    property string prompt: "Sudo Passwort:"
    property string pwText: ""

    IpcHandler {
        target: "password-input"

        function open(): void {
            root.prompt = "Sudo Passwort:"
            root.pwText = ""
            root.isOpen = true
        }

        function cancel(): void {
            root.isOpen = false
            root.pwText = ""
        }
    }

    function submit() {
        if (root.pwText === "") return
        var encoded = Qt.btoa(root.pwText)
        Quickshell.execDetached(["bash", "-c", "echo '" + encoded + "' | base64 -d > /tmp/qs-sudo-response"])
        root.pwText = ""
        root.isOpen = false
    }

    function cancelAction() {
        root.pwText = ""
        root.isOpen = false
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: pwWindow
            required property var modelData
            screen: modelData

            visible: root.isOpen
            focusable: false
            color: "#88000000"

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            WlrLayershell.namespace: "quickshell-password-input"

            exclusionMode: ExclusionMode.Ignore

            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.cancelAction()
            }

            Keys.onPressed: function(event) {
                if (event.key === Qt.Key_Escape) {
                    root.cancelAction()
                }
            }

            Rectangle {
                anchors.centerIn: parent
                width: 340
                height: col.implicitHeight + 40
                radius: 20
                color: Theme.surface
                border.color: Theme.border
                border.width: 1

                ColumnLayout {
                    id: col
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    RowLayout {
                        spacing: 10
                        Layout.alignment: Qt.AlignHCenter

                        Text {
                            text: "󰌾"
                            color: Theme.accent
                            font.family: "JetBrains Mono Nerd Propo"
                            font.pixelSize: 22
                        }

                        Text {
                            text: root.prompt
                            color: Theme.text
                            font.family: "JetBrains Mono Nerd Propo"
                            font.pixelSize: 16
                            font.weight: 700
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 44
                        radius: 10
                        color: Theme.background
                        border.color: pwInput.activeFocus ? Theme.accent : Theme.border
                        border.width: pwInput.activeFocus ? 2 : 1

                        TextInput {
                            id: pwInput
                            anchors.fill: parent
                            anchors.margins: 12
                            color: Theme.text
                            font.family: "JetBrains Mono Nerd Propo"
                            font.pixelSize: 14
                            echoMode: TextInput.Password
                            clip: true
                            focus: root.isOpen
                            verticalAlignment: TextInput.AlignVCenter

                            text: root.pwText
                            onTextChanged: root.pwText = text

                            onAccepted: root.submit()

                            Keys.onPressed: function(event) {
                                if (event.key === Qt.Key_Escape) {
                                    root.cancelAction()
                                    event.accepted = true
                                }
                            }

                            Text {
                                visible: !pwInput.text && !pwInput.activeFocus
                                text: "Passwort eingeben..."
                                color: Theme.textMuted
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Rectangle {
                            Layout.fillWidth: true
                            height: 40
                            radius: 10
                            color: cancelHover.containsMouse ? "#FF5555" : Theme.background
                            border.color: Theme.border
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: "Abbrechen"
                                color: cancelHover.containsMouse ? Theme.text : Theme.textMuted
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 13
                                font.weight: 600
                            }

                            MouseArea {
                                id: cancelHover
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.cancelAction()
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 40
                            radius: 10
                            color: confirmHover.containsMouse ? Theme.accent : Theme.background
                            border.color: Theme.border
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: "Bestätigen"
                                color: confirmHover.containsMouse ? Theme.text : Theme.textMuted
                                font.family: "JetBrains Mono Nerd Propo"
                                font.pixelSize: 13
                                font.weight: 600
                            }

                            MouseArea {
                                id: confirmHover
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.submit()
                            }
                        }
                    }

                    Text {
                        text: "Enter = Bestätigen | ESC = Abbrechen"
                        color: Theme.textMuted
                        font.family: "JetBrains Mono Nerd Propo"
                        font.pixelSize: 10
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }
    }
}
