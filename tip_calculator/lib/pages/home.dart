
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tip_calculator/util/hexColor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double _billAmount = 0.0;
  int _personCounter = 1;

  double _tipPerPerson = 0.0;
  double _tip = 0.0;

  int _tipPercent =1;


   final Color _darkColor = HexColor("#6908d6");
   final Color _lightColor = HexColor("#6908d6").withOpacity(0.1);

   final TextStyle _greyOutlineContainer = TextStyle(
    color: Colors.grey,
    fontSize: 21.0,
  );

   final TextStyle _darkOutlineContainer = TextStyle(
    color: HexColor("#6908d6"),
    fontWeight: FontWeight.bold,
    fontSize: 22.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children:[
            _totalPerPersonContainer(),
            _calculatorContainer(),
          ],
        ),
      ),
    );
  }

  Container _calculatorContainer() {
    return Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 25),
            width: double.infinity,
            //height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _lightColor,
                width: 1.3
              )
            ),
            child: Column(
              children: [
               TextField(
                 style: _darkOutlineContainer,
                 keyboardType: TextInputType.numberWithOptions(decimal: true),
                 decoration: InputDecoration(
                   prefixText: "Bill Amount ",
                   prefixStyle: _greyOutlineContainer,
                   prefixIcon: Icon(Icons.attach_money,color: _darkColor,)
                 ),
                 onChanged: (String value){

                   try{
                     _billAmount = double.parse(value);
                     _billAmount = _billAmount.abs();
                   }catch(exception){
                    _billAmount = 0.0;
                   }
                   setState(() {
                     _tip = _billAmount * (_tipPercent/100);
                    _tipPerpersonCalc();
                   });
                 },
               ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(child: Text("Split",
                    style: _greyOutlineContainer,)),
                    InkWell(
                      onTap: (){
                        setState(() {
                          _personCounter = (_personCounter == 1) ? 1 : _personCounter-=1;
                          //_tipPerPerson = _tip / _personCounter;
                          _tipPerpersonCalc();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        //padding: EdgeInsets.all(10.0),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: _lightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text("-",
                        style: _darkOutlineContainer,)),
                      ),
                    ),
                    Text("$_personCounter",
                    style: _darkOutlineContainer,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          _personCounter += 1;
                          _tipPerpersonCalc();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        //padding: EdgeInsets.all(10.0),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: _lightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text("+",
                          style: _darkOutlineContainer)),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tip",
                    style: _greyOutlineContainer,),
                    Text("\$$_tip",
                    style: _darkOutlineContainer,)
                  ]
                ),
                SizedBox(height: 15,),
                Text("$_tipPercent"+"%",
                style: _darkOutlineContainer,),

                Slider(

                  min: 0,
                  max: 100,
                  activeColor: _darkColor,
                  inactiveColor: _lightColor,
                  divisions: 10,
                  value: _tipPercent.toDouble(),
                  onChanged: (double NewValue){
                    setState(() {
                      _tipPercent = NewValue.round();
                      _tip = _billAmount * (_tipPercent/100);
                      _tipPerpersonCalc();
                    });
                  },
                )
              ],
            ),

          );
  }

  Container _totalPerPersonContainer() {
    return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: _lightColor,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total per person",
                style: TextStyle(
                  fontSize: 20,
                  color: _darkColor,
                )),
                SizedBox(height: 15,),
                Text("\$"+"$_tipPerPerson",
                style: TextStyle(
                  fontSize: 45,
                  color: _darkColor,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          );
  }

  _tipPerpersonCalc(){
    _tipPerPerson =_tip / _personCounter;
    _tipPerPerson = double.parse(_tipPerPerson.toStringAsFixed(2));
  }
}
