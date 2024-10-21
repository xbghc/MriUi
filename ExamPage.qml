import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    Rectangle {
        id: examPageHeader

        Layout.fillWidth: true
        anchors.left: parent.left
        anchors.right: parent.right
        height: 50
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
                leftPanelStackLayout.currentIndex = 1;
            }
        }

    }

    Rectangle {
        anchors.top: examPageHeader.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "lightgrey"

        RowLayout {
            width: parent.width

            Text {
                Layout.preferredWidth: 60
                horizontalAlignment: Text.AlignHCenter
                text: "Patient"
            }

            ComboBox {
                id: patientComboBox

                Layout.fillWidth: true
                model: ["Patient 1", "Patient 2", "Patient 3"]
            }

            IconButton {
                id: newPatientButton

                scale: 0.8
                source: "qrc:/images/new_patient"
                onClicked: {
                    console.log("New Patient Button Clicked");
                }
            }

            IconButton {
                id: editPatientButton

                scale: 0.8
                source: "qrc:/images/edit_patient"
                onClicked: {
                    console.log("New Patient Button Clicked");
                }
            }

            IconButton {
                id: deletePatientButton

                scale: 0.8
                source: "qrc:/images/delete_patient"
                onClicked: {
                    console.log("New Patient Button Clicked");
                }
            }

        }

        Text {
            text: "Exam Content"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

    }

}
