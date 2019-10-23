import 'package:flutter_blue/flutter_blue.dart';
var device;
FlutterBlue flutterBlue = FlutterBlue.instance;
var scanSubscription = flutterBlue.scan().listen((scanResult) {
    // do something with scan result
    device = scanResult.device;
    print('${device.name} found! rssi: ${scanResult.rssi}');
});

void connectToDevice() async {
  await device.connect();
}
