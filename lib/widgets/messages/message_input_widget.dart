import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageInputWidget extends StatelessWidget {
  final Conversation conversation;
  final Messages messageData;
  final User user;
  final textController;

  MessageInputWidget({
    this.conversation,
    this.user,
    this.messageData,
    this.textController,
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
      sentBy: user.id,
    );
    provider.addMessage(
      messageObject.sentBy,
      messageObject.conversationId,
      messageObject.message,
      messageObject.createdAt,
    );

    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Messages messageData = Provider.of<Messages>(context);
    final User user = Provider.of<Users>(context).currentUser;
    return Container(
      height: 60,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 3.0),
              blurRadius: 5.0,
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(5),
              child: TextField(
                style: Theme.of(context).textTheme.body1,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.body1,
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
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5),
              child: FlatButton(
                child: Icon(
                  Icons.send,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () => sendMessage(
                  textController.text,
                  conversation.id,
                  user,
                  messageData,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
