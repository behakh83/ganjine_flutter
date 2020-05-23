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

  static Future<dynamic> collectionsCount() async {
    try {
      var response = await _client.get(_BASE_API + 'collections-count/');
      return jsonDecode(response.body);
    } catch (e) {
      throw ('');
    }
  }

  static Future<dynamic> collectionList(int grade) async {
    try {
      var response = await _client.get(_BASE_API + 'collections/?grade=$grade');
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw ('');
    }
  }

  static Future<dynamic> collection(int id) async {
    try {
      var response = await _client.get(_BASE_API + 'collections/$id/');
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw ('');
    }
  }
}
