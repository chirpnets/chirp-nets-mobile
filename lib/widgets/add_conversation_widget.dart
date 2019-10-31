import 'package:flutter/material.dart';

import 'package:chirp_nets/utils/database.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';

class AddConversationWidget extends StatelessWidget {
  final Conversations conversationData;
  final User user;
  final textController = TextEditingController();

  AddConversationWidget({this.conversationData, this.user});

  void addConversation(Conversations conversationData, User user, String name, ctx) {
    if (name.isEmpty) {
      return;
    }
    Conversation conv = Conversation(
      userId: user.id,
      name: name,
    );
    create(
      table: 'conversations',
      object: conv,
    ).then(
      (id) => conversationData.addConversation(
        id,
        conv.userId,
        conv.name,
      ),
    );
    textController.clear();
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hasFloatingPlaceholder: true,
                  hintText: 'Enter Group Name...',
                ),
                onSubmitted: (String message) => addConversation(
                  conversationData,
                  user,
                  message,
                  context
                ),
                controller: textController,
              ),
              RaisedButton(
                onPressed: () => addConversation(
                  conversationData,
                  user,
                  textController.text,
                  context
                ),
                child: Icon(
                  Icons.add_comment
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
