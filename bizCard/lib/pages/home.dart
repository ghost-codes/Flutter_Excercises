import 'package:flutter/material.dart';

class Home extends StatelessWidget {


  final TextStyle bigname = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  final TextStyle funstyle =  TextStyle(
    color: Colors.grey,
    fontSize: 18
  ,
  //fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar:AppBar(),
      body:  Container(
          alignment: Alignment.center,
          child:Stack(
          alignment: Alignment.topCenter,
          children:<Widget>[
            _getCard(),
            _getAvatar(),
          ]
        ),
      ),
      
    );
  }

  Widget _getCard(){
    return Container(
      height: 200,
      width: 350,
      margin: EdgeInsets.all(50),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
        color:Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.25),
            offset: Offset(10,6)
          )
          ],
        ),
 //     alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dorkenoo Hope Kwashie", style: bigname,),
            SizedBox(height: 20,),
            Text("hopekwashie.com", style: funstyle,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Icon(Icons.person_outline),
                SizedBox(width: 10,),
                Text("compounddork@gmail.com",style: funstyle,),
                ]
              ),
          ],
      ),
    );
  }




  Widget _getAvatar(){
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        //color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/one.jpg'),
          fit: BoxFit.cover
        ),
        border: Border.all(color: Colors.black,
        width: 1.5)
      ),

    );
  }
}