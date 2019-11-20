import './model.dart';

class Conversation implements Model {
  final int id;
  final int userId;
  final String name;

  Conversation({
    this.id,
    this.userId,
    this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
    };
  }
}
