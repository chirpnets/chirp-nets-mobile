
import 'package:mobile/models/model.dart';

class Device implements Model {
  final int id;
  final int userId;
  final String deviceRSSI;

  Device({
    this.id,
    this.userId,
    this.deviceRSSI,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'deviceRSSI': deviceRSSI,
    };
  }
}
