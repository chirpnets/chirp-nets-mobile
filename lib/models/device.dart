import 'package:chirp_nets/models/model.dart';

class Device implements Model {
  final int id;
  final int userId;
  String deviceRSSI = '';
  final String name;

  Device({
    this.id,
    this.userId,
    this.deviceRSSI,
    this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'deviceRSSI': deviceRSSI,
      'name': name,
    };
  }
}
