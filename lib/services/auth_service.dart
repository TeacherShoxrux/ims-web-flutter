import 'package:flutter/foundation.dart';
import 'package:ims_web/models/userInfo_model.dart';
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

 Future<UserInfoModel?> getUserInfo() async {
  try {
    final token = await AuthService().getToken;
    if (token == null) {
      print("Token topilmadi");
      return null;
    }

    final response = await _api.get('api/User/info');
    print("------------------");
    print( response);
    final data = response['user']; // bu yerda data = Map<String, dynamic>

    if (data == null) {
      print('data null');
      return null;
    }

    return UserInfoModel.fromJson(data["data"]);
  } catch (e) {
    print('getUserProfile error: $e');
    return null;
  }
}





Future<bool> updateImageUser( Map<String, dynamic> data) async {
    try {
      await _api.put('api/User', data);
      return true;
    } catch (e) {
      print("Kategoriya yangilashda xatolik: $e");
      return false;
    }
  }

  

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
  get  getToken async=> (await SharedPreferences.getInstance()).getString("jwt_token");
}
