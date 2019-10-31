import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:chirp_nets/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({this.conversation, this.user, this.conversations});

  final Conversation conversation;
  final Conversations conversations;
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

  void deleteConversation(id) {
    conversations.deleteConversation(id);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: 0.15,
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.red,
          onTap: () => deleteConversation(conversation.id),
        )
      ],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: ListTile(
          onTap: () => viewMessages(context),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).canvasColor,
            child: Icon(
              Icons.person,
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(conversation.name),
        ),
      ),
    );
  }
}
