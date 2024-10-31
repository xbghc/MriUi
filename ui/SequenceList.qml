import QtQuick
import Main

Item {
    id: root

    property var settingWindow: null
    property alias model: view.model

    ListModel {
        id: listModel

        ListElement {
            name: "Scout"
            time: "0:30"
        }

        ListElement {
            name: "T1"
            time: "1:00"
        }

        ListElement {
            name: "T2"
            time: "2:30"
        }
    }

    SequenceListView {
        id: view
        anchors.fill: parent

        model: listModel
    }

    Connections {
        target: view

        function onSetItem(index){
            if(!root.settingWindow){
                root.settingWindow = Qt.createComponent("SequenceSetting.qml").createObject(root)
            }
            root.settingWindow.show()
        }
    }

    Connections {
        target: view

        function onStartItem(index){
            Scanner.scan(1, "hello");
        }
    }

    Connections{
        target: Scanner

        function onScanned(id, data){
            console.log(id);
            console.log(data)
        }
    }

}
