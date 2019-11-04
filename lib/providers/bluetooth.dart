import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth with ChangeNotifier {
  BluetoothDevice _device;
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  bool isScanning = false;
  var scanSubscription;

  Future<void> findDevices() async {
    if (!isScanning) {
      _flutterBlue.startScan(timeout: Duration(seconds: 4));
      isScanning = true;
    }

    scanSubscription = _flutterBlue.scanResults.listen((scanResults) {
      // do something with scan result
      for (var device in scanResults) {
        if (device.device.name == 'LE_WH-H900N (h.ear)') {
          _device = device.device;
          print('${device.device.name} found! rssi: ${_device.type}');
        }
      }
    });
    scanSubscription.onDone(() => isScanning = false);

  }

  void connectToDevice() async {
    await _device.connect();
  }

  void cancelScan() {
    scanSubscription.cancel();
  }
}
