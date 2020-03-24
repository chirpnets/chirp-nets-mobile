import 'package:chirp_nets/models/model.dart';

class User implements Model {
  final int id;
  final String name;
  final int nodeId;
  final bool isCurrentUser;
  final String longitude;
  final String latitude;
  int colourIndex;

  User({
    this.id,
    this.name,
    this.nodeId,
    this.isCurrentUser = false,
    this.longitude,
    this.latitude,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nodeId': nodeId,
      'isCurrentUser': isCurrentUser ? 1 : 0,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
