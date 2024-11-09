import QtQuick

import cn.cqu.mri

Item {
    id: root

    // 用于显示的参数
    required property int index
    required property string name
    required property int time

    property int timeSpent: 0
    // mouseArea相关
    signal positionChanged(MouseEvent mouse)
    signal pressed(MouseEvent mouse)
    signal released(MouseEvent mouse)
    // 按钮
    signal startButtonClicked
    signal setButtonClicked

    function startTimer() {
        timeSpent = 0;
        timer.running = true;
    }

    function stopTimer() {
        timer.running = false;
    }

    Component.onCompleted: {
        updateTimeText();
    }

    function updateTimeText() {
        seqtimeText.text = secToText(timeSpent) + '/' + secToText(time);
    }

    function secToText(sec) {
        return Math.floor(sec / 60) + ":" + (sec % 60).toString().padStart(2, '0');
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: dragArea.drag.active ? 5 : 0
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

                anchors.fill: parent
                cursorShape: Qt.SizeVerCursor
                onPressed: function (mouse) {
                    root.pressed(mouse);
                }
                onPositionChanged: function (mouse) {
                    root.positionChanged(mouse);
                }
                onReleased: function (mouse) {
                    root.released(mouse);
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
            text: ''
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
                root.startTimer();
                root.startButtonClicked();
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
                root.setButtonClicked();
            }
        }
    }

    Timer {
        id: timer

        interval: 1000
        running: false
        repeat: true

        onTriggered: {
            root.timeSpent += 1;
            root.updateTimeText();
        }
    }
}
