import 'dart:math';
import 'dart:convert';
import 'package:intl/intl.dart';

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

String getTimeSinceMessage(DateTime time) {
  var now = DateTime.now();
  var diff;
  diff = now.difference(time).inMinutes;
  if (diff >= 1440) {
    var dateFormatter = DateFormat(dateFormat);
    return dateFormatter.format(time);
  } else if (diff >= 60) {
    return (diff / 60).round().toString() + 'h ago';
  } else if (diff == 0) {
    return 'now';
  } else {
    return diff.round().toString() + 'm ago';
  }
}

String parseMessage(List<int> message) {
  return AsciiDecoder().convert(message);
}

List<int> encodeMessage(String message) {
  return AsciiEncoder().convert(message);
}

int getChecksum(List<int> message) {
  var checksum = 0;
  for (var item in message) {
    checksum += item;
  }
  return ~checksum;
}

bool validateChecksum(int recievedChecksum, List<int> message) {
  // print(recievedChecksum);
  // print(message);
  int checksum = getChecksum([33, ...message]);
  return checksum == recievedChecksum;
}
