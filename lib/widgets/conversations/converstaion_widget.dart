import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/widgets/common/delete_alert_dialog.dart';
import 'package:chirp_nets/widgets/conversations/conversation_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:chirp_nets/widgets/conversations/add_conversation_widget.dart';
import 'package:provider/provider.dart';

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
    Messages messageProvider = Provider.of<Messages>(context);
    var message = messageProvider.lastMessages[conversation.id];
    if (message == null) {
      messageProvider.getLastMessageFromConversation(conversation.id);
    }
    return Slidable(
      actionExtentRatio: 0.15,
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          iconWidget: Icon(
            Icons.delete,
            color: Theme.of(context).iconTheme.color,
          ),
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
            useRootNavigator: true,
            context: context,
            isScrollControlled: true,
            builder: (ctx) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(Scaffold.of(context).context)
                      .viewInsets
                      .bottom,
                ),
                child: AddConversationWidget(
                  conversationData: conversations,
                  user: user,
                  conversation: conversation,
                ),
              ),
            ),
          ),
        ),
      ],
      child: GestureDetector(
        onTap: () => viewMessages(context),
        child: ConversationDetailsWidget(
          conversation: conversation,
          message: message,
        ),
      ),
    );
  }
}
