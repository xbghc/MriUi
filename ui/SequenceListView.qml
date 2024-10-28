pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

ListView {
    id: root

    property bool isDragging: false
    property int offsetY: 40
    property int startIndex: -1

    function updateItemY() {
        for (var i = 0; i < model.count; i++) {
            root.itemAtIndex(i).y = getChildY(i);
        }
    }

    function getChildY(index) {
        return index* offsetY;
    }

    width: 300
    height: 400
    // 禁用 ListView 本身的交互性，当项目被拖动时
    interactive: !isDragging

    moveDisplaced: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: 200
        }
    }

    delegate: Item {
        id: delegateItem

        required property int index
        required property string name
        required property string time

        width: root.width
        height: root.offsetY
        anchors.margins: 5
        // 添加拖拽属性
        Drag.active: dragArea.drag.active

        Rectangle {
            id: delegateRect

            anchors.fill: parent
            anchors.margins: dragArea.drag.active ? 5 : 0
            color: dragArea.drag.active ? "#f0f0f0" : (mouseArea.containsMouse ? "#e0e0e0" : "white")
            border.color: dragArea.drag.active ? "#2196F3" : "transparent"
            border.width: 1

            Text {
                id: indexText

                height: parent.height
                width: 30
                color: "#666666"
                anchors.left: parent.left
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: delegateItem.index + 1

                MouseArea {
                    id: dragArea

                    property int startIndex: -1

                    anchors.fill: parent
                    cursorShape: Qt.SizeVerCursor
                    onPressed: {
                        startIndex = delegateItem.index;
                        root.isDragging = true;
                        delegateItem.z = 100;
                    }
                    onPositionChanged: {
                        if (!root.isDragging)
                            return ;

                        if (delegateItem.y < root.getChildY(0))
                            delegateItem.y = root.getChildY(0);

                        if (delegateItem.y > root.getChildY(root.model.count-1))
                            delegateItem.y = root.getChildY(listModel.count-1);

                        if (delegateItem.y > root.getChildY(delegateItem.index+0.5))
                            listModel.move(delegateItem.index, delegateItem.index + 1, 1);
                        else if (delegateItem.y < root.getChildY(delegateItem.index - 0.5))
                            listModel.move(delegateItem.index, delegateItem.index - 1, 1);
                    }
                    onReleased: {
                        root.isDragging = false;
                        delegateItem.z = 1;
                        root.updateItemY();
                    }

                    drag {
                        target: delegateItem
                        axis: Drag.YAxis
                        threshold: 0 // 立即开始拖动
                    }

                }

            }

            Text {
                id: seqnameText

                height: parent.height
                width: 50
                anchors.left: indexText.right
                verticalAlignment: Text.AlignVCenter
                text: delegateItem.name
            }

            Text {
                id: seqtimeText

                height: parent.height
                width: 100
                anchors.left: seqnameText.right
                verticalAlignment: Text.AlignVCenter
                text: delegateItem.time
            }

            IconButton {
                id: startButton

                height: parent.height * 0.8
                width: parent.height * 0.8
                anchors.right: settingButton.left
                anchors.margins: 5
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/icons/start"
                onClicked: {
                }
            }

            IconButton {
                id: settingButton

                height: parent.height * 0.8
                width: parent.height * 0.8
                anchors.right: parent.right
                anchors.margins: 5
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/icons/setting"
                onClicked: {
                }
            }

            MouseArea {
                id: mouseArea

                hoverEnabled: true
                acceptedButtons: Qt.RightButton
                onClicked: function(mouse) {
                    if (mouse.button === Qt.RightButton)
                        contextMenu.popup();

                }

                anchors {
                    left: indexText.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }

            }

            Menu {
                id: contextMenu

                MenuItem {
                    text: "编辑"
                    onTriggered: console.log("编辑项目:", delegateItem.name)
                }

                MenuItem {
                    text: "删除"
                    onTriggered: {
                        root.model.remove(delegateItem.index);
                        console.log("删除项目:", delegateItem.name);
                    }
                }

                MenuItem {
                    text: "详情"
                    onTriggered: console.log("查看详情:", delegateItem.name)
                }

            }

        }

    }

}
