import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 6

    Repeater {
        model: SystemTray.items

        Rectangle {
            id: trayItem
            required property SystemTrayItem modelData

            implicitWidth: 24
            implicitHeight: 24
            radius: 6
            color: trayHover.containsMouse ? Theme.surface : "transparent"

            Image {
                anchors.centerIn: parent
                source: trayItem.modelData.icon
                implicitSize: 16
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
