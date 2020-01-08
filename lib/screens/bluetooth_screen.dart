import 'package:chirp_nets/providers/bluetooth.dart';
import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/widgets/bluetooth/devices_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BluetoothScreen extends StatefulWidget {
  static const String routeName = '/bluetooth';

  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  Bluetooth bluetooth;
  @override
  void initState() {
    super.initState();
    Bluetooth bluetooth = Bluetooth();
    bluetooth.findDevices().then((res) {
      bluetooth.connectToDevice();
      Fluttertoast.showToast(
          msg: deviceConnectingMessage);
    });

    setState(() {
      this.bluetooth = bluetooth;
    });
  }

  @override
  void dispose() {
    super.dispose();
    bluetooth.cancelScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          bluetoothTitle,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 10,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    deviceTitle,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ],
              ),
            ),
            DevicesListWidget(),
          ],
        ),
      ),
    );
  }
}
