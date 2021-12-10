import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/services/notification_api.dart';

class ApiService extends ChangeNotifier {
  NotificationApi notificationApi = NotificationApi.instance;
  ApiService._internal();
  static final ApiService instance = ApiService._internal();
  factory ApiService() {
    return instance;
  }

  Future<List<String>>? getImagesFromApi({String? count}) async {
    List<String> imagesList = [];
    String? url =
        "https://shibe.online/api/shibes?count=$count&urls=true&httpsUrls=true";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        imagesList = List.from(data);
        Fluttertoast.showToast(msg: "New Images Updated");
        
      }
      return imagesList;
    } catch (e) {
      throw Exception("Error Fetching Data");
    }
  }
}
