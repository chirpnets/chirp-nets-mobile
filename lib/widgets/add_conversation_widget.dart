import 'package:flutter/material.dart';

import 'package:chirp_nets/utils/database.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';

class AddConversationWidget extends StatelessWidget {
  final Conversations conversationData;
  final User user;
  final textController = TextEditingController();
  final Conversation conversation;

  AddConversationWidget({this.conversationData, this.user, this.conversation});

  void addConversation(Conversations conversationData, User user, String name, ctx) {
    if (name.isEmpty) {
      return;
    }
    if (conversation != null) {
      conversationData.updateConversation(conversation.id, name);
    } else{
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
    }
    textController.clear();
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    if (conversation != null) {
      textController.text = conversation.name;
      textController.selection = TextSelection(baseOffset: 0, extentOffset: conversation.name.length);
    }
    return Container(
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.words,
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: RaisedButton(
                  onPressed: () => addConversation(
                    conversationData,
                    user,
                    textController.text,
                    context
                  ),
                  color: Theme.of(context).canvasColor,
                  child: Icon(
                    Icons.add_comment,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
