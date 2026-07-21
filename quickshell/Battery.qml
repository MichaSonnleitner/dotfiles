import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout{
    id: root
    spacing: 6

    property var battery: UPower.displayDevice

    property bool isCharging: battery ? battery.state === 1 : false
    readonly property int level: battery ? Math.round(battery.percentage * 100) : 0
    readonly property string icon: {
        if (isCharging) return String.fromCodePoint(0xF0084)
        if (level >= 100) return String.fromCodePoint(0xF0079)
        if (level < 10) return String.fromCodePoint(0xF0083)
        return String.fromCodePoint(0xF007A + Math.floor(level / 10) - 1)

    }

    Text{
        text: root.icon
        color: root.isCharging ? Theme.accent : root.level < 15 ? "#FF5555" : Theme.text
        font{
            family: "JetBrains Mono Nerd Propo"
            pixelSize: 13
        }
    }

    Text{
        text: root.level + "%"
        color: root.isCharging ? Theme.accent : root.level < 15 ? "#FF5555" : Theme.text
        font{
            family: "JetBrains Mono Nerd Propo"
            pixelSize: 16
        }
    }
}