import 'package:flutter/material.dart';

final primaryTheme = ThemeData(
  textTheme: TextTheme(
    title: TextStyle(
      color: Colors.black,
    ),
    subtitle: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    caption: TextStyle(
      fontSize: 14,
    ),
    body1: TextStyle(
      color: Colors.black,
    ),
    body2: TextStyle(
      color: Colors.white,
    ),
    button: TextStyle(
      color: Colors.black,
    ),
  ),
  splashColor: Colors.orange,
  highlightColor: Colors
      .lightGreenAccent, // received message colour
  cardColor: Colors.lightGreen, // sent message colour
  primarySwatch: Colors.lightBlue, 
  accentColor: Colors.lightBlueAccent[100], 
  buttonColor: Colors.lightGreenAccent, 
  canvasColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  errorColor: Colors.red,
);
