import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import cn.cqu.mri

Window {
    id: root

    signal accept(var patientInfo)

    property bool createNew: false
    property alias model: repeater.model

    function setPatientInfo(_patientInfo) {
        repeater.model = [];
        for (var key in _patientInfo) {
            repeater.model.push({
                "label": key,
                "value": _patientInfo[key]
            });
        }
    }

    function generatePatientInfo() {
        var info = {};
        for (var i = 0; i < repeater.model.length; i++) {
            var label = repeater.itemAt(i).label;
            var value = repeater.itemAt(i).value;
            info[label] = value;
        }
        return info;
    }

    function clear() {
        setPatientInfo({
            "name": "Alan",
            "birthday": "2000-01-01",
            "gender": "male"
        });
    }

    Component.onCompleted: {
        clear();
    }

    height: 600
    width: 300
    visible: true

    Rectangle {
        anchors.fill: parent
        color: "lightgray"

        ColumnLayout {
            id: layout

            Repeater {
                id: repeater

                model: []

                EditRect {
                    Layout.preferredHeight: 30
                }
            }
        }

        Button {
            id: acceptButton

            text: qsTr("OK")

            anchors.bottom: parent.bottom
            anchors.right: rejectButton.left
            anchors.rightMargin: 5
            height: 30
            width: 50

            onClicked: {
                var patientInfo = root.generatePatientInfo();
                if (PatientManager.exists(patientInfo)) {
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

    component EditRect: Rectangle {
        id: editRect

        required property var modelData
        property alias label: _label.text
        property alias value: _textEdit.text
        property int fontSize: 15

        color: "lightgray"

        RowLayout {
            anchors.fill: parent

            Text {
                id: _label

                text: editRect.modelData.label

                Layout.fillHeight: true
                Layout.preferredWidth: 100
                Layout.leftMargin: 20
                font.pixelSize: editRect.fontSize
            }

            Rectangle {
                id: textEditContainer

                Layout.fillHeight: true
                Layout.preferredWidth: 100
                border.width: 1

                TextEdit {
                    id: _textEdit

                    text: editRect.modelData.value

                    anchors.fill: parent
                    font.pixelSize: editRect.fontSize
                }
            }
        } // layout

    }
}
