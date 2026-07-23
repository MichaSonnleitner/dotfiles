import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Scope {
    id: root

    property bool showOsd: false
    property bool dndState: NotificationService.doNotDisturb

    Connections {
        target: NotificationService

        function onDoNotDisturbChanged() {
            root.dndState = NotificationService.doNotDisturb
            root.showOsd = true
            hideTimer.restart()
        }
    }

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.showOsd = false
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: osdWindow
            required property var modelData
            screen: modelData

            visible: root.showOsd
            focusable: false
            color: "transparent"

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            WlrLayershell.namespace: "quickshell-dnd-osd"

            exclusionMode: ExclusionMode.Ignore

            anchors {
                top: true
                right: true
            }

            implicitWidth: osdContent.implicitWidth + 40
            implicitHeight: 50

            Rectangle {
                anchors.fill: parent
                radius: 16
                color: Theme.surface
                border.color: Theme.border
                border.width: 1

                RowLayout {
                    id: osdContent
                    anchors.centerIn: parent
                    spacing: 10

                    Text {
                        text: root.dndState ? "󰂛" : "󰂜"
                        color: root.dndState ? Theme.accent : Theme.textMuted
                        font.family: "JetBrains Mono Nerd Propo"
                        font.pixelSize: 16
                    }

                    Text {
                        text: root.dndState ? "DnD Aktiviert" : "DnD Deaktiviert"
                        color: Theme.text
                        font.family: "JetBrains Mono Nerd Propo"
                        font.pixelSize: 14
                        font.weight: 600
                    }
                }
            }
        }
    }
}
