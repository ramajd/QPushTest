import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    width: 480
    height: 640
    visible: true
    title: qsTr("Qt Push notification Test")

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    Loader {
        visible: Qt.platform.os !== 'android' && Qt.platform.os !== 'ios'
        anchors.centerIn: parent
        z: 1
        sourceComponent: Label {
            text: qsTr("Push notificaitons only work on Mobile devices")
            anchors.centerIn: parent
            font.bold: true
            Material.foreground: Material.Red
            background: Rectangle {
                color: 'yellow'
            }
            bottomInset: -5
            topInset: -5
            leftInset: -5
            rightInset: -5
        }
    }

    ColumnLayout {
        enabled: Qt.platform.os === 'android' || Qt.platform.os === 'ios'
        anchors.fill: parent

        GroupBox {
            title: 'Push notificaiton'
            Layout.margins: 10
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            ColumnLayout {
                anchors.fill: parent

                GroupBox {
                    Layout.fillWidth: true
                    Layout.minimumHeight: 200
                    title: qsTr("Device Token")
                    TextArea {
                        id: txtToken
                        anchors.fill: parent
                        wrapMode: Text.WordWrap
                        selectByMouse: true
                        selectByKeyboard: true
                        readOnly: true
                        placeholderText: "DEVICE TOKEN GOES HERE"
                    }
                }

                TextField {
                    id: txtMessage
                    placeholderText: "Message to send"
                    Layout.fillWidth: true
                }
                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    Button {
                        id: btnLocalNotification
                        Layout.fillWidth: true
                        enabled: txtMessage.text.length !== 0
                        text: qsTr("Local notification")
                        onClicked: {
                            console.log('todo')
                        }
                    }
                    Button {
                        id: btnRemoteNotification
                        Layout.fillWidth: true
                        enabled: txtMessage.text.length !== 0
                        text: qsTr("Remote notification")
                        onClicked: {
                            console.log('todo')
                        }
                    }
                }
            }
        }
    }
}
