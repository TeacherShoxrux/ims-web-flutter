import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ims_web/models/userInfo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../UI/pages/login/login.dart';
import '../main.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService();
  static String role="";
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
      return false;
    }
  }

 Future<UserInfoModel?> getUserInfo() async {
  try {
    final token = await AuthService().getToken;
    if (token == null) {
      return null;
    }

    final response = await _api.get('api/User/info');

    final data = response['user'];

    if (data == null) {
      print('data null');
      return null;
    }
    var model=UserInfoModel.fromJson(data["data"]);
    role=model.role;
    return model;
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
    Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
          (delate) => true,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
  String? _login;
  Future<String?> get  getToken async{
    _login??= (await SharedPreferences.getInstance()).getString("jwt_token");
    if(_login==null)logout();
  return _login;

  }
}
