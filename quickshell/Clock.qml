import Quickshell
import QtQuick


Text{
    text: Qt.formatDateTime(clock.date, "hh:mm")
    font{
        family: "JetBrains Mono"
        pixelSize: 18
        weight: 600
    }
    color: Theme.text


    SystemClock{
        id: clock
        precision: SystemClock.Minute
    }


    MouseArea {
        anchors.fill: parent
    
        onClicked: {
            PopupState.menuOpen = !PopupState.menuOpen
        }

    }
}