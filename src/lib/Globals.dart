import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool darkMode = false;
String displayName = "anonymous";

TextStyle buttonTextStyle(){return TextStyle(color: Colors.white);}
TextStyle blackWhiteTextStyle(){return TextStyle(color: (darkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.white10));}
TextStyle whiteBlackTextStyle(){return TextStyle(color: (darkMode ? Color.fromARGB(255, 255, 255, 255) : Colors.black87));}
Color buttonColor(){return Colors.deepPurpleAccent;}
Color backgroundColor(){return (darkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.white24);}
Color backgroundInverseColor(){return ((darkMode) ? Color.fromARGB(255, 255, 255, 255) : Colors.black87);}
