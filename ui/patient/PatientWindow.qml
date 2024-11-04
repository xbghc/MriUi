import QtQuick
import QtQuick.Layouts

Window {
    id: root

    property bool newPatient: false

    height: 600
    width: 300
    color: "lightgray"

    Rectangle {
        anchors.fill: parent

        ColumnLayout {
            id: layout

            anchors.fill: parent

            EditRect {
                label: "Name"

                Layout.preferredHeight: 30
                Layout.fillWidth: true
            }

            EditRect {
                label: "id"

                Layout.preferredHeight: 30
                Layout.fillWidth: true
            }

            Rectangle{
                Layout.fillHeight: true
            }
        }
    }

    component EditRect: Rectangle {
        id: editRect

        property alias label: _label.text
        property alias text: _textEdit.text
        property int fontSize: 20
        color: "white"

        Row {
            anchors.fill: parent

            Rectangle {
                height: parent.height
                width: 100
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: _label

                    anchors.fill: parent

                    font.pixelSize: editRect.fontSize
                }
            }

            Rectangle {
                height: parent.height
                width: 100
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

                TextEdit {
                    id: _textEdit
                    
                    anchors.fill: parent

                    font.pixelSize: editRect.fontSize
                }
            }
        }
    }
}
