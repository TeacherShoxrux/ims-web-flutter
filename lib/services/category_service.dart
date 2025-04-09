import 'api_service.dart';

class CategoryService {
  final ApiService _api = ApiService();

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      final response = await _api.get('api/Category/GetCategories');
      print(response);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Kategoriyalarni olishda xatolik: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> getCategoryById(String id) async {
    try {
      final response = await _api.get('categories/$id');
      return response;
    } catch (e) {
      print("Kategoriya topilmadi: $e");
      rethrow;
    }
  }

  Future<bool> createCategory(Map<String, dynamic> data) async {
    try {
      await _api.post('api/Category/CreateCategory', data);
      return true;
    } catch (e) {
      print("Kategoriya yaratishda xatolik: $e");
      return false;
    }
  }

  Future<bool> updateCategory(String id, Map<String, dynamic> data) async {
    try {
      await _api.put('api/Category/$id', data);
      return true;
    } catch (e) {
      print("Kategoriya yangilashda xatolik: $e");
      return false;
    }
  }

  Future<bool> deleteCategory(int id) async {
    try {
     var res= await _api.delete('api/Category/$id');
     print(res);
      return true;
    } catch (e) {
      print("Kategoriya o‘chirishda xatolik: $e");
      return false;
    }
  }
}
