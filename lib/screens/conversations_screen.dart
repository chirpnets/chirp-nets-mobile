import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/widgets/add_conversation_widget.dart';
import 'package:chirp_nets/widgets/conversations_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';

class ConversationsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Conversations conversationData = Provider.of<Conversations>(context);
    Map<int, Conversation> conversations = conversationData.conversations;
    final User currentUser = Provider.of<Users>(context).getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: Center(
        child: ConversationsListWidget(
          currentUser: currentUser,
          conversations: conversations,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (ctx) => AddConversationWidget(
            conversationData: conversationData,
            user: currentUser,
          ),
        ),
      ),
    );
  }
}
