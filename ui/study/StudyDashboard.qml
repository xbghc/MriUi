import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// import "components"
import cn.cqu.mri

Item {
    id: root

    signal openHistory

    ColumnLayout {
        id: rootLayout

        anchors.fill: parent

        Rectangle {
            id: studyDashboardHeader

            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "white"

            Text {
                Layout.fillWidth: true
                anchors.centerIn: parent
                text: "Study"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                text: "History"
                implicitWidth: 80
                implicitHeight: 30
                anchors.right: parent.right
                onClicked: {
                    root.openHistory();
                }
            }
        }

        PatientSetting {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "lightgrey"
        }

        StudiesList {
            id: studiesList

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
