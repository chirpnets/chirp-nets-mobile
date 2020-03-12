import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  Background({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Color(0xFF57BBB8).withOpacity(0.5)
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
