import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/screens/conversations_screen.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/device.dart';
import 'package:chirp_nets/utils/database.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/conversations.dart';

class ChirpNets extends StatefulWidget {
  @override
  _ChirpNetsState createState() => _ChirpNetsState();
}

class _ChirpNetsState extends State<ChirpNets> {
  List<User> users;
  List<Conversation> conversations = [];
  List<Device> devices;
  User currentUser;

  void setUp() async {
    List<User> users = await getUsers();
    if (users.length == 0) {
      User user = User(name: 'Tim');
      await create(table: 'users', object: user).then((id) => {
        user = User(id: id, name: 'Tim')
      });
      users = await getUsers();
    }

    List<Conversation> conversations = await getConversations();
    List<Device> devices = await getDevices();

    setState(() {
      this.currentUser = users[0];
      this.users = users;
      this.conversations = conversations;
      this.devices = devices;
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
        child: ConversationsScreen(),
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
      },
    );
  }
}
