import 'package:flutter/material.dart';

class StyleApp{

 final Color fontText = const Color.fromARGB(211, 255, 255, 255);

 final BoxDecoration boxDecoration1 = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blue.shade700,
        Colors.blue.shade300,
      ],
    )
  );

  final BoxDecoration2 = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blue.shade900,
        Colors.blue.shade500,
      ],
    )
  );


}