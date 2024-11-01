import QtQuick

Window{
    id: root

    function setParameters(_parameters){
        parameters
    }

    property var parameters: null

    modality: Qt.ApplicationModal
    width: 600
    height: 800
    color: "lightgray"

    Text{
        anchors.centerIn: parent
        text: "Setting"
    }
}
