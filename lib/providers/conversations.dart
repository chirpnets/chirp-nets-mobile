import 'package:chirp_nets/models/conversation.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/utils/database.dart';

class Conversations with ChangeNotifier {
  Conversations() {
    init();
  }

  Map<int, Conversation> _conversations = {};

  Map<int, Conversation> get conversations {
    return {..._conversations};
  }

  void init() async {
    List<Conversation> conversations = await getConversations();
    for (Conversation conversation in conversations) {
      _conversations.putIfAbsent(
        conversation.id,
        () => conversation,
      );
    }
    notifyListeners();
  }

  set conversations(Map<int, Conversation> conversations) {
    _conversations = conversations;
    notifyListeners();
  }

  void deleteConversation(int id) {
    _conversations.removeWhere((convId, conversation) => id == convId);
    delete(table:'conversations', id: id);
    notifyListeners();
  }

  void addConversation(int id, int userId, String name) {
    _conversations.putIfAbsent(
      id,
      () => Conversation(
        id: id,
        userId: userId,
        name: name,
      ),
    );
    notifyListeners();
  }
}
