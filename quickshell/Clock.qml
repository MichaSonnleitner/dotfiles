import Quickshell
import QtQuick


Text{
    text: Qt.formatDateTime(clock.date, "hh:mm")
    font{
        family: "JetBrains Mono Nerd Propo"
        pixelSize: 18
        weight: 600
    }
    color: Theme.text


    SystemClock{
        id: clock
        precision: SystemClock.Minute
    }



}