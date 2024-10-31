import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "."

Item {
    id: root

    signal openHistory

    Component.onCompleted: {
        var model = ExamConfig.loadFromJsonFile();
        for(let i=0;i<model.length;i++){
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

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "lightgrey"

            RowLayout {
                id: parentSettingRow

                anchors.fill: parent

                Text {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 60
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: "Patient"
                }

                ComboBox {
                    id: patientComboBox

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: ["Patient 1", "Patient 2", "Patient 3"]
                }

                IconButton {
                    id: newPatientButton

                    Layout.preferredWidth: parent.height * 0.8
                    Layout.preferredHeight: parent.height * 0.8
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    source: "qrc:/icons/new_patient"
                    onClicked: {
                        console.log("New Patient Button Clicked");
                    }
                }

                IconButton {
                    id: editPatientButton

                    Layout.preferredWidth: parent.height * 0.8
                    Layout.preferredHeight: parent.height * 0.8
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    source: "qrc:/icons/edit_patient"
                    onClicked: {
                        console.log("New Patient Button Clicked");
                    }
                }

                IconButton {
                    id: deletePatientButton

                    scale: 0.8
                    source: "qrc:/icons/delete_patient"
                    onClicked: {
                        console.log("New Patient Button Clicked");
                    }
                }
            }
        }
        SequenceList {
            id: sequenceList

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
