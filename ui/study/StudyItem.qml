import QtQuick
import QtQuick.Controls

import cn.cqu.mri

Item {
    id: root

    required property int index
    required property string name
    required property string time
    required property bool isDragging
    required property var getChildY
    signal positionChanged(MouseEvent mouse);

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
            text: root.index + 1

            MouseArea {
                id: dragArea

                property int startIndex: -1

                anchors.fill: parent
                cursorShape: Qt.SizeVerCursor
                onPressed: {
                    startIndex = root.index;
                    root.isDragging = true;
                    root.z = 100;
                }
                onPositionChanged: function(mouse){
                    root.positionChanged(mouse)
                }
                onReleased: {
                    root.isDragging = false;
                    root.z = 1;
                }
                drag {
                    target: root
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
            text: root.name
        }

        Text {
            id: seqtimeText

            height: parent.height
            width: 100
            anchors.left: seqnameText.right
            verticalAlignment: Text.AlignVCenter
            text: root.time
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
                root.startItem(delegateItem.index);
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
                root.setItem(delegateItem.index);
            }
        }

        MouseArea {
            id: mouseArea

            hoverEnabled: true
            acceptedButtons: Qt.RightButton
            onClicked: function (mouse) {
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