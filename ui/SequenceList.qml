import QtQuick

import "./views"

Item{
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

    SequenceListView{
        id: view
        anchors.fill: parent

        model: listModel
    }

}
