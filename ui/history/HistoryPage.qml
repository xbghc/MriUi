import QtQuick
import QtQuick.Controls

Item {
    id: root

    signal openStudy

    Text {
        text: "History"
        font.pixelSize: 20
        anchors.centerIn: parent
    }

    Button {
        text: "Show Study Page"
        anchors.top: parent.top
        anchors.right: parent.right
        onClicked: {
            root.openStudy();
        }
    }
}
