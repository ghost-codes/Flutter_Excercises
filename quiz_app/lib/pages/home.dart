import 'dart:ui';

import 'package:quiz_app/model/Question_model.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int question_index = 0;
  
  final List<Question> _questionBank = [
    Question.name("The U.S.Declaration of Independence was adopted in 1776", true),
    Question.name("The (U.S) Constitution has 26 Amendments", false),
    Question.name("Freedom of religion means:\n You can practice any religion,"
        "or not practice a religion", true),
    Question.name("Journalist is one branch or part of the government.", false),
    Question.name("The Congress does not make federal laws.", false),
    Question.name("There are 100U.S.senators", true),
    Question.name("We elect a U.S Senator for 4 years.", false),
    Question.name("We elect a U.S Representative for 4 years.", true),
    Question.name("A U.S. Senator represents all people of the United States", false),
    Question.name("We vote for President in January", false),
    Question.name("Who vetoes bills is the president", true),
    Question.name("The Constitution was written in 1787.", true)
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("True Citizen", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),

      body: Builder(
        builder :(BuildContext context)=> Container(
          //color: Colors.blueGrey,
          padding: EdgeInsets.all(20),
          child: Column(
            children:[
              Container(
                height: 250,

                  child: Image.asset("asset/images/1.1 flag.png")
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                width: double.infinity,
                //height: 150,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.2,
                  )
                ),
                child: Text(_questionBank[question_index].isQuestion,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: (){

                          final snackbar =(_questionBank[question_index].isAnswer ) ?   SnackBar(
                          content: Text("That was correct",
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          backgroundColor: Colors.green,
                      ): SnackBar(
                            content: Text("Sorry that was wrong",
                              style: TextStyle(
                                  color: Colors.white
                              ),),
                            backgroundColor: Colors.redAccent,
                          );
                        Scaffold.of(context).showSnackBar(snackbar);
                      },
                    color: Colors.blueGrey.shade900,
                      //height: 100,
                      child: Text("TRUE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: (){

                          final snackbar =(!_questionBank[question_index].isAnswer ) ?   SnackBar(
                          content: Text("That was correct",
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          backgroundColor: Colors.green,
                      ): SnackBar(
                            content: Text("Sorry that was wrong",
                              style: TextStyle(
                                  color: Colors.white,
                              ),),
                            backgroundColor: Colors.redAccent,
                          );
                        Scaffold.of(context).showSnackBar(snackbar);
                      },
                    color: Colors.blueGrey.shade900,
                      //height: 100,
                      child: Text("FALSE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      setState(() {
                        question_index= (question_index + 1) % _questionBank.length;
                      });
                    },
                    color: Colors.blueGrey.shade900,
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),

                ],
              ),
            ]
          ),
        ),
      ),
    );

  
  }

  Widget _snackBar(Color c, String message){
    final snackbar = SnackBar(
      content: Text(message,
      style: TextStyle(
        color: Colors.white
      ),),
      backgroundColor: c,
    );
    return snackbar;

  }

  // Widget _darkBtns({Widget k,  var l}){
  //   Widget s;
  //   return FlatButton(
  //     padding: EdgeInsets.all(10),
  //     onPressed: l,
  //     // onPressed: (){
  //     //   switch(x){
  //     //     case "true":
  //     //        s =(_questionBank[question_index].isAnswer.toString()==x) ? _snackBar(Colors.greenAccent, "That was correct"): _snackBar(Colors.redAccent, 'Sorry that was wrong');
  //     //
  //     //       break;
  //     //     case "false":
  //     //         s =(_questionBank[question_index].isAnswer.toString()==x) ? _snackBar(Colors.greenAccent, "That was correct"): _snackBar(Colors.redAccent, 'Sorry that was wrong');
  //     //
  //     //       break;
  //     //     case "next":
  //     //       setState(() {
  //     //         question_index = (question_index + 1)%_questionBank.length;
  //     //       });
  //     //       Widget s = null;
  //     //       break;
  //     //   }
  //     // },
  //     color: Colors.blueGrey.shade900,
  //     //height: 100,
  //     child: k,
  //   );
  // }

  bool toBoolean(String str, [bool strict]) {
    if (strict == true) {
      return str == '1' || str == 'true';
    }
    return str != '0' && str != 'false' && str != '';
  }
}
