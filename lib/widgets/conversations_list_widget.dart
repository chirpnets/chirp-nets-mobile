import 'package:flutter/material.dart';

import 'package:chirp_nets/widgets/converstaion_widget.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';

class ConversationsListWidget extends StatelessWidget {
  final Map<int, Conversation> conversations;
  final User currentUser;
  ConversationsListWidget({this.conversations, this.currentUser});
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
                  ),
                )
                .toList(),
          ],
        ),
    );
  }
}
