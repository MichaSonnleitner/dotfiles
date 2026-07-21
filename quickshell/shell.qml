import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ShellRoot{
    Variants{
        model: Quickshell.screens
        PanelWindow{
            required property var modelData
            property int rad: 48

            screen: modelData
            color: Theme.transparent
            anchors{
                top: true
                left: true
                right: true
            }
            implicitHeight: 38

            Menu{}

            RowLayout{
                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.rightMargin: 14

                Workspace{}

                Item{ Layout.fillWidth: true }

                    Rectangle{
                        Layout.preferredWidth: clock.implicitWidth + 10
                        Layout.preferredHeight: clock.implicitHeight + 10
                        color: Theme.backgroundAlt
                        radius: rad

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                clockMenu.opened = !clockMenu.opened
                            }
                        }
                        Clock{
                            id: clock
                            anchors.centerIn: parent
                        }
                    }

                Item{ Layout.fillWidth: true }

                RowLayout{
                    spacing: 6
                    id: rightPanel
                    Layout.alignment: Qt.AlignVCenter

                    Rectangle{
                        Layout.preferredWidth: network.implicitWidth + 10
                        Layout.preferredHeight: network.implicitHeight + 10
                        color: Theme.backgroundAlt
                        radius: rad
                        Network{
                            id: network
                            anchors.centerIn: parent
                        }
                    }


                    Rectangle{
                        Layout.preferredWidth: volume.implicitWidth + 10
                        Layout.preferredHeight: volume.implicitHeight + 10
                        color: Theme.backgroundAlt
                        radius: rad
                        Volume{
                            id: volume
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle{
                        Layout.preferredWidth: battery.implicitWidth + 10
                        Layout.preferredHeight: battery.implicitHeight + 10
                        color: Theme.backgroundAlt
                        radius: rad
                        Battery{
                            id: battery
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
}