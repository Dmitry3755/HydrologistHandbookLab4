import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2


ApplicationWindow {
    id: mainWinow
    width: 900
    height: 500
    visible: true
    title: qsTr("Справочник Гидролога")

    SystemPalette {
        id: palette
        colorGroup: SystemPalette.Active
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: riverAddButton.top
        anchors.bottomMargin: 10
        border.color: "black"
        ScrollView {
            anchors.fill:  parent

            Text {
                anchors.fill: parent
                text: "Could not connect to SQL"
                color: "red"
                font.pointSize: 20
                font.bold: true
                visible: IsConnectionOpen == false
            }
            ListView {
                id: riverList
                anchors.fill: parent
                model: riverModel
                delegate: DelegateForRivers{}
                clip: true
                activeFocusOnTab: true
                focus: true
                opacity: {if (IsConnectionOpen == true) {100} else{0}}
            }
        }
    }

    Button {
        id: riverAddButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin:  10
        anchors.rightMargin: 10
        anchors.right:riverEditButton.left
        text: "Добавить"
        width: 100

        contentItem: Text {
                    text: riverAddButton.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    font.bold: true
                    color: "#FFDB8B"
                }
            MouseArea {
                        id: mouseAreaRiverAddButton
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            windowAddEdit.currentIndex = -1
                            windowAddEdit.show()
                        }
                    }
                background: Rectangle {
                    implicitWidth: 150
                    implicitHeight: 30
                    border.color: mouseAreaRiverAddButton.containsMouse ? "magenta" : "#000000"
                    color: mouseAreaRiverAddButton.containsMouse ? "#4B0082" : "#7851A9"
                    radius: 10
                    border.width: 2.0
                }
    }

    Button {
        id: riverEditButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: riverDeleteButton.left
        anchors.rightMargin: 10
        text: "Редактировать"
        width: 100

        contentItem: Text {
                    text: riverEditButton.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    font.bold: true
                    color: "#FFDB8B"
                }
            MouseArea {
                        id: mouseAreaRiverEditButton
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            var name = riverList.currentItem.riverData.Name
                            var lenght = riverList.currentItem.riverData.Lenght
                            var fallsIn = riverList.currentItem.riverData.FallsIn
                            var annualRunoff = riverList.currentItem.riverData.AnnualRunoff
                            var coolArea = riverList.currentItem.riverData.CoolArea
                            var elementID = riverList.currentItem.riverData.Id

                            windowAddEdit.execute(name, lenght, fallsIn, annualRunoff, coolArea, elementID)
                        }
                    }
                background: Rectangle {
                    implicitWidth: 150
                    implicitHeight: 30
                    border.color: mouseAreaRiverEditButton.containsMouse ? "magenta" : "#000000"
                    color: mouseAreaRiverEditButton.containsMouse ? "#4B0082" : "#7851A9"
                    radius: 10
                    border.width: 2.0
                }
    }

    Button {
        id: riverDeleteButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right:parent.right
        anchors.rightMargin: 10
        text: "Удалить"
        width: 100

        contentItem: Text {
                    text: riverDeleteButton.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    font.bold: true
                    color: "#FFDB8B"
                }
            MouseArea {
                        id: mouseAreaRiverDeleteButton
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: del(riverList.currentItem.riverData.Id)
                    }
                background: Rectangle {
                    implicitWidth: 150
                    implicitHeight: 30
                    border.color: mouseAreaRiverDeleteButton.containsMouse ? "magenta" : "#000000"
                    color: mouseAreaRiverDeleteButton.containsMouse ? "#4B0082" : "#7851A9"
                    radius: 10
                    border.width: 2.0
                }

        enabled: {
            if (riverList.currentItem==null || riverList.currentItem.riverData == null)
            {false}
            else {riverList.currentItem.riverData.Id >= 0}}
    }

    Button {
        id: riverCountButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: riverAddButton.left
        anchors.rightMargin: 10
        text: "Расчитать"
        width: 100

        contentItem: Text {
                    text: riverCountButton.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    font.bold: true
                    color: "#FFDB8B"
                }
        MouseArea {
                    id: mouseAreaRiverCountButton
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {riverWindow.show()}
                }
                background: Rectangle {
                    implicitWidth: 150
                    implicitHeight: 30
                    border.color: mouseAreaRiverCountButton.containsMouse ? "magenta" : "#000000"
                    color: mouseAreaRiverCountButton.containsMouse ? "#4B0082" : "#7851A9"
                    radius: 10
                    border.width: 2.0
                }
    }

    DialogForRiver {
        id: windowAddEdit
    }

    Window {
            id: riverWindow
            width: 200
            height: 300
            title: qsTr("Количество рек")

            TextField {
                id: countRiverTextField
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 10
                font.pixelSize: 12
                placeholderText: qsTr("Введите площадь бассйна")

            }


            TextField {
                id: riversTextField
                anchors.top: countRiverTextField.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 10
                font.pixelSize: 12
            }

            Button {
                id: buttonCountRiver
                text: qsTr("Расчитать")
                anchors.bottom: parent.bottom
                width: 95
                anchors.right: buttonExit.left
                anchors.left: parent.left
                anchors.margins: 10

                contentItem: Text {
                            text: buttonCountRiver.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 10
                            font.bold: true
                            color: "#FFDB8B"
                        }
                MouseArea {
                            id: mouseAreaButtonCountRiver
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                var river =0
                                for(var i =0; i < riverList.count; i++)
                                {
                                    riverList.currentIndex = i;
                                    if(parseInt(riverList.currentItem.riverData.CoolArea) > parseInt(countRiverTextField.text))
                                    {
                                        river ++
                                    }
                                }
                                riversTextField.text = river.toString()
                            }
                            }
                        background: Rectangle {
                            implicitWidth: 150
                            implicitHeight: 30
                            border.color: mouseAreaButtonCountRiver.containsMouse ? "magenta" : "#000000"
                            color: mouseAreaButtonCountRiver.containsMouse ? "#4B0082" : "#7851A9"
                            radius: 10
                            border.width: 2.0
                        }
                }
            Button {
                id: buttonExit
                text: qsTr("Выйти")
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: 10

                contentItem: Text {
                            text: buttonExit.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 10
                            font.bold: true
                            color: "#FFDB8B"
                        }
                    MouseArea {
                                id: mouseAreaButtonExit
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                       mainWinow.show()
                                       riverWindow.hide()
                                }
                            }
                        background: Rectangle {
                            implicitWidth: 85
                            implicitHeight: 30
                            border.color: mouseAreaButtonExit.containsMouse ? "magenta" : "#000000"
                            color: mouseAreaButtonExit.containsMouse ? "#4B0082" : "#7851A9"
                            radius: 10
                            border.width: 2.0
                        }
            }
    }
}
