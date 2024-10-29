import QtQuick
import QtQuick.Controls

Item {
    id: root

    signal openExam

    Text {
        text: "History"
        font.pixelSize: 20
        anchors.centerIn: parent
    }

    Button {
        text: "Show Exam Page"
        anchors.top: parent.top
        anchors.right: parent.right
        onClicked: {
            root.openExam();
        }
    }
}
