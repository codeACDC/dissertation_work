
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataLoader {
  final String url;
  const DataLoader(this.url);
  Future<dynamic> jsonDataLoader() async{
    http.Response response;
    response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      debugPrint('Error bad load!');
      return {};
    }
  }
}