//=====================*******==========================================*******=====================

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

Page {
    allowedOrientations: Orientation.All

    property int noteEditFlag

//=====================*******==========================================*******=====================
    function dbDrop()
    {
        var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
        try {
            db.transaction(function (tx) {
                tx.executeSql("DROP TABLE IF EXISTS  RequestTable");
                console.log("db DROP")

            })
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }
//=====================*******=====================
    function dbInit()
    {
        var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
        try {
            db.transaction(function (tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS RequestTable (id INTEGER PRIMARY KEY, date text, request text)");
              //  tx.executeSql("INSERT INTO RequestTable (date, request) VALUES(?, ?)", ["1234", "Test"]);
                console.log("db OK")

            })
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }
//=====================*******=====================
    function dbReadAll()
    {
        var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
        db.transaction(function (tx) {
            var results = tx.executeSql("SELECT id, date, request FROM RequestTable");

          //  for (var i = 0; i < results.rows.length; i++) {
            for (var i = results.rows.length-1; i >=0 ; i--) {

                listModel.append({
                                     id: results.rows.item(i).id,
                                     date: results.rows.item(i).date,
                                     request: results.rows.item(i).request
                                 })
                console.log("dbRead" + results.rows.item(i).id)
            }
        })
    }
//=====================*******=====================
    function dbInsert(Pdate, Prequest)
    {
       var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
       db.transaction(function (tx) {
            tx.executeSql("INSERT INTO RequestTable (date, request) VALUES(?, ?)", [Pdate, Prequest]);

        })

    }
//=====================*******=====================
    function dbUpdate(Pid, Pdate, Prequest)
    {
       var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
       db.transaction(function (tx) {
            tx.executeSql("UPDATE RequestTable SET date = ?, request = ? WHERE id = ?", [Pdate, Prequest, Pid]);

        //   tx.executeSql("UPDATE RequestTable SET date = ?, request = ? WHERE id = 15", [Pdate, Prequest]);

         console.log("dbUpdate " + Pid)

        })

    }


//=====================*******=====================
    function dbDelete(Pid)
    {
       var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
       db.transaction(function (tx) {
            tx.executeSql("DELETE FROM RequestTable WHERE id = ?", [Pid]);

          console.log("dbDelete " + Pid)
        })

    }
//=====================*******=====================
    ListModel {
      id: listModel
    }
//=====================*******==========================================*******=====================
    PageHeader {
      id :  reqheader
      objectName: "pageHeader"
      title: qsTr("ЗАМЕТКИ")
    }

    Label {
        id  : datelabel
        anchors.top: reqheader.bottom
        text: qsTr("ДАТА")
    }

    TextField {
      id: dateInput
      anchors.top: datelabel.bottom
      validator: RegExpValidator { regExp: /[0-9/,:.]+/ }
        }

    Label {
        id  : disclabel
        anchors.top: dateInput.bottom
        text: qsTr("ОПИСАНИЕ")
    }

    TextField {
        id: descInput
        anchors.top: disclabel.bottom
    }

    Button {
        id: saveButton
        anchors.top: descInput.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        preferredWidth : Theme.buttonWidthMedium
        text: qsTr("СОХРАНИТЬ")

        onClicked: {

           if (noteEditFlag == 0)
             {
              dbInsert(dateInput.text, descInput.text);
              listModel.clear();
              dbReadAll();
             }
           else
            {
              dbUpdate(noteEditFlag, dateInput.text, descInput.text);
              listModel.clear();
              dbReadAll();
              noteEditFlag = 0;
            }


        }
     }
//=====================*******==========================================*******=====================
    SilicaListView {
        id: requestlist
        anchors.top: saveButton.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        header: Component {
          Label {
            text: qsTr("СОХРАНЁННЫЕ ЗАМЕТКИ")
          }
        }

        model: listModel

        delegate: ListItem {
            width: requestlist.width
            Label {
                id: firstName
                text: model.id + " " + model.date + " " + model.request
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
            }


            menu: ContextMenu {
                id: contmenu
                MenuItem {
                    id : cm1
                    text: qsTr("РЕДАКТИРОВАТЬ")
                    onClicked: {
                      dateInput.text = model.date
                      descInput.text = model.request

                      noteEditFlag = model.id

                    }

                }
                MenuItem {
                    text: qsTr("УДАЛИТЬ")
                    onClicked: {
                      dbDelete(model.id)
                      listModel.clear();
                      dbReadAll();

                    }
                }
             }



        }
        VerticalScrollDecorator {}
    }
//=====================*******==========================================*******=====================
    Component.onCompleted: {
     // dbDrop()

     dbInit();
     dbReadAll();

     noteEditFlag = 0

      console.log("RequestPagecomplite")
    }

//=====================*******==========================================*******=====================
}
