import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    //visible: PopupState.menuOpen
    visible: false

    anchors {
        top: true
        right: true
    }

    margins {
        top: 10
        right: 10
    }

    


    color: "#00000000"

    implicitWidth: 350
    implicitHeight: 300

    Rectangle {
        anchors {
            top: parent.top
            right: parent.right
        }

        width: 300
        height: 200

        color: Theme.background
        radius: 24
        

        RowLayout{
            Rectangle{
                Layout.preferredWidth: network.implicitWidth + 10
                Layout.preferredHeight: network.implicitHeight + 10
                color: Theme.backgroundAlt
                radius: 6
                Network{
                    id: network
                    anchors.centerIn: parent
                }
            }
        }
    }
}