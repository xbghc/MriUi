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

    function deleteCurrentPatient() {
        patients.splice(patientComboBox.currentIndex, 1);
        patients = [...patients];
        PatientManager.savePatients(patients);
    }

    PatientWindow {
        id: patientWindow

        visible: false
    }

    Connections{
        target: patientWindow
        
        function onAccept(patientInfo) {
            if (patientWindow.createNew) {
                root.patients = [...root.patients, patientInfo];
            } else {
                var i = patientComboBox.currentIndex;
                root.patients[i] = patientInfo;
                root.patients = [...root.patients]; // 刷新显示
                patientComboBox.currentIndex = i;
            }
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

            Layout.preferredWidth: parent.height * 0.6
            Layout.preferredHeight: parent.height * 0.6
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            source: "qrc:/icons/new_patient"
            onClicked: {
                root.showPatientWindow();
            }
        }

        IconButton {
            id: editPatientButton

            Layout.preferredWidth: parent.height * 0.6
            Layout.preferredHeight: parent.height * 0.6
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            source: "qrc:/icons/edit_patient"
            onClicked: {
                root.showPatientWindow(root.patients[patientComboBox.currentIndex]);
            }
        }

        IconButton {
            id: deletePatientButton

            Layout.preferredWidth: parent.height * 0.6
            Layout.preferredHeight: parent.height * 0.6
            source: "qrc:/icons/delete_patient"
            onClicked: {
                root.deleteCurrentPatient();
            }
        }
    }
}
