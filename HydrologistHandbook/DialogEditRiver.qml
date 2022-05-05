import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2

Window {
    id: root
    modality: Qt.ApplicationModal
    title: qsTr("Добавление информации о реке")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
            bottom: buttonCancel.top
            margins: 10
        }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Название реки:")
        }
        TextField {
            id: textName
            Layout.fillWidth: true
            placeholderText: qsTr("Введите название реки")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Протяженность:")
        }
        TextField {
            id: textLenght
            Layout.fillWidth: true
            placeholderText: qsTr("Введите протяженность реки")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Куда впадает:")
        }
        TextField {
            id: textFallsIn
            Layout.fillWidth: true
            placeholderText: qsTr("Введите указание, куда впадает")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Годовой сток:")
        }
        TextField {
            id: textAnnualRunoff
            Layout.fillWidth: true
            placeholderText: qsTr("Введите годовой сток")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Площадь бассейна:")
        }
        TextField {
            id: textCoolArea
            Layout.fillWidth: true
            placeholderText: qsTr("Введите площадь бассейна")
        }
    }

    Button {
        anchors {
            right: buttonCancel.left
            verticalCenter: buttonCancel.verticalCenter
            rightMargin: 10
        }

        text: qsTr("ОК")
        width: 100
        onClicked: {
            root.hide()
            if (currentIndex<0)
            {
                add(textName.text, textLenght.text, textFallsIn.text, textAnnualRunoff.text, textCoolArea.text)
            }
            else
            {
                edit(textName.text, textLenght.text, textFallsIn.text, textAnnualRunoff.text, textCoolArea.text, root.currentIndex)
            }

        }
    }

    Button {
        id: buttonCancel
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }

    onVisibleChanged: {
      if (visible && currentIndex < 0) {
          textName.text = ""
          textLenght.text = ""
          textFallsIn.text = ""
          textAnnualRunoff.text = ""
          textCoolArea.text = ""
      }
    }

    function execute(name, lenght, fallsIn, annualRunoff, coolArea, index){
        isEdit = true
        textName.text = name
        textLenght.text = lenght
        textFallsIn.text = fallsIn
        textAnnualRunoff.text = annualRunoff
        textCoolArea.text = coolArea
        root.currentIndex = index
        root.show()
    }

 }
