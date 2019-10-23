import './model.dart';

class Message implements Model {
  final int id;
  final String message;
  final DateTime createdAt;
  final int conversationId;

  Message({this.id, this.message, this.conversationId, this.createdAt});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'conversationId': conversationId,
      'createdAt': createdAt,
    };
  }
}
