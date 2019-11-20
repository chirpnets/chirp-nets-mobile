import 'package:chirp_nets/widgets/bluetooth/device_widget.dart';
import 'package:flutter/material.dart';

class DevicesListWidget extends StatelessWidget {
  const DevicesListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        children: [
          DeviceWidget(),
        ],
      ),
    );
  }
}
