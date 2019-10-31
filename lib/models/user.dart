
import 'package:chirp_nets/models/model.dart';

class User implements Model {
  final int id;
  final String name;

  User({
    this.id,
    this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
