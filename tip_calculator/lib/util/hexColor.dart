import 'package:flutter/material.dart';

class HexColor extends Color{
  static int _getColorfromHex( String hexColor){
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6){
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  
  HexColor(String hexColor): super(_getColorfromHex(hexColor));
}