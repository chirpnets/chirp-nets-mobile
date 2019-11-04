import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  final Widget child;
  final options;
  SettingWidget({this.child, this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 70,
          margin: EdgeInsets.all(10),
          child: child,
        ),
      ),
    );
  }
}
