import 'package:chirp_nets/models/model.dart';

class Contact implements Model {
  final int id;
  final int conversationId;
  final int userId;
  final String name;
  
  Contact({
    this.id,
    this.conversationId,
    this.userId,
    this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'conversationId': conversationId,
      'userId': userId,
      'name': name,
    };
  }
}
