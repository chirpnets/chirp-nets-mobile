import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:chirp_nets/widgets/conversations/add_conversation_widget.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/widgets/conversations/conversation_widget.dart';
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

  void viewMessages(ctx, conversation) {
    Navigator.of(ctx).pushNamed(
      MessagesScreen.routeName,
      arguments: {
        'user': currentUser,
        'conversation': conversation,
      },
    );
  }

  void modifyConversation(ctx, conversation, provider) {
    showBottomSheet(
      context: ctx,
      builder: (context) {
        return AddConversationWidget(
          conversation: conversation,
          conversationData: provider,
          user: currentUser,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> conversationList = conversations.values
        .map(
          (conversation) => GestureDetector(
            onLongPress: () =>
                modifyConversation(context, conversation, conversationData),
            onTap: () => viewMessages(context, conversation),
            child: ConversationWidget(
              conversation: conversation,
              user: currentUser,
              conversations: conversationData,
            ),
          ),
        )
        .toList();
    return ListView(
      children: conversationList,
    );
  }
}
