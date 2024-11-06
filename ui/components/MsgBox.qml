import QtQuick
import QtQuick.Controls

Window {
    id: root

    required property string msg
    modality: Qt.ApplicationModal

    height: 100

    // width: 200

    Column {
        id: column

        anchors.topMargin: 10
        anchors.fill: parent
        spacing: 10

        Text {
            id: text

            text: root.msg

            width: parent.width
            height: 30
            horizontalAlignment: Text.AlignHCenter
        }

        Button {
            id: button

            text: qsTr("OK")

            width: 50
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: root.close()
        }
    }
}
