import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property date date: "2000-01-01" // 确认后的时间

    onFocusChanged: {
        picker.visible = false;
    }

    function setDate(other) {
        date = other;
        updateText();
    }

    function clear() {
        setDate(new Date("2000-01-01"));
        yearInput.text = 2000;
        monthCombo.currentIndex = 0;
    }

    function updateText() {
        displayText.text = date.toLocaleDateString();
    }

    Component.onCompleted: {
        clear();
    }

    border.width: 1

    Text {
        id: displayText

        verticalAlignment: Text.AlignVCenter
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            leftMargin: 5
        }

        MouseArea {
            anchors.fill: parent

            cursorShape: Qt.OpenHandCursor

            onClicked: {
                root.setDate(root.date);
                popup.open();
            }
        }
    }

    Popup {
        id: popup

        width: 200
        height: 240

        Rectangle {
            id: picker

            anchors.fill: parent

            opacity: 0.6
            color: "lightblue"

            ColumnLayout {
                anchors.fill: parent

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: qsTr("Year")

                        Layout.preferredWidth: 50
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id: yearInput

                        validator: IntValidator {
                            bottom: 0
                            top: 3000
                        }

                        onTextChanged: {
                            var year = parseInt(text);
                            grid.year = year;
                        }

                        Layout.fillWidth: true
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Text {
                        text: qsTr("Month")

                        Layout.preferredWidth: 50
                        horizontalAlignment: Text.AlignRight
                    }

                    ComboBox {
                        id: monthCombo

                        model: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

                        onDisplayTextChanged: {
                            grid.month = currentIndex;
                        }

                        Layout.fillWidth: true
                    }
                }

                DayOfWeekRow {
                    Layout.fillWidth: true
                }

                MonthGrid {
                    id: grid

                    onClicked: function (_date) {
                        root.setDate(_date);
                        root.updateText();
                        popup.close();
                    }

                    Layout.fillWidth: true
                }
            }
        }
    }
}
