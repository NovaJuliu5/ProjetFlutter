import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:3000/api'; // à adapter
  final http.Client client;
  final FlutterSecureStorage storage;

  ApiClient({required this.client, required this.storage});

  Future<Map<String, String>> _headers() async {
    final token = await storage.read(key: 'access_token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String path) async {
    final response = await client.get(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String path, dynamic data) async {
    final response = await client.post(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> put(String path, dynamic data) async {
    final response = await client.put(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String path) async {
    final response = await client.delete(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
    );
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else {
      throw Exception('Erreur API: ${response.statusCode} - ${response.body}');
    }
  }
}