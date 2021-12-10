import 'package:machine_test/controller/api_controller.dart';
import 'package:machine_test/services/fetch.dart';
import 'package:machine_test/services/firebase_messaging.dart';
import 'package:machine_test/services/notification_api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
];
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<ApiService>(
    create: (_) => ApiService(),
  ),
  ChangeNotifierProvider<ApiController>(
    create: (_) => ApiController(),
  ),
  ChangeNotifierProvider<NotificationApi>(
    create: (_) => NotificationApi(),
  ),
  ChangeNotifierProvider<FirebaseMessagingProvider>(
    create: (_) => FirebaseMessagingProvider(),
  ),
];
