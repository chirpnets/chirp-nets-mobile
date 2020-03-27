import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/utils/notifications.dart';
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
  Messages messageProvider;
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
      _flutterBlue.startScan(timeout: Duration(seconds: 30));
      isScanning = true;
    }

    print('finding devices');

    scanSubscription = _flutterBlue.scanResults.listen((scanResults) {
      for (var device in scanResults) {
        if (device.device.name == deviceName && _device == null) {
          print('Device found');
          _device = device.device;
          _device.connect(autoConnect: true).then((_) {
            _device.state.listen((state) {
              if (state == BluetoothDeviceState.disconnected) {
                _device = null;
                showNotification(3, deviceDisconnectedMessage, deviceDisconnectedNotification, deviceDisconnectedNotification);
                notifyListeners();
              }
            });
            Fluttertoast.showToast(msg: deviceConnectedMessage);
            discoverServices();
          });
          notifyListeners();
        }
        if (_device != null) {
          isScanning = false;
          break;
        }
      }
    });
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
            txCharacteristic = c;
          }
          if (c.uuid.toString() == rxUUID) {
            print("receiving");
            rxCharacteristic = c;
            rxCharacteristic.setNotifyValue(true);
            rxCharacteristic.value.listen((value) {
              if (value.length > 0) {
                messageProvider.recieveMessage(value);
              }
            });
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

  bool sendMessage(Message message, Conversation conversation, User user) {
    if (txCharacteristic == null) {
      Fluttertoast.showToast(
        msg: errorSendingMessageText,
      );
      return false;
    }
    List<int> packet = buildPacket(conversation.networkId, user.nodeId, 1, message: message.message);
    txCharacteristic.write([...packet]);
    return true;
  }
}
