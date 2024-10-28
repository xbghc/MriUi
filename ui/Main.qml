import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    
    width: 1200
    height: 800
    visible: true
    title: qsTr("MRI UI")

    RowLayout {
        anchors.fill: parent

        Rectangle {
            id: leftPanel

            Layout.preferredWidth: 300
            Layout.fillHeight: true
            color: "lightgrey"

            StackLayout {
                id: leftPanelStackLayout
                anchors.fill: parent
                currentIndex: 0

                ExamDashboard {
                    id: examDashboard
                }

                HistoryPage {
                    id: historyPage
                }

                Connections {
                    target: examDashboard
                    function onOpenHistory(){
                        leftPanelStackLayout.currentIndex = 1;
                    }
                }

                Connections{
                    target: historyPage
                    function onOpenExam(){
                        leftPanelStackLayout.currentIndex = 0;
                    }
                }

            }

        }



        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "white"

            Text {
                text: "Image"
                font.pixelSize: 20
                anchors.centerIn: parent
            }

        }

    }

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

}
