import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 6

    property var sink: Pipewire.defaultAudioSink

    readonly property bool ready: sink !== null && sink.audio !== null
    readonly property bool isMuted: ready ? sink.audio.muted : false
    readonly property int volume: ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property string icon: {
        if (!ready) return String.fromCodePoint(0xF0581)
        if (isMuted) return "󰸈"
        if (volume === 0) return String.fromCodePoint(0xF0581)
        if (volume < 34) return String.fromCodePoint(0xF057F)
        if (volume < 67) return String.fromCodePoint(0xF0580)
        return String.fromCodePoint(0xF057E)
    }

    PwObjectTracker {
        objects: [root.sink]
    }

    Text {
        text: root.icon
        color: root.isMuted ? Theme.textMuted : Theme.text
        font {
            family: "JetBrains Mono Nerd Propo"
            pixelSize: 13
        }
    }

    Text {
        text: root.volume + "%"
        color: root.isMuted ? Theme.textMuted : Theme.text
        font {
            family: "JetBrains Mono Nerd Propo"
            pixelSize: 16
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            if (!root.ready) return
            root.sink.audio.muted = !root.sink.audio.muted
        }
    }
}