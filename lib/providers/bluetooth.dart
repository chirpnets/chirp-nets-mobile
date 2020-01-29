import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Bluetooth with ChangeNotifier {
  BluetoothDevice _device;
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  BluetoothCharacteristic txCharacteristic;
  BluetoothCharacteristic rxCharacteristic;
  BluetoothService service;
  bool isScanning = false;
  var scanSubscription;
  var uartServiceUUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  var rxUUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
  var txUUID = "6e400002-b5a3-f393-e0a9-e50e24dcca9e";

  BluetoothDevice get device {
    return _device;
  }

  Future<void> findDevices() async {
    if (_device != null) {
      return;
    }
    if (!isScanning) {
      _flutterBlue.startScan(timeout: Duration(seconds: 4));
      isScanning = true;
    }
    print('finding devices');

    scanSubscription = _flutterBlue.scanResults.listen((scanResults) {
      // do something with scan result
      for (var device in scanResults) {
        if (device.device.name == deviceName) {
          print('Device found');
          _device = device.device;
          _device.connect(autoConnect: false).then((_) {
            Fluttertoast.showToast(msg: deviceConnectedMessage);
            discoverServices();
          });
          notifyListeners();
        }
        if (_device != null) {
          break;
        }
      }
    });
    scanSubscription.onDone(() => isScanning = false);
  }

  void cancelScan() {
    scanSubscription.cancel();
  }

  void discoverServices() {
    _device.discoverServices().then(
      (services) {
        service = services.firstWhere((service) {
          return service.uuid.toString() == uartServiceUUID;
        });
        if (service.uuid.toString() == uartServiceUUID) {
          this.service = service;
        }
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.uuid.toString() == txUUID) {
            print('tx');
            txCharacteristic = c;
            txCharacteristic.value.listen((value) {
              if (txCharacteristic.isNotifying) {
                print(value.toString());
              }
            });
          }
          if (c.uuid.toString() == rxUUID) {
            print('rx');
            rxCharacteristic = c;
          }
        }
      },
    );
  }

  void disconnectDevice() {
    if (_device != null) {
      _device.disconnect();
      _device = null;
    }
    notifyListeners();
  }

  void sendMessage(Message message) async {
    List<int> encoded = new List<int>.from(encodeMessage(message.message));
    encoded.insert(0, 33);
    int checksum = getChecksum(encoded);
    txCharacteristic.write([...encoded, checksum]);
  }
}
