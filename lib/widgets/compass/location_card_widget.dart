import 'package:chirp_nets/models/user.dart';
import 'package:flutter/material.dart';

class LocationCardWidget extends StatelessWidget {
  final User currentUser;
  const LocationCardWidget({this.currentUser});

  @override
  Widget build(BuildContext context) {
    String latitude = currentUser != null ? currentUser.latitude : null;
    String longitude = currentUser != null ? currentUser.longitude : null;
    String text = 'Your Location:\nlat: $latitude, lng: $longitude';
    if (latitude == null || longitude == null) {
      text = 'Location could not be found';
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      ),
    );
  }
}
