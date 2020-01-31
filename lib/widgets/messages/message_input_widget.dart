import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/bluetooth.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/utils/text.dart';
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
    Messages messageProvider,
    Bluetooth bluetooth,
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
    messageProvider.addMessage(
      messageObject.sentBy,
      messageObject.conversationId,
      messageObject.message,
      messageObject.createdAt,
    );
    bluetooth.sendMessage(messageObject);
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Messages messageData = Provider.of<Messages>(context);
    final User user = Provider.of<Users>(context).currentUser;
    final Bluetooth bluetooth = Provider.of<Bluetooth>(context);
    return Container(
      height: 60,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(30),
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
              padding: EdgeInsets.only(bottom: 3, top: 5),
              child: TextField(
                maxLengthEnforced: true,
                maxLength: 120,
                maxLines: null,
                style: Theme.of(context).textTheme.body1,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration.collapsed(
                  hintStyle: Theme.of(context).textTheme.body1,
                  hasFloatingPlaceholder: true,
                  hintText: messagePrompt,
                ),
                onSubmitted: (String message) => sendMessage(
                  message,
                  conversation.id,
                  user,
                  messageData,
                  bluetooth,
                ),
                controller: textController,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.send,
                ),
                color: Colors.grey,
                onPressed: () => sendMessage(
                  textController.text,
                  conversation.id,
                  user,
                  messageData,
                  bluetooth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
