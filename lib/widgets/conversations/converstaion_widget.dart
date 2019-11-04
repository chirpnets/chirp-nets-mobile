import 'package:chirp_nets/widgets/common/delete_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:chirp_nets/widgets/conversations/add_conversation_widget.dart';

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
          color: Theme.of(context).errorColor,
          onTap: () => showDialog(
            context: context,
            builder: (ctx) => DeleteAlertDialog(
              onDelete: deleteConversation,
              id: conversation.id,
            ),
          ),
        ),
        IconSlideAction(
          icon: Icons.edit,
          color: Theme.of(context).buttonColor,
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (ctx) => AddConversationWidget(
              conversationData: conversations,
              user: user,
              conversation: conversation,
            ),
          ),
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).accentColor,
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
