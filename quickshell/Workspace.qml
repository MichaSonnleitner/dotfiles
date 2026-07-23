import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout{
    spacing: 7
    Repeater{
        model: 10
        Rectangle{
            id: wsButton
            required property int index

            property var ws: Hyprland.workspaces.values.find(w => w.id === (index + 1))
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: label.implicitWidth + 14
            implicitHeight: label.implicitHeight + 6

            radius: 48

            color: isActive ? Theme.accent : ( ws ? Theme.primary : Theme.background)
            Behavior on color{
                ColorAnimation{
                    duration: 150
                }
            }

            Text{
                id: label
                anchors.centerIn: parent
                text: wsButton.index + 1
                font{
                    family: "JetBrains Mono Nerd Propo"
                    pixelSize: 16
                    weight: 600
                }
                color: Theme.text
            }


        }
    }
}