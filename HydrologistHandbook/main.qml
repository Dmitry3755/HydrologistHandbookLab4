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

        onClicked: {
            windowAddEdit.currentIndex = -1
            windowAddEdit.show()
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
        onClicked: {
            var l = riverList.currentItem.riverData;
            var name = riverList.currentItem.riverData.Name
            var lenght = riverList.currentItem.riverData.Lenght
            var fallsIn = riverList.currentItem.riverData.FallsIn
            var annualRunoff = riverList.currentItem.riverData.AnnualRunoff
            var coolArea = riverList.currentItem.riverData.CoolArea
            var elementID = riverList.currentItem.riverData.Id

            windowAddEdit.execute(name, lenght, fallsIn, annualRunoff, coolArea, elementID)
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
        enabled: {
            if (riverList.currentItem==null || riverList.currentItem.riverData == null)
            {false}
            else {riverList.currentItem.riverData.Id >= 0}}
        onClicked: del(riverList.currentItem.riverData.Id)
    }

    DialogForRiver {
        id: windowAddEdit
    }
}
