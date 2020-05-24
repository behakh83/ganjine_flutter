import 'dart:convert';

import 'package:http/http.dart';

class NoConnectionException implements Exception {
  String cause;
  NoConnectionException(this.cause);
  @override
  String toString() {
    return this.cause;
  }
}

class GanjineAPI {
  static const _BASE_API = 'http://behakh.pythonanywhere.com/api/v1/';
  static var _client = Client();

  static Future<Map<String, dynamic>> testConnection() async {
    try {
      var response = await _client.get(_BASE_API + 'test/');
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw NoConnectionException(e);
    }
  }

  static Future<dynamic> collectionsCount() async {
    try {
      var response = await _client.get(_BASE_API + 'collections-count/');
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw NoConnectionException(e);
    }
  }

  static Future<dynamic> collectionList(int grade) async {
    try {
      var response = await _client.get(_BASE_API + 'collections/?grade=$grade');
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw NoConnectionException(e);
    }
  }

  static Future<dynamic> collection(int id) async {
    try {
      var response = await _client.get(_BASE_API + 'collections/$id/');
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw NoConnectionException(e);
    }
  }

  static Future<dynamic> aboutUs() async {
    try {
      var response = await _client.get(_BASE_API + 'about-us/');
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw NoConnectionException(e);
    }
  }
}
