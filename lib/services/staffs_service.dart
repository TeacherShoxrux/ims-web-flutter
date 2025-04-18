import 'package:flutter/foundation.dart';
import 'package:ims_web/services/api_service.dart';

class StaffsService{
    final ApiService _api = ApiService();
    
     Future<bool> addAlerstaff(String fullName, String phone, String password) async {
    try {
      final response = await _api.post('api/User/Register', {
        'fullName': fullName,
        'phone': phone,
        'password': password,
      });
      if (kDebugMode) {
        print(response);
      }
      // final token = response['data']['accessToken'];
      // if(token == null) throw Exception("Token mavjud emas");
      //final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('jwt_token', token);
      return true;
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }


 Future<List<Map<String, dynamic>>> getStaffs() async {
    try {
      final response = await _api.get('api/User/all');
      final  List<dynamic>data = response['data'];
      return data.cast<Map<String,dynamic>>();
    } catch (e) {
      print("Mahsulotni olishda xatolik: $e");
      rethrow;
    }
  }
}