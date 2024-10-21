import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 1200
    height: 800
    visible: true
    title: qsTr("MRI UI")

    menuBar: MenuBar {
        Menu {
            title: qsTr("Settings")

            MenuItem {
                // open image settings dialog

                text: qsTr("image settings")
                onTriggered: {
                }
            }

            MenuItem {
                // open preferences dialog

                text: qsTr("preferences")
                onTriggered: {
                }
            }

        }

        Menu {
            title: qsTr("Tuning")

            MenuItem {
                // open tuning dialog

                text: qsTr("central frequency")
                onTriggered: {
                }
            }

            MenuItem {
                // open tuning dialog

                text: qsTr("RF power")
                onTriggered: {
                }
            }

            MenuItem {
                // open tuning dialog

                text: qsTr("shimming")
                onTriggered: {
                }
            }

        }

    }

    RowLayout{
        anchors.fill: parent

        Rectangle{
            id: leftPanel

            width: 300
            Layout.fillHeight: true
            color: "lightgrey"
            Text{
                text: "MRI UI"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
        }

        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "white"
            Text{
                text: "Image"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
        }
    }

}
