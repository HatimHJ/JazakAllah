import 'package:JazakAllah/data/utility/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LinkProvider with ChangeNotifier {
  String liveLink = "";

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(Urls.liveLink), // replace with your actual API endpoint
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Assuming 'live_link' is the key you want to extract
      liveLink = data['live_link'];

      print("*****************Successsss");
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
