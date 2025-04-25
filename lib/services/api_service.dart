import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../routes/urls.dart';
import 'auth_service.dart';
import 'http_client.dart';
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

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



  Future<void> downloadFileFromBackend({
    required String url,
    String? fallbackFileName,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$url'),
        headers: {
          'Authorization': 'Bearer ${await _getToken()}',
        },
      );

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        // Fayl nomini Content-Disposition headerdan olish
        final contentDisposition = response.headers['content-disposition'];
        String fileName = fallbackFileName ?? 'downloaded_file.xlsx';

        if (contentDisposition != null && contentDisposition.contains('filename=')) {
          final regex = RegExp(r'filename="?(.+?)"?($|;)', caseSensitive: false);
          final match = regex.firstMatch(contentDisposition);
          if (match != null && match.groupCount >= 1) {
            fileName = match.group(1)!;
          }
        }

        // MIME type - serverdan kelayotganiga ishonamiz
        final mimeType = response.headers['content-type'] ?? 'application/octet-stream';

        // Faylni brauzerda yuklab berish
        final blob = html.Blob([bytes], mimeType);
        final url = html.Url.createObjectUrlFromBlob(blob);

        final anchor = html.AnchorElement(href: url)
          ..download = fileName
          ..click();

        html.Url.revokeObjectUrl(url);
      } else {
        print('Xatolik: ${response.statusCode}');
      }
    } catch (e) {
      print('Faylni yuklab olishda xatolik: $e');
    }
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
    final response = await httpClient.put(Uri.parse('$baseUrl/$endpoint'),headers: {'Content-Type': 'application/json'},body: jsonEncode(data));
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
