import QtQuick
import QtQuick.Layouts

Window {
    id: root

    function initProperties(config) {
        // 复制一份
        var newConfig = JSON.parse(JSON.stringify(config));
        model = newConfig["parameters"];
        console.log(model);
    }

    modality: Qt.ApplicationModal
    width: 600
    height: 800
    color: "lightgray"
    property var model: null
    property alias listViewModel: listView.model

    ColumnLayout {
        id: columnLayout

        anchors.fill: parent

        Rectangle {
            id: slicePreview

            Layout.fillWidth: true
            Layout.preferredHeight: 200

            Layout.alignment: Qt.AlignTop
            Text {
                anchors.centerIn: parent

                text: "Slice Preview"
            }
        }

        ListView {
            id: listView

            Layout.preferredWidth: 500
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            model: root.model

            delegate: Rectangle {
                id: item

                required property string name
                required property var value

                width: parent.width
                height: 50
                Layout.alignment: Qt.AlignHCenter

                Row {
                    anchors.fill: parent

                    Text {
                        width: 150
                        text: item.name
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        width: 80
                        text: item.value
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
