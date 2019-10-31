import 'package:chirp_nets/providers/conversations.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/widgets/converstaion_widget.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';

class ConversationsListWidget extends StatelessWidget {
  final Map<int, Conversation> conversations;
  final Conversations conversationData;
  final User currentUser;
  ConversationsListWidget({this.conversations, this.currentUser, this.conversationData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: [
            ...conversations.values
                .map(
                  (conversation) => ConversationWidget(
                    conversation: conversation,
                    user: currentUser,
                    conversations: conversationData,
                  ),
                )
                .toList(),
          ],
        ),
    );
  }
}
