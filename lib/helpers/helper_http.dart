import 'dart:convert';

import 'package:http/http.dart';

class HttpHelper {
  static const _BASE_API = 'http://behakh.pythonanywhere.com/api/v1/';
  static var _client = Client();

  static Future<bool> testConnection() async {
    try {
      var response = await _client.get(_BASE_API + 'test/');
      return jsonDecode(response.body)['status'];
    } catch (e) {
      return false;
    }
  }
}
