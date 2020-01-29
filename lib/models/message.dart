import 'package:chirp_nets/models/model.dart';

class Message implements Model {
  final int id;
  final int sentBy;
  final int conversationId;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  Message({
    this.id,
    this.message,
    this.conversationId,
    this.createdAt,
    this.sentBy,
    this.isRead = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'sentBy': sentBy,
      'conversationId': conversationId,
      'message': message,
      'createdAt': createdAt.toString(),
      'isRead': isRead,
    };
  }
}
