import 'package:chirp_nets/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {

  LocationService(Users userData) {
    location.onLocationChanged().listen((currentLocation) {
      updateLocation(currentLocation, userData);
    });
  }

  var location = Location();

  updateLocation(LocationData currentLocation, Users userData) async {
    try {
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        var error = 'User denied location permissions';
        debugPrint(error);
      }
      currentLocation = null;
    }
    if (currentLocation != null && userData != null) {
      if (userData.currentUser != null) {
        userData.updateLocation(
          id: userData.currentUser.id,
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        );
      }
    }
  }
}
