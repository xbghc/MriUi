pragma ComponentBehavior: Bound
import QtQuick

import cn.cqu.mri

ListView {
    id: root

    signal startItem(int index)
    signal setItem(int index)

    property bool isDragging: false
    property int offsetY: 40
    property int startIndex: -1

    function updateItemY() {
        for (var i = 0; i < model.count; i++) {
            root.itemAtIndex(i).y = getItemY(i);
        }
    }

    function getItemY(index) {
        return index * offsetY;
    }

    interactive: !isDragging

    moveDisplaced: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: 200
        }
    }

    delegate: StudyItem {
        id: item

        width: root.width
        height: root.offsetY
        anchors.margins: 5

        Connections {
            target: item

            function onPositionChanged(event) {
                var i = item.index;
                if (item.y > root.getItemY(item.index + 0.5))
                    [root.model[i], root.model[i + 1]] = [root.model[i + 1], root.model[i]];
                else if (item.y < root.getItemY(item.index - 0.5))
                    [root.model[i], root.model[i - 1]] = [root.model[i - 1], root.model[i]];
            }

            function onReleased(event){
                item.y = root.getItemY(item.index);
            }

            function onStartButtonClicked(){
                root.startItem(item.index)
            }

            function onSetButtonClicked(){
                root.setItem(item.index)
            }
        }
    }
}
