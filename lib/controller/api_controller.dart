import 'package:flutter/cupertino.dart';
import 'package:machine_test/services/notification_api.dart';

class ApiController extends ChangeNotifier {
  ApiController._internal();
  static final ApiController instance = ApiController._internal();
  factory ApiController() {
    return instance;
  }
  Future? carousalData;
  Future? gridData;
  NotificationApi notificationApi = NotificationApi.instance;

  setApiData({Future? carousal, Future? grid}) {
    carousalData = carousal;
    gridData = grid;
    notifyListeners();
  }
}
