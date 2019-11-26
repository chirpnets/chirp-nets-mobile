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
    _conversations.remove(id);
    delete(table: 'conversations', id: id);
    notifyListeners();
  }

  void updateConversation(int id, String name) {
    _conversations.update(
      id,
      (conversation) => Conversation(
        id: conversation.id,
        name: name,
        userId: conversation.userId,
      ),
    );
    update(table: 'conversations', object: _conversations[id]);
    notifyListeners();
  }

  Future<int> addConversation(int userId, String name) async {
    Conversation conversation = Conversation(userId: userId, name: name);
    int id = await create(table: 'conversations', object: conversation);
    _conversations.putIfAbsent(
      id,
      () => Conversation(
        id: id,
        userId: userId,
        name: name,
      ),
    );
    notifyListeners();
    return id;
  }
}
