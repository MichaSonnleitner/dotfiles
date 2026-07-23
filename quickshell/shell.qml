import Quickshell
import QtQuick
import "notifications"

ShellRoot {
    NotificationPopup {}
    PowerMenu {}

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData

            color: Theme.transparent

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 56

            

            TopBar {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 8
            }           
        }
    }
}
