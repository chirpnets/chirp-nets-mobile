import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/widgets/conversations/conversation_details_widget.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';
import 'package:provider/provider.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({this.conversation, this.user, this.conversations});

  final Conversation conversation;
  final Conversations conversations;
  final User user;

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
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: ConversationDetailsWidget(
        conversation: conversation,
        message: message,
      ),
    );
  }
}
