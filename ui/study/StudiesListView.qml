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
            root.itemAtIndex(i).y = getChildY(i);
        }
    }

    function getChildY(index) {
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
        isDragging: root.isDragging
        getChildY: root.getChildY

        Connections {
            target: item

            function onPositionChanged(event) {
                // if (!root.isDragging)
                //     return;
                console.log(event.y);
                console.log(item.y);

                if (item.y < root.getChildY(0))
                    item.y = root.getChildY(0);

                if (item.y > root.getChildY(root.model.count - 1))
                    item.y = root.getChildY(listModel.count - 1);

                var i = item.index;
                if (item.y > root.getChildY(item.index + 0.5))
                    [root.model[i], root.model[i + 1]] = [root.model[i + 1], root.model[i]];
                else
                // root.model.move(item.index, item.index + 1, 1);
                if (item.y < root.getChildY(item.index - 0.5))
                    [root.model[i], root.model[i - 1]] = [root.model[i - 1], root.model[i]];
            // root.model.move(item.index, item.index - 1, 1);
            }
        }
    }
}
