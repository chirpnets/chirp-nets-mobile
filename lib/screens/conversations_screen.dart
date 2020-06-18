import 'package:chirp_nets/providers/bluetooth.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/screens/settings_screen.dart';
import 'package:chirp_nets/utils/location_service.dart';
import 'package:chirp_nets/utils/notifications.dart';
import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/widgets/conversations/add_conversation_widget.dart';
import 'package:chirp_nets/widgets/conversations/conversations_list_widget.dart';
import 'package:chirp_nets/widgets/users/add_nodeId_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';

class ConversationsScreen extends StatefulWidget {
  ConversationsScreen();

  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  Users userData;
  LocationService service;
  TextEditingController _textFieldController = TextEditingController();


  @override
  void initState() {
    super.initState();
    setupNotifications();
  }

  openSetUserInfoDialog(BuildContext context, User user) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SetUserInfoWidget(user:user, userData: userData),
          );
        });
  }


  void getBottomSheet(context, conversationData, bluetooth) async {
    User user = userData.currentUser;
    if (user.name == '') {
      await openSetUserInfoDialog(context, user);
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddConversationWidget(
            conversationData: conversationData,
            user: user,
            bluetooth: bluetooth,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Bluetooth bluetooth = Provider.of<Bluetooth>(context);
    userData = Provider.of<Users>(context);
    if (service == null) {
      service = LocationService(userData);
    }
    User user = userData.currentUser;
    final Conversations conversationData = Provider.of<Conversations>(context);
    if (bluetooth.conversation == null) {
      var convs = conversationData.conversations.values.toList();
      bluetooth.conversation = convs.length > 0 ? convs[0] : null;
    }
    Map<int, Conversation> conversations = conversationData.conversations;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          conversationsTitle,
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          FlatButton(
            onPressed: () {
              Fluttertoast.showToast(msg: deviceConnectingMessage);
              bluetooth.findDevices();
            },
            child: Icon(
              bluetooth.device != null
                  ? Icons.bluetooth_connected
                  : Icons.bluetooth_searching,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          FlatButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName),
            child: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Center(
        child: ConversationsListWidget(
          currentUser: user,
          conversations: conversations,
          conversationData: conversationData,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).highlightColor,
        ),
        tooltip: 'Add Conversation',
        onPressed: () => getBottomSheet(context, conversationData, bluetooth),
      ),
    );
  }
}
