import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    property alias source: image.source

    signal clicked()

    Image {
        id: image
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            image.clicked();
        }
        onEntered: {
            parent.opacity = 0.8;
        }
        onExited: {
            parent.opacity = 1;
        }
        onPressed: {
            parent.opacity = 0.5;
        }
        onReleased: {
            parent.opacity = 1;
        }
    }

}
