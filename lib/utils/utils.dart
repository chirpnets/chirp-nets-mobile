import 'dart:math';

double getBearing(double lat1, double lng1, double lat2, double lng2) {
  var y = sin(lng2 - lng1) * cos(lat2);
  var x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lng2 - lng1);
  return atan2(y, x) * 180 / pi;
}

double getDistanceBetweenPoints(
    double lat1, double lng1, double lat2, double lng2) {
  var radius = 6371e3; // radius of Earth metres
  var angle1 = pi * lat1 / 180;
  var angle2 = pi * lat2 / 180;
  var latDifference = (lat2 - lat1) * pi / 180;
  var longDifference = (lng2 - lng1) * pi / 180;
  var a = sin(latDifference / 2) * sin(latDifference / 2) +
      cos(angle1) *
      cos(angle2) *
      sin(longDifference / 2) *
      sin(longDifference / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return radius * c;
}

const String dateFormat = 'MMM d H:mm';
