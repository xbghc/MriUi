import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// import "components"
import cn.cqu.mri

Item {
    id: root

    signal openHistory

    Component.onCompleted: {
        var model = ExamConfig.loadFromJsonFile();
        for (let i = 0; i < model.length; i++) {
            model[i]["index"] = i;
        }
        sequenceList.model = model;
    }

    ColumnLayout {
        id: rootLayout

        anchors.fill: parent

        Rectangle {
            id: examDashboardHeader

            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "white"

            Text {
                Layout.fillWidth: true
                anchors.centerIn: parent
                text: "Exam"
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

        SequenceList {
            id: sequenceList

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
