import QtQuick 2.6
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2

Rectangle {
    id: riverItem
    readonly property color evenBackgroundColor: "#f9f9f9"
    readonly property color oddBackgroundColor: "#ffffff"
    readonly property color selectedBackgroundColor: "#eaf1f7"

    property bool isCurrent: riverItem.ListView.view.currentIndex === index
    property bool selected: riverItemMouseArea.containsMouse || isCurrent
    property variant riverData: model

    width: parent ? parent.width : riverList.width
    height: 90

    states: [
        State {
            when: selected
            PropertyChanges { target: riverItem;
                color: isCurrent ? palette.highlight : selectedBackgroundColor
            }
        },
        State {
            when: !selected
            PropertyChanges { target: riverItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: riverItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            riverItem.ListView.view.currentIndex = index
            riverItem.forceActiveFocus()
        }
    }
    Item {
        id: itemOfRivers
        width: parent.width
        height: 90
        Column{
            id: t2
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 240
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Название реки:"
                color: "firebrick"
                font.pointSize: 14
            }
            Text {
                id: textName
                anchors.horizontalCenter: parent.horizontalCenter
                text: Name
                color: "red"
                font.pointSize: 14
                font.bold: true
            }
        }

        Column{
            id: t3
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {

                text: "Протяженность"
                color: "firebrick"
                font.pointSize: 14
            }
            Text {
                id: textLenght
                text: Lenght
                color: "purple"
                font.pointSize: 14
            }
        }
        Column{
            id: t4
            anchors.left: t3.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {

                text: "Впадает в"
                color: "firebrick"
                font.pointSize: 14
            }
            Text {
                id: textFallsIn
                text: FallsIn
                color: "purple"
                font.pointSize: 14
            }
        }
        Column{
            id: t5
            anchors.left: t4.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {

                text: "Годовой сток"
                color: "firebrick"
                font.pointSize: 14
            }
            Text {
                id: textAnnualRunoff
                text: AnnualRunoff
                color: "purple"
                font.pointSize: 14
            }
        }
        Column{
            id: t6
            anchors.left: t5.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {

                text: "Площадь бассейна"
                color: "firebrick"
                font.pointSize: 14
            }
            Text {
                id: textCoolArea
                text: CoolArea
                color: "purple"
                font.pointSize: 14
            }
        }
    }
}

