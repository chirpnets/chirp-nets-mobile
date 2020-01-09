import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/widgets/compass/compass_widget.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/widgets/compass/location_card_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompassScreen extends StatelessWidget {
  static const String routeName = '/compass';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Map<int, User> users = routeArgs['users'];
    final userProvider = Provider.of<Users>(context);
    final List<Map<String, dynamic>> userLocations =
        Users.getUsersLocations(users: users);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          compassTitle,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            LocationCardWidget(
              currentUser: userProvider.currentUser,
            ),
            Center(
              child: CompassWidget(
                currentUser: userProvider.currentUser,
                userLocations: userLocations,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
