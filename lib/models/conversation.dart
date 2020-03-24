import './model.dart';

class Conversation implements Model {
  final int id;
  final int userId;
  final String name;
  final int networkId;

  Conversation({
    this.id,
    this.userId,
    this.name,
    this.networkId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'networkId': networkId,
    };
  }
}
