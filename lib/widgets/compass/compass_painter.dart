import 'dart:math';

import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/utils/theme.dart';
import 'package:chirp_nets/utils/utils.dart';
import 'package:flutter/material.dart';

enum directions {
  north,
  south,
  east,
  west,
}

class CompassPainter extends CustomPainter {
  List<Map<String, dynamic>> locations;
  User user;
  final Paint userPaint;
  final Paint northPaint;
  final Paint directionPaint;
  final Paint subDirectionPaint;
  final Paint circlePaint;

  CompassPainter({this.locations, this.user})
      : userPaint = Paint(),
        northPaint = Paint(),
        directionPaint = Paint(),
        subDirectionPaint = Paint(),
        circlePaint = Paint() {
    circlePaint
      ..color = primaryTheme.canvasColor
      ..style = PaintingStyle.fill;
    subDirectionPaint
      ..color = primaryTheme.canvasColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    directionPaint
      ..color = Colors.blue[700]
      ..style = PaintingStyle.fill
      ..strokeWidth = 50.0;
    northPaint
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;
    userPaint
      ..color = Colors.purple
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;
  }

  void drawArrow(
      Offset centerOffset, double radius, Paint paint, Canvas canvas) {
    Path path = Path();
    Offset start = Offset(0, 6);
    Offset end = Offset(0, -6);
    path.moveTo(start.dx, start.dy);
    path.addPolygon([ start,centerOffset,end], true);
    canvas.drawPath(path, paint);
  }

  void drawName(Offset point, String name, double distance, Canvas canvas) {
    Offset namePoint = Offset(point.dx, point.dy);
    String distanceString = distance.round().toString() + 'Km';
    TextSpan nameText = TextSpan(
      text: '$name\n $distanceString',
      style: primaryTheme.textTheme.body2,
    );
    TextPainter namePainter = TextPainter(
      text: nameText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    namePainter.layout(maxWidth: 60);
    namePainter.paint(canvas, namePoint);
  }

  void drawText(String text, Offset point, Canvas canvas) {
    TextSpan textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
    TextPainter painter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    painter.layout();
    painter.paint(canvas, point);
  }

  void drawSecondaryDirection(Path path, double radius, double angle, Canvas canvas) {
    double x = radius * sin(angle);
    double y = radius * cos(angle);
    Offset offset = Offset(3 * x / 4, 3 * y / 4);
    path.addPolygon([Offset(0, 6), Offset(0, -6), offset], true);
    canvas.drawPath(path, subDirectionPaint);
  }

  void drawMainDirection(Path path, Paint paint, double radius, directions direction, Canvas canvas) {
    double scale = 0.95;
    Offset edgePoint;
    Offset referencePointOne;
    Offset referencePointTwo;
    if (direction == directions.north) {
      drawText('N', Offset(-7, -radius), canvas);
      edgePoint = Offset(0, -scale * radius);
      referencePointOne = Offset(10, 0);
      referencePointTwo = Offset(-10, 0);
    }
    else if (direction == directions.east) {
      drawText('E', Offset(radius-17, -13), canvas);
      edgePoint = Offset(scale * radius, 0);
      referencePointOne = Offset(0, 10);
      referencePointTwo = Offset(0, -10);
    }
    else if (direction == directions.south) {
      drawText('S', Offset(-7, radius-24), canvas);
      edgePoint = Offset(0, scale * radius);
      referencePointOne = Offset(10, 0);
      referencePointTwo = Offset(-10, 0);
    }
    else {
    drawText('W', Offset(-radius+5, -12), canvas);
      edgePoint = Offset(scale * -radius, 0);
      referencePointOne = Offset(0, 10);
      referencePointTwo = Offset(0, -10);
    }

    path.addPolygon([referencePointOne, referencePointTwo, edgePoint], true);
    canvas.drawPath(path, paint);
    path.reset();
  }

  void drawDefaultLabels(double radius, Canvas canvas) {
    Path path = Path();
    canvas.save();
    canvas.translate(radius, radius);
    path.moveTo(0, 0);
    // North
    drawMainDirection(path, northPaint, radius, directions.north, canvas);
    // East
    drawMainDirection(path, directionPaint, radius, directions.east, canvas);
    // South
    drawMainDirection(path, directionPaint, radius, directions.south, canvas);
    // West
    drawMainDirection(path, directionPaint, radius, directions.west, canvas);

    // North East
    drawSecondaryDirection(path, radius, 3*pi/4, canvas);
    // South East
    drawSecondaryDirection(path, radius, pi / 4, canvas);
    // South West
    drawSecondaryDirection(path, radius, 5 * pi / 4, canvas);
    // North West
    drawSecondaryDirection(path, radius, 7 * pi / 4, canvas);

    canvas.restore();
  }

  Offset getOffsetFromCoordinates(fromLocation, toLocation, radius) {
    double bearing = getBearing(
      fromLocation.latitude,
      fromLocation.longitude,
      toLocation.latitude,
      toLocation.longitude,
    );
    double x = radius * sin(bearing);
    double y = radius * cos(bearing);
    return Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    drawDefaultLabels(radius, canvas);
    canvas.save();
    canvas.translate(radius, radius);
    for (var location in locations) {
      Offset offset = getOffsetFromCoordinates(user, location, radius);
      drawArrow(offset, radius, userPaint, canvas);
      drawName(offset, location['name'], 40, canvas);
    }
    canvas.restore();
    canvas.drawCircle(Offset(radius, radius), radius / 6, circlePaint);
    circlePaint.color = Colors.grey[300];
    canvas.drawCircle(Offset(radius, radius), radius / 20, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
