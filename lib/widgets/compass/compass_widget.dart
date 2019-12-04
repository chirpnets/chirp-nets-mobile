import 'dart:math';

import 'package:chirp_nets/models/user.dart';
import 'compass_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassWidget extends StatefulWidget {
  const CompassWidget({
    this.userLocations,
    this.currentUser,
  });

  final List<Map<String, dynamic>> userLocations;
  final User currentUser;

  @override
  _CompassWidgetState createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget>
    with SingleTickerProviderStateMixin {
  final double width = 250;
  final double height = 250;
  final compass = FlutterCompass();
  double rotationAngle = 0;

  void setUpCompass() {
    FlutterCompass.events.listen((double direction) {
      double rotationAngle = direction * pi / 180;
      if (this.mounted) {
        setState(() {
          // Since we want the pointers to be in the same direction regardless of phone orientation
          // we negate the angle to counter the rotation of the phone
          this.rotationAngle = -rotationAngle;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setUpCompass();
  }

  @override
  void dispose() async {
    super.dispose();
    FlutterCompass.events.drain().then((item) {
      compass.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(top: 50),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 5.0),
                    blurRadius: 5.0,
                  ),
                ],
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              child: Transform.rotate(
                angle: rotationAngle,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  height: height,
                  width: width,
                  child: CustomPaint(
                    painter: CompassPainter(
                      user: widget.currentUser,
                      locations: widget.userLocations,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
