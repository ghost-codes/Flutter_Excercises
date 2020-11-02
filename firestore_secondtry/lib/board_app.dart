
import 'package:firestore_secondtry/ui/CustomCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardApp extends StatefulWidget {
  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  var fireStoreDB = FirebaseFirestore.instance.collection("board").snapshots();

  TextEditingController nameInputController;
  TextEditingController titleInputController;
  TextEditingController descriptionInputController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameInputController = TextEditingController();
    titleInputController = TextEditingController();
    descriptionInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Board App"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showDialog(context);
        },
        child: Icon(FontAwesomeIcons.pen),
      ),

      body: StreamBuilder(
        stream: fireStoreDB,
          builder: (context,snapshot){
          if(!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context,int index){
              return CustomCard(snapshot: snapshot.data,index:index);
              }
          );
          }
      ),
    );
  }

  _showDialog(BuildContext context) async{
    await showDialog<void>(
      context: (context),
      //barrierDismissible: barrierDismissible,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Please fill out the form'),
          contentPadding: EdgeInsets.all(10.0),
          content: Column(
              children:[
                Expanded(
                  child: TextField(
                    autocorrect: true,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Your name*",
                    ),
                    controller: nameInputController,
                  ),
                ),
                Expanded(
                  child: TextField(
                    autocorrect: true,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Title*",
                    ),
                    controller: titleInputController,
                  ),
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
              child: Text('Save'),
              onPressed: () {
                if(titleInputController.text.isNotEmpty&&
                nameInputController.text.isNotEmpty&&
                descriptionInputController.text.isNotEmpty){
                  FirebaseFirestore.instance.collection("board").add({
                    "name":nameInputController.text,
                    "title": titleInputController.text,
                    "description": descriptionInputController.text,
                    "timestamp": DateTime.now(),
                  }).then((response) {
                    print(response.id);
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
        );
      },
    );
  }
}
