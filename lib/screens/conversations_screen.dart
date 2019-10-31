import 'dart:math';

import 'package:chirp_nets/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/widgets/converstaion_widget.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/utils/database.dart';

class ConversationsScreen extends StatelessWidget {
  void addConversation(Conversations conversationData, User user) {
    Conversation conv = Conversation(
      userId: user.id,
      name: Random().nextInt(100).toString(),
    );
    create(
      table: 'conversations',
      object: conv,
    ).then((id) => conversationData.addConversation(
          id,
          conv.userId,
          conv.name,
        ));
  }

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
        child: Container(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.money_off,
        ),
        onPressed: () => addConversation(conversationData, currentUser),
      ),
    );
  }
}
