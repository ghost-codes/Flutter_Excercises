import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {

  final int index;
  final QuerySnapshot snapshot;

  const CustomCard({Key key, this.index, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.docs[index];
    var docId = snapshot.docs[index].id;
    var timetoDate = DateTime.fromMillisecondsSinceEpoch(
        snapshotData["timestamp"].seconds * 1000
    );

    TextEditingController nameInputController = TextEditingController(text: snapshotData["name"]);
    TextEditingController titleInputController = TextEditingController(text: snapshotData["title"]);
    TextEditingController descriptionInputController = TextEditingController(text: snapshotData["description"]);



    var dateFormatted = new DateFormat("EEE, MMM d, y").format(timetoDate);

    return Column(
      children: [
        Card(
          elevation: 5,
          child: Column(
            children:[
              ListTile(
                title: Text(snapshotData["title"]),
                subtitle: Text(snapshotData["description"]),
                leading: CircleAvatar(
                  radius: 34,
                  child: Text(snapshotData["title"].toString()[0]),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("By: ${snapshotData["name"]}"),
                    SizedBox(width: 20,),
                    Text(dateFormatted),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 IconButton(
                   icon: Icon(FontAwesomeIcons.edit, size: 15,),
                   onPressed: ()async{
                     await showDialog(context: context,
                     child: AlertDialog(
                       title: Text('Please fill out the form to Update'),
                       contentPadding: EdgeInsets.all(10.0),
                       content: Column(
                          children:[
                            TextField(
                         autocorrect: true,
                         autofocus: true,
                         decoration: InputDecoration(
                         labelText: "Your name*",
                         ),
                         controller: nameInputController,
                         ),


                       TextField(
                       autocorrect: true,
                       autofocus: true,
                       decoration: InputDecoration(
                       labelText: "Title*",
                       ),
                       controller: titleInputController,
                    ),

                    Expanded(
                    child: TextField(
                    autocorrect: true,
                    autofocus: true,
                    decoration: InputDecoration(
                    labelText: "Description*",
                    ),
                    controller: descriptionInputController,
                    ),
                    ),
                    ]
                    ),
                       actions: <Widget>[
                         FlatButton(
                           child: Text('Cancel'),
                           onPressed: () {
                             nameInputController.clear();
                             titleInputController.clear();
                             descriptionInputController.clear();

                             Navigator.of(context).pop();// Dismiss alert dialog
                           },
                         ),
                         FlatButton(
                           child: Text('Update'),
                           onPressed: () {
                             if(titleInputController.text.isNotEmpty&&
                                 nameInputController.text.isNotEmpty&&
                                 descriptionInputController.text.isNotEmpty){
                               FirebaseFirestore.instance.collection("board").doc(docId).update({
                                 "name":nameInputController.text,
                                 "title": titleInputController.text,
                                 "description": descriptionInputController.text,
                                 "timestamp": DateTime.now(),
                               }).then((response) {
                                 Navigator.of(context).pop();// Dismiss alert dialog
                                 nameInputController.clear();
                                 titleInputController.clear();
                                 descriptionInputController.clear();

                                 //Navigator.of(context).pop();// Dismiss alert dialog
                               }).catchError((onError)=>print(onError));
                             }
                           },
                         ),
                       ],
                     )
                     );
                   }
                 ),
                SizedBox(width: 20,),
                IconButton(
                   icon: Icon(FontAwesomeIcons.trashAlt, size: 15,),
                   onPressed: () async{
                     print("Delete $docId");
                     await FirebaseFirestore.instance.collection("board")
                     .doc(docId).delete();
                   },
                 ),
              ]
              ),
          ]
          ),
        )

        // Text(snapshot.docs[index]["title"]),
      ],
    );
  }
}
