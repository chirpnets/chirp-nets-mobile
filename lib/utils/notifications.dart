import 'package:chirp_nets/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

Future<dynamic> onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
  didReceiveLocalNotificationSubject.add(
      ReceivedNotification(id: id, title: title, body: body, payload: payload));
}

Future<dynamic> onSelectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
  selectNotificationSubject.add(payload);
}

setupNotifications() {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

Future<void> showNotification(id, title, body, payload) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      id, title, body, platformChannelSpecifics,
      payload: payload);
}
