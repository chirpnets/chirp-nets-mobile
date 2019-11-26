import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/screens/settings_screen.dart';
import 'package:chirp_nets/widgets/conversations/add_conversation_widget.dart';
import 'package:chirp_nets/widgets/conversations/conversations_list_widget.dart';
import 'package:chirp_nets/widgets/users/add_first_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';

class ConversationsScreen extends StatelessWidget {
  // Wait until page is loaded and check if a user exits
  // If no user exists prompt the user to create
  void getBottomSheet(userData, context, conversationData) {
    User user = userData.getCurrentUser();
    if (user == null) {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => AddFirstUserWidget(
          userData: userData,
          conversationData: conversationData,
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => AddConversationWidget(
          conversationData: conversationData,
          user: user,
        ),
      );
    }
  }

  final bool addUser;
  ConversationsScreen({this.addUser});

  @override
  Widget build(BuildContext context) {
    final Conversations conversationData = Provider.of<Conversations>(context);
    Map<int, Conversation> conversations = conversationData.conversations;
    Users userData = Provider.of<Users>(context);
    User currentUser = userData.getCurrentUser();
    return Scaffold(
      appBar: AppBar(title: Text('Conversations'), actions: [
        FlatButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(SettingsScreen.routeName),
          child: Icon(
            Icons.settings,
          ),
        ),
      ]),
      body: Center(
        child: ConversationsListWidget(
          currentUser: currentUser,
          conversations: conversations,
          conversationData: conversationData,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        tooltip: 'Add Conversation',
        onPressed: () => getBottomSheet(userData, context, conversationData),
      ),
    );
  }
}
