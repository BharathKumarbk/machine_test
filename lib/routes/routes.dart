import 'package:machine_test/home.dart';
import 'package:machine_test/view/HomeScreen/home.dart';
import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.route:
      return MaterialPageRoute(builder: (_) => const HomePage());
    default:
      return MaterialPageRoute(builder: (_) => const Home());
  }
}
