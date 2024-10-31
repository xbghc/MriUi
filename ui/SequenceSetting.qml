import QtQuick

Window{
    id: root

    modality: Qt.ApplicationModal
    width: 600
    height: 800
    color: "lightgray"

    Text{
        anchors.centerIn: parent
        text: "Setting"
    }
}
