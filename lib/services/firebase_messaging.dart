import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:machine_test/components/constant.dart';
import 'package:machine_test/controller/api_controller.dart';
import 'package:machine_test/models/notification_model.dart';
import 'package:machine_test/services/fetch.dart';
import 'package:machine_test/services/notification_api.dart';

class FirebaseMessagingProvider extends ChangeNotifier {
  late final FirebaseMessaging? _messaging;
  NotificationModel? _notificationModel;
  NotificationApi notificationApi = NotificationApi.instance;
  ApiService apiService = ApiService.instance;
  ApiController apiController = ApiController.instance;

  void initPushNotification() async {
    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging!.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _notificationModel = NotificationModel(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );
        if (_notificationModel?.title == kImageUpdate) {
          notificationApi.showNotification(
            title: _notificationModel?.title,
            body: _notificationModel?.body,
          );
          apiController.setApiData(
              carousal: apiService.getImagesFromApi(count: "5"),
              grid: apiService.getImagesFromApi(count: "30"));
        }
      });
    } else {
      debugPrint("Notification Permission Denied");
    }
  }
}
