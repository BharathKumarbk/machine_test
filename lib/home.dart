import 'package:flutter/material.dart';
import 'package:machine_test/providers/provider_service.dart';
import 'package:machine_test/routes/routes.dart';
import 'package:machine_test/services/firebase_messaging.dart';
import 'package:machine_test/services/notification_api.dart';
import 'package:machine_test/view/HomeScreen/home.dart';
import 'package:provider/provider.dart';
import 'components/constant.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Machine Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: kWhite,
              elevation: 0.0,
              titleTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          scaffoldBackgroundColor: kWhite,
        ),
        initialRoute: Home.route,
        onGenerateRoute: routes,
      ),
    );
  }
}

class Home extends StatefulWidget {
  static const String route = "Home";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationApi>().init();
    context.read<FirebaseMessagingProvider>().initPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
