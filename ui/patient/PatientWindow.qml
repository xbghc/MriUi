import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import cn.cqu.mri
import "../components"

Window {
    id: root

    signal accept(var patientInfo)

    property bool createNew: false
    property alias id: idInput.text
    property alias name: nameInput.text
    property alias isMale: isMaleRadio.checked

    function clear() {
        name = "Alan";
        isMale = true;
        birthdayPicker.clear();
    }

    function getInfo() {
        return {
            "id": id,
            "name": name,
            "isMale": isMale,
            "birthday": birthdayPicker.date.toLocaleDateString()
        };
    }

    function setInfo(patient) {
        id = patient.id;
        name = patient.name;
        isMale = patient.isMale;
        var birthday = Date.fromLocaleDateString(patient.birthday);
        birthdayPicker.setDate(birthday);
    }

    Component.onCompleted: {
        clear();
    }

    height: 600
    width: 300
    visible: true
    color: "lightgray"

    Rectangle {
        anchors.fill: parent
        color: root.color

        ColumnLayout {
            id: columnLayout

            // 保证labelWidth + hInterval + inputWidth = itemWidth
            property int itemHeight: 40
            property int itemWidth: 200
            property int labelWidth: 60
            property int hInterval: 20
            property int inputWidth: 120
            property int itemAlign: Qt.AlignLeft

            width: parent.width
            anchors.leftMargin: 30

            Rectangle {
                id: header

                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Layout.bottomMargin: 20
                color: root.color
                border.width: 1
                border.color: "black"

                Text {
                    anchors.centerIn: parent
                    text: root.createNew ? qsTr("New Patient") : qsTr("Edit Patient")
                }
            } // header

            RowLayout {
                id: idLayout

                Layout.preferredHeight: columnLayout.itemHeight
                Layout.preferredWidth: columnLayout.itemWidth
                Layout.alignment: columnLayout.itemAlign

                Text {
                    Layout.preferredWidth: columnLayout.labelWidth
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    Layout.rightMargin: columnLayout.hInterval
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight

                    text: qsTr("id:")
                }

                Text {
                    id: idInput

                    Layout.preferredWidth: columnLayout.inputWidth
                    Layout.alignment: Qt.AlignVCenter
                }
            } // id

            RowLayout {
                id: nameLayout

                Layout.preferredHeight: columnLayout.itemHeight
                Layout.preferredWidth: columnLayout.itemWidth
                Layout.alignment: columnLayout.itemAlign

                Text {
                    Layout.preferredWidth: columnLayout.labelWidth
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    Layout.rightMargin: columnLayout.hInterval
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight

                    text: qsTr("Name:")
                }

                TextField {
                    id: nameInput

                    Layout.preferredWidth: columnLayout.inputWidth
                    Layout.alignment: Qt.AlignVCenter
                }
            } // name

            RowLayout {
                id: genderLayout

                Layout.preferredHeight: columnLayout.itemHeight
                Layout.preferredWidth: columnLayout.itemWidth
                Layout.alignment: columnLayout.itemAlign

                Text {
                    Layout.preferredWidth: columnLayout.labelWidth
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    Layout.rightMargin: columnLayout.hInterval
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight

                    text: qsTr("Gender:")
                }

                RowLayout {
                    Layout.preferredHeight: columnLayout.itemHeight
                    Layout.preferredWidth: columnLayout.inputWidth
                    Layout.alignment: Qt.AlignHCenter

                    RadioButton {
                        id: isMaleRadio

                        text: qsTr("Male")
                    }

                    RadioButton {

                        text: qsTr("Female")
                    }
                }
            } // gender

            RowLayout {
                id: birthdayLayout

                Layout.preferredHeight: columnLayout.itemHeight
                Layout.preferredWidth: columnLayout.itemWidth
                Layout.alignment: columnLayout.itemAlign

                Text {
                    Layout.preferredHeight: columnLayout.itemHeight
                    Layout.preferredWidth: columnLayout.labelWidth
                    Layout.rightMargin: columnLayout.hInterval
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight

                    text: qsTr("birthday:")
                }

                DatePicker {
                    id: birthdayPicker

                    Layout.preferredHeight: columnLayout.itemHeight
                    Layout.preferredWidth: columnLayout.inputWidth
                    Layout.alignment: Qt.AlignHCenter
                    radius: 4
                    color: root.color
                }
            } // birthday

        } // columnLayout

        Button {
            id: acceptButton

            text: qsTr("OK")

            anchors.bottom: parent.bottom
            anchors.right: rejectButton.left
            anchors.rightMargin: 5
            height: 30
            width: 50

            onClicked: {
                var patientInfo = root.getInfo();
                if (root.createNew && PatientManager.exists(patientInfo)) {
                    msgBox.show();
                    return;
                }

                root.accept(patientInfo);
                root.close();
                root.clear();
            }
        }

        Button {
            id: rejectButton

            text: qsTr("Cancel")

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 5
            height: 30
            width: 50

            onClicked: {
                root.close();
                root.clear();
            }
        }
    }

    MsgBox {
        id: msgBox

        msg: qsTr("Parent Name Exists!")

        visible: false
    }
}
