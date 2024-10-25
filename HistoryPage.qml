import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    
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
            leftPanelStackLayout.currentIndex = 0
        }
    }
}
