import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<bool> login(String phone, String password) async {
    try {
      final response = await _api.post('api/User/Login', {
        'phone': phone,
        'password': password,
      });
      if (kDebugMode) {
        print(response);
      }
      final token = response['data']['accessToken'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      return true;
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
