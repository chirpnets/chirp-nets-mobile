import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/widgets/settings/setting_widget.dart';
import 'package:chirp_nets/widgets/settings/text_setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  void editUser(name, Users userData, User currentUser, ctx) {
    userData.updateUser(currentUser.id, name);
    Fluttertoast.showToast(
      msg: 'Saved ✓',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Theme.of(ctx).accentColor,
      textColor: Theme.of(ctx).highlightColor,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    Users userData = Provider.of<Users>(context);
    User currentUser = userData.currentUser;
    var name = currentUser == null ? '' : currentUser.name;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          settingsTitle,
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: ListView(
        children: [
          SettingWidget(
            child: TextSettingWidget(
              title: displayNamePrompt,
              value: name,
              provider: userData,
              object: currentUser,
              callback: editUser,
            ),
          ),
        ],
      ),
    );
  }
}
