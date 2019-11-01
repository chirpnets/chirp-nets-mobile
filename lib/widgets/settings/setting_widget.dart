import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  final String title;

  SettingWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListTile(
          ),
        ),
      ),
    );
  }
}
