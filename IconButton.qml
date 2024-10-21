import QtQuick 2.15
import QtQuick.Controls 2.15

Image {
    signal clicked()

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            parent.clicked()
        }
        onEntered: {
            parent.opacity = 0.8
        }
        onExited: {
            parent.opacity = 1
        }
        onPressed: {
            parent.opacity = 0.5
        }
        onReleased: {
            parent.opacity = 1
        }
    }
}