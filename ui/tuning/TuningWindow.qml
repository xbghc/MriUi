pragma ComponentBehavior: Bound 
import QtQuick
import QtQuick.Layouts

Window{
    id: root

    width: 800
    height: 600

    property alias currentIndex: stackLayout.currentIndex

    RowLayout{
        id: rootLayout
        anchors.fill: parent

        ListView{
            id: tuningOptionList

            Layout.fillHeight: true
            Layout.preferredWidth: 100

            model: ListModel{
                ListElement{ name: "CentralFrequency"; index: 0 }
                ListElement{ name: "RfPower"; index: 1 }
                ListElement{ name: "Shiming"; index: 2 }
            }

            delegate: Item{
                id: delegateItem
                required property string name
                required property int index

                width: 100
                height: 50

                Rectangle{
                    width: 100
                    height: 50
                    color: root.currentIndex==delegateItem.index? "lightgrey": "white"

                    Text{
                        text: delegateItem.name
                        anchors.centerIn: parent
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            root.currentIndex = delegateItem.index
                        }
                    }
                }
            }
        }

        StackLayout{
        id: stackLayout
        Layout.fillHeight: true
        Layout.fillWidth: true
        
        CentralFrequency{
            
        }
        RfPower{
        }
        Shiming{
    }
    }

    
}
}