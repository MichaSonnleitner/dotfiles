import Quickshell
import QtQuick
import "notifications"

ShellRoot {
    NotificationPopup {}
    PowerMenu {}
    PasswordInput {}

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

            implicitHeight: 60

            

            TopBar {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 8
            }           
        }
    }
}
