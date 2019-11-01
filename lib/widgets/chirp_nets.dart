import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/screens/conversations_screen.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:chirp_nets/utils/database.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/conversations.dart';

class ChirpNets extends StatefulWidget {
  @override
  _ChirpNetsState createState() => _ChirpNetsState();
}

class _ChirpNetsState extends State<ChirpNets> {
  User currentUser;

  void setUp() async {
    List<User> users = await getUsers();
    setState(() {
      this.currentUser = users.firstWhere((user) => user.id == 1, orElse: () => null);
    });
  }

  void closeDatabase() async {
    close();
  }

  @override
  void initState() {
    super.initState();
    setUp();
  }

  @override
  void dispose() {
    closeDatabase();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chirp Nets',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.orangeAccent,
        canvasColor: Color.fromRGBO(20, 51, 51, 1),
        buttonColor: Colors.teal,
        errorColor: Colors.red,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Conversations(),
          ),
          ChangeNotifierProvider.value(
            value: Users(),
          ),
          ChangeNotifierProvider.value(
            value: Messages(),
          ),
        ],
        child: ConversationsScreen(
          addUser: currentUser == null,
        ),
      ),
      routes: {
        MessagesScreen.routeName: (ctx) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: Users(),
                ),
                ChangeNotifierProvider.value(
                  value: Messages(),
                ),
              ],
              child: MessagesScreen(),
            ),
        SettingsScreen.routeName: (ctx) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: Users(),
                ),
              ],
              child: SettingsScreen(),
            )
      },
    );
  }
}
