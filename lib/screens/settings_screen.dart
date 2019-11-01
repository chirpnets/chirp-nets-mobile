import 'package:chirp_nets/widgets/settings/setting_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SettingWidget(title: 'titke'),
          SettingWidget(title: 'setting'),
          SettingWidget(title: 'user'),
        ],
      ),
    );
  }
}
