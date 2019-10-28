import './model.dart';

class Contact implements Model {
  final int id;
  final int conversationId;
  final String name;
  
  Contact({
    this.id,
    this.conversationId,
    this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationId': conversationId,
      'name': name,
    };
  }
}
