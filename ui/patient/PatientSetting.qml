import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import cn.cqu.mri

Rectangle {
    id: root

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
