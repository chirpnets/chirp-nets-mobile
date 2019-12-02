import 'package:chirp_nets/models/model.dart';

class User implements Model {
  final int id;
  final String name;
  final bool isCurrentUser;

  User({
    this.id,
    this.name,
    this.isCurrentUser = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isCurrentUser': isCurrentUser ? 1 : 0,
    };
  }
}
