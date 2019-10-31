import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:flutter/material.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({this.conversation, this.user});

  final Conversation conversation;
  final User user;

  void viewMessages(ctx) async {
    Navigator.of(ctx).pushNamed(
      MessagesScreen.routeName,
      arguments: {
        'user': user,
        'conversation': conversation,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => viewMessages(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).accentColor.withOpacity(0.7),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(25),
        child: Text(conversation.name),
      ),
    );
  }
}
