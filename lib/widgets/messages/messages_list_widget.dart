import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/widgets/messages/message_widget.dart';
import 'package:chirp_nets/models/user.dart';

class MessagesListWidget extends StatelessWidget {
  MessagesListWidget({
    Key key,
    this.scrollController,
    this.messageData,
    this.user,
    this.conversation,
  });
  final Conversation conversation;
  final ScrollController scrollController;
  final Messages messageData;
  final User user;

  @override
  Widget build(BuildContext context) {
    messageData.getMessagesFromConversation(conversationId: conversation.id);

    List<Message> messages = messageData.getList();
    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: scrollController,
        itemCount: messages.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext ctx, int index) {
          return MessageWidget(message: messages[index], user: user);
        },
      ),
    );
  }
}
