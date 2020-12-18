import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';


bool darkMode = false;
String displayName = "anonymous";

TextStyle buttonTextStyle(){return TextStyle(color: Colors.white);}
TextStyle blackWhiteTextStyle(){return TextStyle(color: (darkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.white10));}
TextStyle whiteBlackTextStyle(){return TextStyle(color: (darkMode ? Color.fromARGB(255, 255, 255, 255) : Colors.black87));}
Color buttonColor(){return Colors.deepPurpleAccent;}
Color backgroundColor(){return (darkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.white24);}
Color backgroundInverseColor(){return ((darkMode) ? Color.fromARGB(255, 255, 255, 255) : Colors.black87);}

final translator = new GoogleTranslator();
String translatorLanguage = "en";
final languages = ['af', 'ar', 'az', 'be', 'bg', 'ca', 'cs', 'cy', 'da', 'de', 'dv', 'el', 'en', 'eo', 'es', 'et', 'eu', 'fa', 'fi', 'fo', 'fr', 'gl', 'gu', 'he', 'hi', 'hr', 'hu', 'hy', 'id', 'is', 'it', 'ja', 'ka', 'kk', 'kn', 'ko', 'ky', 'lt', 'lv', 'mi', 'mk', 'mn', 'mr', 'ms', 'mt', 'nb', 'nl', 'ns', 'pa', 'pl', 'ps', 'pt', 'qu', 'ro', 'ru', 'sa', 'se', 'sk', 'sl', 'sq', 'sv', 'sw', 'ta', 'te', 'th', 'tl', 'tn', 'tr', 'tt', 'ts', 'uk', 'ur', 'uz', 'vi', 'xh', 'zh', 'zu'];
