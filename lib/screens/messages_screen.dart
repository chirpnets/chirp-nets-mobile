import 'package:chirp_nets/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/utils/database.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/widgets/message_widget.dart';
import 'package:chirp_nets/providers/messages.dart';

class MessagesScreen extends StatelessWidget {
  static const routeName = '/messages';

  final textController = TextEditingController();

  void sendMessage(
      String message, int conversationId, User user, Messages provider) async {
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
    create(table: 'messages', object: messageObject)
        .then((id) => provider.addMessage(
              id,
              messageObject.createdBy,
              messageObject.conversationId,
              messageObject.message,
              messageObject.createdAt,
            ));

    textController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Conversation conversation = routeArgs['conversation'];
    Messages messageData = Provider.of<Messages>(context);
    messageData.getMessagesFromConversation(conversationId: conversation.id);
    Map<int, Message> messages = messageData.messages;
    User user = Provider.of<Users>(context).getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, int index) {
                var keys = messages.keys.toList();
                return MessageWidget(
                    message: messages[keys[index]], user: user);
              },
            ),
          ),
          Container(
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
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      hintText: 'Say something nice...',
                    ),
                    onSubmitted: (String message) => sendMessage(
                        message, conversation.id, user, messageData),
                    controller: textController,
                  ),
                ),
                Container(
                  child: FlatButton(
                    color: Theme.of(context).accentColor,
                    child: Icon(
                      Icons.send,
                    ),
                    onPressed: () => sendMessage(textController.text,
                        conversation.id, user, messageData),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
