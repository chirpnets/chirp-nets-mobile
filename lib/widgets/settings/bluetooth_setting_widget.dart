import 'package:chirp_nets/screens/bluetooth_screen.dart';
import 'package:chirp_nets/utils/text.dart';
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
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            bluetoothSettingsTitle,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        RaisedButton(
          color: Theme.of(context).buttonColor,
          child: Icon(
            Icons.bluetooth,
            color: Theme.of(context).highlightColor,
          ),
          onPressed: () => redirectToBluetoothScreen(context),
        ),
      ],
    );
  }
}
