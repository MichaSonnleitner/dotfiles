import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    implicitWidth: row.implicitWidth + 8
    implicitHeight: row.implicitHeight + 4
    radius: 6
    color: "transparent"

    property string title: ""
    property string artist: ""
    property string status: ""
    property bool hasPlayer: (status === "Playing" || status === "Paused") && title !== ""
    property bool restarting: false
    property bool lastPlayer: false
    property bool gotData: false

    visible: hasPlayer

    Process {
        id: playerctl
        command: ["playerctl", "metadata", "--format", "{{title}}|||{{artist}}"]
        running: true

        stdout: SplitParser {
            onRead: function(line) {
                root.gotData = true
                if (line === "") return
                const parts = line.split("|||")
                root.title = parts[0] || ""
                root.artist = parts[1] || ""
            }
        }
    }

    Process {
        id: statusProc
        command: ["playerctl", "status"]
        running: true

        stdout: SplitParser {
            onRead: function(line) {
                root.gotData = true
                root.status = line
            }
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            root.restarting = true
            root.gotData = false
            playerctl.running = false
            playerctl.running = true
            statusProc.running = false
            statusProc.running = true
            restartReset.start()
        }
    }

    Timer {
        id: hideTimer
        interval: 200
        repeat: false
        onTriggered: {
            root.status = ""
            root.title = ""
            root.artist = ""
        }
    }

    Timer {
        id: restartReset
        interval: 100
        repeat: false
        onTriggered: {
            root.restarting = false
            if (!root.gotData) {
                root.status = ""
                root.title = ""
                root.artist = ""
            }
        }
    }

    onHasPlayerChanged: {
        if (!hasPlayer && lastPlayer) {
            hideTimer.start()
        } else if (hasPlayer) {
            hideTimer.stop()
            lastPlayer = true
        } else {
            lastPlayer = false
        }
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: root.status === "Playing" ? "󰎆" : "󰏤"
            color: Theme.accent
            font.family: "JetBrains Mono Nerd Propo"
            font.pixelSize: 13
        }

        Text {
            text: root.title.length > 20 ? root.title.substring(0, 20) + "..." : root.title
            color: Theme.text
            font.family: "JetBrains Mono Nerd Propo"
            font.pixelSize: 14
            font.weight: 600
        }

        Text {
            text: root.artist
            visible: root.artist !== ""
            color: Theme.textMuted
            font.family: "JetBrains Mono Nerd Propo"
            font.pixelSize: 12
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: function(mouse) {
            if (mouse.button === Qt.LeftButton) {
                Quickshell.execDetached(["playerctl", "play-pause"])
            } else if (mouse.button === Qt.RightButton) {
                Quickshell.execDetached(["playerctl", "next"])
            }
        }
    }
}
