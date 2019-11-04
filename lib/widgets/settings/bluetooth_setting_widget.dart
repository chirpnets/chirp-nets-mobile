import 'package:chirp_nets/screens/bluetooth_screen.dart';
import 'package:flutter/material.dart';

class BluetoothSettingWidget extends StatelessWidget {
  final bool connected;
  const BluetoothSettingWidget({this.connected});

  void redirectToBluetoothScreen(ctx) {
    Navigator.of(ctx).pushNamed(BluetoothScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    IconData icon =
        connected ? Icons.bluetooth_connected : Icons.bluetooth_disabled;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text('Bluetooth Settings'),
        ),
        Icon(
          icon,
        ),
        RaisedButton(
          color: Theme.of(context).canvasColor,
          child: Icon(
            Icons.bluetooth,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => redirectToBluetoothScreen(context),
        ),
      ],
    );
  }
}
