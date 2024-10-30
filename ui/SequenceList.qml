import QtQuick

import MriUi
import "./views"

Item {
    id: root

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
