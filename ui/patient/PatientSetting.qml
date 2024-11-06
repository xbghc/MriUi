import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import cn.cqu.mri

Rectangle {
    id: root

    property var patients: null

    Component.onCompleted: {
        // showPatientWindow();
        patients = PatientManager.loadPatients();
    }

    function showPatientWindow(patientInfo) {
        patientWindow.show();
        if (patientInfo == null) {
            patientWindow.createNew = true;
        } else {
            patientWindow.createNew = false;
            patientWindow.setPatientInfo(patientInfo);
        }
    }

    PatientWindow {
        id: patientWindow

        visible: false

        onAccept: function (patientInfo) {
            root.patients = [...root.patients, patientInfo];
            PatientManager.savePatients(root.patients);
        }
    }

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

            displayText: currentText
            model: root.patients
            textRole: "name"

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        IconButton {
            id: newPatientButton

            Layout.preferredWidth: parent.height * 0.8
            Layout.preferredHeight: parent.height * 0.8
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            source: "qrc:/icons/new_patient"
            onClicked: {
                root.showPatientWindow();
            }
        }

        IconButton {
            id: editPatientButton

            Layout.preferredWidth: parent.height * 0.8
            Layout.preferredHeight: parent.height * 0.8
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            source: "qrc:/icons/edit_patient"
            onClicked: {
                root.showPatientWindow();
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
