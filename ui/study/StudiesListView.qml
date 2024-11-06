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

    function maxY() {
        return getItemY(model.cout - 1.5);
    }

    function minY() {
        return getItemY(-0.5);
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
                // 拖动检查项
                var y = item.y;
                var i = item.index;
                if (y > root.getItemY(item.index + 0.5) && item.index < root.model.count - 1) {
                    root.model.move(i, i + 1, 1);
                    root.model.get(i).index = i;
                    root.model.get(i + 1).index = i + 1;
                    root.updateItemY();
                } else if (y < root.getItemY(item.index - 0.5) && item.index > 0) {
                    root.model.move(i, i - 1, 1);
                    root.model.get(i).index = i;
                    root.model.get(i - 1).index = i - 1;
                    root.updateItemY();
                }
            }

            function onReleased(event) {
                item.y = root.getItemY(item.index);
            }

            function onStartButtonClicked() {
                root.startItem(item.index);
            }

            function onSetButtonClicked() {
                root.setItem(item.index);
            }
        }
    }
}
