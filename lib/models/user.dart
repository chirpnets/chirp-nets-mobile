import 'package:chirp_nets/models/model.dart';

class User implements Model {
  final int id;
  final String name;
  final bool isCurrentUser;
  final String longitude;
  final String latitude;
  int colourIndex;

  User({
    this.id,
    this.name,
    this.isCurrentUser = false,
    this.longitude,
    this.latitude,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isCurrentUser': isCurrentUser ? 1 : 0,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
