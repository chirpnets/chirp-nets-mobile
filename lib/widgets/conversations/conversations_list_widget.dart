import 'package:chirp_nets/providers/conversations.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/widgets/conversations/converstaion_widget.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';

class ConversationsListWidget extends StatelessWidget {
  final Map<int, Conversation> conversations;
  final Conversations conversationData;
  final User currentUser;
  ConversationsListWidget({
    this.conversations,
    this.currentUser,
    this.conversationData,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> conversationList = conversations.values
        .map(
          (conversation) => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: ConversationWidget(
              conversation: conversation,
              user: currentUser,
              conversations: conversationData,
            ),
          ),
        )
        .toList();
    conversationList.add(
      Container(
        child: Image.asset('assets/chirp_logo.png'),
      ),
    );
    return ListView(
      children: conversationList,
    );
  }
}
