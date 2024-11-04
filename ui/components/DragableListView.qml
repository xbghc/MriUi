import QtQuick

Rectangle{
    id: root

    property var delegate: null

    ListView{
        id: view

        delegate: root.delegate{
            id: item
            
            MouseArea{
                id: mouseArea

                anchors.fill: parent
                drag {
                    target: item
                    axis: Drag.YAxis
                }
            }
        }            
    }
}
