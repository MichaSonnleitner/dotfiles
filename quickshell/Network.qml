import Quickshell 
import Quickshell.Networking
import Quickshell.Io
import QtQuick
import QtQuick.Layouts


RowLayout{
    id: root
    spacing: 6

    property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    property var activeWifi: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) : null
    readonly property real signal: activeWifi ? activeWifi.signalStrength : 0
    readonly property string icon: {
        if (!Networking.wifiEnabled) return String.fromCodePoint(0xF05AA)
        if (!activeWifi) return String.fromCodePoint(0xF092D)
        let tier = signal >= 0.75 ? 4
                 : signal >= 0.50 ? 3
                 : signal >= 0.25 ? 2
                 : 1
        return String.fromCodePoint(0xF091F + (tier - 1 ) * 3)
    } 
    Text {
        text: root.icon
        color: Networking.wifiEnabled ? Theme.text : Theme.textMuted
        font {
            family: "JetBrains Mono Nerd Propo"
            pixelSize: 13
        }
    }

    Text{
        text: { if (!Networking.wifiEnabled) return "Off"
                if (!root.activeWifi) return "Disconnected"
                return root.activeWifi.name
            }        

        color: Networking.wifiEnabled ? Theme.text : Theme.textMuted
        font {
            family: "JetBrains Mono Nerd Propo"
            pixelSize: 16
        }
    }
    MouseArea {
        anchors.fill: parent
    
        onClicked: {
            Quickshell.execDetached(["kitty", "-e", "nmtui"])
        }
    }
}