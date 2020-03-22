import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/widgets/common/delete_alert_dialog.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';

class AddConversationWidget extends StatelessWidget {
  final Conversations conversationData;
  final User user;
  final textController = TextEditingController();
  final Conversation conversation;

  AddConversationWidget({this.conversationData, this.user, this.conversation});

  void addConversation(
      Conversations conversationData, User user, String name, ctx) {
    if (name.isEmpty) {
      return;
    }
    if (conversation != null) {
      conversationData.updateConversation(
        conversation.id,
        name,
      );
    } else {
      Conversation conv = Conversation(
        userId: user.id,
        name: name,
      );
      conversationData.addConversation(
        conv.userId,
        conv.name,
      );
    }
    textController.clear();
    Navigator.pop(ctx);
  }

  void deleteConversation(conversation, provider, ctx) {
    showDialog(
      context: ctx,
      child: DeleteAlertDialog(
        title:
            'Are you sure?\nThis will delete all messages associated with this conversation',
        id: conversation.id,
        onDelete: conversationData.deleteConversation,
      ),
    ).then((_) {
      Navigator.of(ctx).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (conversation != null) {
      textController.text = conversation.name;
      textController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: conversation.name.length,
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height/3.5,
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                style: Theme.of(context).textTheme.body1,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.body1,
                  hasFloatingPlaceholder: true,
                  hintText: groupPrompt,
                ),
                onSubmitted: (String message) => addConversation(
                  conversationData,
                  user,
                  message,
                  context,
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
                    context,
                  ),
                  color: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.add_comment,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ),
              if (conversation != null)
                Container(
                  child: RaisedButton(
                    child: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => this.deleteConversation(
                        conversation, conversationData, context),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
