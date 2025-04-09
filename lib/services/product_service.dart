import 'api_service.dart';

class ProductService {
  final ApiService _api = ApiService();

  // Barcha mahsulotlarni olish
  Future<List<Map<String, dynamic>>> getAllProducts({int page = 1,pageSize=10}) async {
    try {
      final response = await _api.get('api/Product/GetAllProductsByStoreId?pageIndex=$page&pageSize=$pageSize');
      return List<Map<String, dynamic>>.from(response);
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

  // Mahsulot yaratish
  Future<bool> createProduct(Map<String, dynamic> data) async {
    try {
      await _api.post('products', data);
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
