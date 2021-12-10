import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi extends ChangeNotifier {
  NotificationApi._internal();
  static final NotificationApi instance = NotificationApi._internal();
  factory NotificationApi() {
    return instance;
  }
  static final _notifications = FlutterLocalNotificationsPlugin();

  NotificationDetails get _notificationDetails {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        "image Update",
        channelDescription: "Updating image from notification",
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  Future init() async {
    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings ios = const IOSInitializationSettings();
    InitializationSettings settings =
        InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(settings);
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    return await _notifications.show(id, title, body, _notificationDetails);
  }
}
