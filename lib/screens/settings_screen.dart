import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/widgets/settings/bluetooth_setting_widget.dart';
import 'package:chirp_nets/widgets/settings/setting_widget.dart';
import 'package:chirp_nets/widgets/settings/text_setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  void editUser(name, Users userData, User currentUser) {
    userData.updateUser(currentUser.id, name);
    Fluttertoast.showToast(
      msg: 'Saved ✓',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    Users userData = Provider.of<Users>(context);
    User currentUser = userData.getCurrentUser();
    var name = currentUser == null ? '' : currentUser.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SettingWidget(
            child: TextSettingWidget(
              title: 'Display Name',
              value: name,
              provider: userData,
              object: currentUser,
              callback: editUser,
            ),
          ),
          SettingWidget(
            child: BluetoothSettingWidget(
              connected: false,
            ),
          ),
        ],
      ),
    );
  }
}
