import 'package:flutter/material.dart';

class AppTheme{

  Color splashColor = const Color(0xFFa6c5f3);
  Color backcolor= const Color(0xFF212437);
  Color foreground =const Color(0xFF3e425b);
  Color inactive= const Color(0xFF2a2f45);



  TextStyle fontWeightW100(double size) {
    TextStyle dropFontWeightW100 =  TextStyle(
      color: Colors.white,
      fontSize: size,
      fontFamily: 'Noto',
    );
    return dropFontWeightW100;
  }


  TextStyle fontNavBar = const TextStyle(
      color: Colors.white,
      fontSize: 10.0,
      fontFamily: 'Noto',
      fontWeight: FontWeight.w400);

  TextStyle sub = const TextStyle(
      color: Colors.white24,
      fontSize: 15.0,
      fontFamily: 'Noto',
     );

}

