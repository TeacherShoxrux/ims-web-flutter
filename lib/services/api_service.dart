import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ims_web/routes/urls.dart';
import 'http_client.dart';

class ApiService {
  final String baseUrl = Urls.baseUrl; // Asosiy API URL

  Future<dynamic> get(String endpoint) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/$endpoint'));

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/$endpoint'),
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await httpClient.delete(Uri.parse('$baseUrl/$endpoint'));
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
