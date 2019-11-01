import 'package:flutter_blue/flutter_blue.dart';
import 'package:chirp_nets/utils/database.dart';
import 'package:chirp_nets/models/device.dart';

class Bluetooth {
  var _device;
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  void connectToDevice(userId, ) async {
    var scanSubscription = _flutterBlue.scan().listen((scanResult) async {
      // do something with scan result
      _device = scanResult.device;
      print('${_device.name} found! rssi: ${scanResult.rssi}');
    });
    scanSubscription.onDone(() async {
      await _device.connect();
      Device device = new Device(
        id: 1,
        name: _device.name,
        userId: userId,
      );

      create(table: 'devices', object: device);
    });
    scanSubscription.cancel();
  }
}
