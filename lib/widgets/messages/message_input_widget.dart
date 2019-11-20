import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageInputWidget extends StatelessWidget {
  final Conversation conversation;
  final Messages messageData;
  final User user;
  final textController = TextEditingController();

  MessageInputWidget({
    this.conversation,
    this.user,
    this.messageData,
  });

  void sendMessage(
    String message,
    int conversationId,
    User user,
    Messages provider,
  ) async {
    if (message.isEmpty) {
      return;
    }
    DateTime now = DateTime.now();
    var messageObject = Message(
      message: message,
      createdAt: now,
      conversationId: conversationId,
      createdBy: user.id,
    );
    create(
      table: 'messages',
      object: messageObject,
    ).then((id) => provider.addMessage(
          id,
          messageObject.createdBy,
          messageObject.conversationId,
          messageObject.message,
          messageObject.createdAt,
        ));

    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Messages messageData = Provider.of<Messages>(context);
    final User user = Provider.of<Users>(context).getCurrentUser();

    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hasFloatingPlaceholder: true,
                hintText: 'Say something nice...',
              ),
              onSubmitted: (String message) => sendMessage(
                message,
                conversation.id,
                user,
                messageData,
              ),
              controller: textController,
            ),
          ),
          Container(
            child: FlatButton(
              color: Theme.of(context).accentColor,
              child: Icon(
                Icons.send,
              ),
              onPressed: () => sendMessage(
                textController.text,
                conversation.id,
                user,
                messageData,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
