import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:ims_web/models/product_model.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _api = ApiService();

  // Barcha mahsulotlarni olish
  Future<List<ProductModel>> getAllProducts({int page = 1,pageSize=1000}) async {
    try {
      List response = await _api.get('api/Product/GetAllProductsByStoreId?pageIndex=$page&pageSize=$pageSize');
      print(response);
      return response.map((e)=>ProductModel.fromJson(e)).toList();
    } catch (e) {
      print("Mahsulotlar ro'yxatini olishda xatolik: $e");
      return [];
    }
  }
  // Barcha mahsulotlarni olish
  Future<List<ProductModel>> searchAllProducts({required String text,int page = 1,pageSize=10}) async {
    try {
      List response = await _api.get('api/Product/GetAllProductsByStoreIdAndSearchTerm/$text?pageIndex=$page&pageSize=$pageSize');
      print(response);
      return response.map((e)=>ProductModel.fromJson(e)).toList();
    } catch (e) {
      print("Mahsulotlar ro'yxatini olishda xatolik: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> getProductById({int page = 1,pageSize=10}) async {
    try {
      final response = await _api.get('api/Product/GetAllProductsByStoreId?pageIndex=$page&pageSize=$pageSize');
      return response;
    } catch (e) {
      print("Mahsulotni olishda xatolik: $e");
      rethrow;
    }
  }
  Future<String?> uploadImage(PlatformFile file) async {
    try {
      final response = await _api.uploadImage('api/Image',file);
      return jsonDecode(response)['fileName']
      ;//['fileName'];
    } catch (e) {
      print("Rasm Yuklashda xatolik: $e");
      rethrow;
    }
  }

  // Mahsulot yaratish
  Future<bool> createProduct(Map<String, dynamic> data) async {
    try {
      var result= await _api.post('api/Product/AddProduct', data);
      print("------------------------------------------------");
      print(result);
      print("------------------------------------------------");
      return true;
    } catch (e) {
      print("Mahsulot yaratishda xatolik: $e");
      return false;
    }
  }

  // Mahsulotni yangilash
  Future<bool> updateProduct(String id, Map<String, dynamic> data) async {
    try {
      await _api.put('products/$id', data);
      return true;
    } catch (e) {
      print("Mahsulot yangilashda xatolik: $e");
      return false;
    }
  }

  // Mahsulotni o'chirish
  Future<bool> deleteProduct(String id) async {
    try {
      await _api.delete('products/$id');
      return true;
    } catch (e) {
      print("Mahsulotni o‘chirishda xatolik: $e");
      return false;
    }
  }
}
