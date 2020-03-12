import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/widgets/bluetooth/devices_list_widget.dart';
import 'package:flutter/material.dart';

class BluetoothScreen extends StatelessWidget {
  static const String routeName = '/bluetooth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          bluetoothTitle,
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.transparent,
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
