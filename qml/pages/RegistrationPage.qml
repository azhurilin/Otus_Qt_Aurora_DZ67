/*******************************************************************************
**
** Copyright (C) 2022 ru.auroraos
**
** This file is part of the My Aurora OS Application project.
**
** Redistribution and use in source and binary forms,
** with or without modification, are permitted provided
** that the following conditions are met:
**
** * Redistributions of source code must retain the above copyright notice,
**   this list of conditions and the following disclaimer.
** * Redistributions in binary form must reproduce the above copyright notice,
**   this list of conditions and the following disclaimer
**   in the documentation and/or other materials provided with the distribution.
** * Neither the name of the copyright holder nor the names of its contributors
**   may be used to endorse or promote products derived from this software
**   without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
** THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
** FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
** IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
** FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
** OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
** PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS;
** OR BUSINESS INTERRUPTION)
** HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
** WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE)
** ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
** EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
*******************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "RegistrationPage"
    allowedOrientations: Orientation.All

    SilicaFlickable {
      objectName: "flickable"
      anchors.fill: parent
      //contentHeight: layout.height + Theme.paddingLarge
      contentWidth: layout.width; contentHeight: layout.height

      VerticalScrollDecorator { }

        PageHeader {
          id :  regheader
          objectName: "pageHeader"
          title: qsTr("Регистрационная информация")
        }
//=====================*******=====================
        Label {
          id  : surnamelabel
          anchors.top: regheader.bottom
          text: qsTr("ФАМИЛИЯ")
        }
        TextField {
          id  : surnametext
          anchors.top: surnamelabel.bottom
          focus: true
          text: qsTr("СМИТ")
        }

        Label {
          id  : firstnamelabel
          anchors.top: surnametext.bottom
          text:  qsTr("ИМЯ")
        }
        TextField {
          id  : firstnametext
          anchors.top: firstnamelabel.bottom
          focus: true
          text: qsTr("ДЖОН")
        }

        Label {
          id  : secondnamelabel
          anchors.top: firstnametext.bottom
          text:  qsTr("ОТЧЕСТВО")
        }
        TextField {
          id  : secondnametext
          anchors.top: secondnamelabel.bottom
          focus: true
          text: ""
        }
//=====================*******=====================
        Label {
          id  :   maillabel
          anchors.top: secondnametext.bottom
          text:  qsTr("ПОЧТА")
        }
        TextField {
          id  : mailtext
          anchors.top: maillabel.bottom
          inputMethodHints: Qt.ImhEmailCharactersOnly
          focus: true
          text: ""
        }
//=====================*******=====================
        Label {
          id  :   requestlabel
          anchors.top: mailtext.bottom
          text:  qsTr("ТЕМА ЗАМЕТОК")
        }
        TextArea {
          id : requesttext
          anchors.top: requestlabel.bottom
          focus: true
          text: qsTr("НОВАЯ ЗАМЕТКА")
        }
//=====================*******=====================
        TextSwitch {
          id: spamswitch
          anchors.top: requesttext.bottom
          text: qsTr("Я согласен на рассылку")
          // onCheckedChanged: {
          //   device.setStatus(checked ? DeviceState.Armed : DeviceState.Disarmed)
          // }
        }
        TextSwitch {
          id: personalswitch
          anchors.top: spamswitch.bottom
          text: qsTr("Я согласен на обработку персональных данных")
          // onCheckedChanged: {
          //   device.setStatus(checked ? DeviceState.Armed : DeviceState.Disarmed)
          // }
        }
//=====================*******=====================
        Button{
          id: startbutton
          anchors.top: personalswitch.bottom
          anchors.horizontalCenter: parent.horizontalCenter

          preferredWidth : Theme.buttonWidthMedium
          text: qsTr("НАЧАТЬ")
          onClicked: {
            pageStack.push(Qt.resolvedUrl("RequestPage.qml"))
            console.log("startbutton clicked")
          }
        }
//=====================*******==========================================*******=====================
   }
}
