import QtQuick
// import "views"
import cn.cqu.mri

Item {
    id: root

    property var model: null

    Component.onCompleted: {
        var model = StudyConfig.loadFromJsonFile();
        for (let i = 0; i < model.length; i++) {
            model[i]["index"] = i;
            view.model.append(model[i]);
        }
    }

    QtObject {
        id: internal
        property var settingWindow: null
    }

    StudiesListView {
        id: view
        anchors.fill: parent
        model: ListModel {}

        onSetItem: function (index) {
            internal.settingWindow = internal.settingWindow || root.createSettingWindow();
            if (internal.settingWindow) {
                internal.settingWindow.initProperties(root.model[index]);
                internal.settingWindow.show();
            }
        }

        onStartItem: function (index) {
            Scanner.scan(2, "hello");
        }
    }

    Connections {
        target: Scanner

        function onScanned(id, data) {
            console.debug(`Scan completed - ID: ${id}, Data: ${data}`);
        }
    }

    function createSettingWindow() {
        const component = Qt.createComponent("StudySetting.qml");
        if (component.status === Component.Ready) {
            return component.createObject(root);
        } else {
            console.error("Error creating StudySetting:", component.errorString());
            return null;
        }
    }
}
