import 'package:chirp_nets/models/message.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/utils/database.dart';

class Messages with ChangeNotifier {
  Map<int, Message> _messages = {};
  int _conversationId;
  Map<int, Message> _lastMessages = {};

  Map<int, Message> get messages {
    return {..._messages};
  }

  int get conversationId {
    return _conversationId;
  }

  Map<int, Message> get lastMessages {
    return _lastMessages;
  }

  void getMessagesFromConversation({int conversationId}) async {
    List<Message> messages;
    messages = await getMessages(
        where: 'conversationId = ?', whereArgs: [conversationId]);
    _conversationId = conversationId;
    _messages = {for (var message in messages) message.id: message};
    notifyListeners();
  }

  List<int> getUserIds() {
    List<int> ids = [];
    _messages.forEach((id, message) {
      if (!ids.contains(message.sentBy)) {
        ids.add(message.sentBy);
      }
    });
    return ids;
  }

  Future<int> addMessage(int sentBy, int conversationId, String message,
      DateTime createdAt) async {
    Message newMessage = Message(
      sentBy: sentBy,
      conversationId: conversationId,
      message: message,
      createdAt: createdAt,
    );
    int id = await create(table: 'messages', object: newMessage);
    _lastMessages[conversationId] = newMessage;
    _messages.putIfAbsent(
      id,
      () => Message(
        id: id,
        sentBy: sentBy,
        conversationId: conversationId,
        message: message,
        createdAt: createdAt,
      ),
    );
    notifyListeners();
    return id;
  }

  List<Message> getList() {
    List<Message> messages = [];
    messages = {for (var id in _messages.keys) _messages[id]}.toList();
    messages.sort((a, b) => -a.createdAt.compareTo(b.createdAt));
    return messages;
  }

  void deleteMessage(id) {
    _messages.remove(id);
    delete(table: 'messages', id: id);
    notifyListeners();
  }

  void getLastMessageFromConversation(int conversationId) async {
    List<Message> message = await getMessages(
            where: 'conversationId = ?', whereArgs: [conversationId], limit: 10)
        .then((m) => m);
    var lastMessage = message.isEmpty ? Message() : message[0];
    _lastMessages.putIfAbsent(conversationId, () => lastMessage);
    notifyListeners();
  }
}
