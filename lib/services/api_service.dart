import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../routes/urls.dart';
import 'auth_service.dart';
import 'http_client.dart';

class ApiService {
  final String baseUrl = Urls.baseUrl;
  final http.Client httpClient = CustomHttpClient();


  Future<String> uploadImage(String endpoint, PlatformFile file) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer ${await _getToken()}'
      ..files.add(http.MultipartFile.fromBytes(

        'image', await file.xFile.readAsBytes(),
          filename: file.name,
          contentType: MediaType('image','${file.identifier}')));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      throw Exception('Image upload error: ${response.statusCode} → ${response.body}');
    }
  }

  Future<String?> _getToken() async {
    return await AuthService().getToken;
  }




  Future<dynamic> get(String endpoint) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl/$endpoint'),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: ${response.statusCode} → ${response.body}');
    }
  }
}
