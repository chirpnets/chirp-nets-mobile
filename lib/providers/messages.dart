import 'package:chirp_nets/models/message.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/utils/database.dart';

class Messages with ChangeNotifier {
  Messages() {
    getMessagesFromConversation();
  }

  void getMessagesFromConversation({int conversationId = 0}) async {
    List<Message> messages;
    if (conversationId > 0) {
      messages = await getMessages(
          where: 'conversationId = ?', whereArgs: [conversationId]);
    } else {
      messages = await getMessages();
    }
    _messages = {for (var message in messages) message.id: message};
    notifyListeners();
  }

  Map<int, Message> _messages = {};

  Map<int, Message> get messages {
    return {..._messages};
  }

  void addMessage(int id, int createdBy, int conversationId, String message,
      DateTime createdAt) {
    _messages.putIfAbsent(
      id,
      () => Message(
        id: id,
        createdBy: createdBy,
        conversationId: conversationId,
        message: message,
        createdAt: createdAt,
      ),
    );
    notifyListeners();
  }
}
