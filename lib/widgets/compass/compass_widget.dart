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

class _CompassWidgetState extends State<CompassWidget> {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double radius = width * 0.7;
    if (height < width) {
      radius = height * 0.4;
    }
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 2.0,
                  ),
                ],
                color: Theme.of(context).accentColor,
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
                  height: radius,
                  width: radius,
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
