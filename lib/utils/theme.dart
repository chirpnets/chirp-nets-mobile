import 'package:flutter/material.dart';

final primaryTheme = ThemeData(
  textTheme: TextTheme(
    title: TextStyle(
      color: Colors.white,
    ),
    subtitle: TextStyle(
      color: const Color(0xFF15586C),
      fontSize: 20,
    ),
    subhead: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18
    ),
    caption: TextStyle(
      fontSize: 14,
    ),
    body1: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    body2: TextStyle(
      color: Colors.white,
    ),
    button: TextStyle(
      color: Colors.black,
    ),
  ),
  splashColor: const Color(0xFFB5D5FF),
  highlightColor: const Color(0xFF15586C), // received message colour
  cardColor: Colors.lightGreen, // sent message colour
  primarySwatch: Colors.lightBlue,
  accentColor: const Color(0xFFFFFFFF).withOpacity(0.8),
  buttonColor: const Color(0xFFFFFFFF).withOpacity(0.8),
  canvasColor: Colors.transparent,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  errorColor: Colors.red,
);

const bubbleColours = [
  const Color(0xFF78DBC7),
  const Color(0xFFE78EA2),
  const Color(0xFFDBCE78),
  const Color(0xFFD0BCDA),
  const Color(0xFFD36363),
  const Color(0xFFBBACEA),
  const Color(0xFFACDEEA)
];

var compassMainColour = const Color(0xFFFFFFFF).withOpacity(0.8);
