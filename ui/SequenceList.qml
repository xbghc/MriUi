import QtQuick
import 'views'
import cn.cqu.mri

Item {
    id: root

    property var settingWindow: null
    property alias model: view.model

    SequenceListView {
        id: view
        anchors.fill: parent
    }

    Connections {
        target: view

        function onSetItem(index){
            if(!root.settingWindow){
                root.settingWindow = Qt.createComponent("SequenceSetting.qml").createObject(root)
            }
            root.settingWindow.show()
        }
    }

    Connections {
        target: view

        function onStartItem(index){
            Scanner.scan(1, "hello");
        }
    }

    Connections{
        target: Scanner

        function onScanned(id, data){
            console.log(id);
            console.log(data)
        }
    }

}
