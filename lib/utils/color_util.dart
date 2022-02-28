import 'package:flutter/painting.dart';

class ColorUtil{
  static Color toColor(String? priColor){
    String latColor = priColor!.replaceAll('#', "");
    return Color(int.parse("0xff$latColor"));
  }
}