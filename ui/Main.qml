pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import cn.cqu.mri

ApplicationWindow {
    id: root

    width: 1200
    height: 800
    visible: true
    title: qsTr("MRI UI")

    function openTunningWindow(index) {
        tuningWindow.show();
        tuningWindow.currentIndex = index;
    }

    Component.onCompleted:{
        
    }

    TuningWindow {
        id: tuningWindow

        visible: false
    }

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
                    function onOpenHistory() {
                        leftPanelStackLayout.currentIndex = 1;
                    }
                }

                Connections {
                    target: historyPage
                    function onOpenExam() {
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
                text: qsTr("image settings")
                onTriggered: {}
            }

            MenuItem {
                text: qsTr("preferences")
                onTriggered: {}
            }
        }

        Menu {
            title: qsTr("Tuning")

            MenuItem {
                text: qsTr("central frequency")
                onTriggered: {
                    root.openTunningWindow(0);
                }
            }

            MenuItem {
                text: qsTr("RF power")
                onTriggered: {
                    root.openTunningWindow(1);
                }
            }

            MenuItem {
                text: qsTr("shimming")
                onTriggered: {
                    root.openTunningWindow(2);
                }
            }
        }
    }
}
