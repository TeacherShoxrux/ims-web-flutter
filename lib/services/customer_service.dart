import 'package:flutter/foundation.dart';
import 'package:ims_web/models/customers_model/customerSearch_model.dart';
import 'package:ims_web/models/customers_model/customer_model.dart';
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

 Future<List<CustomersearchModel>> searchAllCustomer({required String text,int page = 1,pageSize=10}) async {
    try {
      var response = await _api.get('api/Customer/Search?searchTerm=$text&pageIndex=$page&pageSize=$pageSize');
      List ls=response['data'];
      print(response);
      return ls.map((e)=>CustomersearchModel.fromJson(e)).toList();
    } catch (e) {
      print("Mahsulotlar ro'yxatini olishda xatolik: $e");
      return [];
    }
  }


   Future<bool> deleteCustomer(int id) async {
    try {
     var res= await _api.delete('api/Customer/$id');
     print(res);
      return true;
    } catch (e) {
      print("Kategoriya o‘chirishda xatolik: $e");
      return false;
    }
  }

}
