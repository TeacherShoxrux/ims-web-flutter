import 'package:flutter/foundation.dart';
import 'package:ims_web/models/customer_model.dart';
import 'package:ims_web/services/api_service.dart';

class CustomerService {
  final ApiService _api = ApiService();

  Future<bool> AddCustomer(String name, String phone, String info) async {
    try {
      final response = await _api.post('api/Customer', {
        "name": name,
        "phone": phone,
        "info": info,
      });
      if (kDebugMode) {
        print(response);
      }
      return true;
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }

  Future<List<CustomerDataModel>> getAllCustomer() async {
    try {
      final response = await _api.get('api/Customer/all');
      print(response);
     final List<dynamic> data = response['data'];
      return data.map((e)=>CustomerDataModel.fromJson(e)).toList();
      // data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Mahsulotni olishda xatolik: $e");
      return [];
    }
  }
}
