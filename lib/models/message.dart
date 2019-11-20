import 'package:chirp_nets/models/model.dart';

class Message implements Model {
  final int id;
  final int createdBy;
  final int conversationId;
  final String message;
  final DateTime createdAt;

  Message(
      {this.id,
      this.message,
      this.conversationId,
      this.createdAt,
      this.createdBy});

  @override
  Map<String, dynamic> toMap() {
    return {
      'createdBy': createdBy,
      'conversationId': conversationId,
      'message': message,
      'createdAt': createdAt.toString(),
    };
  }
}
