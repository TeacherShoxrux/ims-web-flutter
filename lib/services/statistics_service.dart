import 'api_service.dart';

class StatisticService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _api.get('api/Statistics/GetStoreTotal');
      print(response);
      return response;
    } catch (e) {
      print("📊 Statistikani olishda xatolik: $e");
      rethrow;
    }
  }
  //
  // Future<int> getTotalUsers() async {
  //   try {
  //     final response = await _api.get('statistics/total-users');
  //     return response['count'] ?? 0;
  //   } catch (e) {
  //     print("Foydalanuvchilar sonini olishda xatolik: $e");
  //     return 0;
  //   }
  // }
  //
  // Future<int> getTotalOrders() async {
  //   try {
  //     final response = await _api.get('statistics/total-orders');
  //     return response['count'] ?? 0;
  //   } catch (e) {
  //     print("Buyurtmalar sonini olishda xatolik: $e");
  //     return 0;
  //   }
  // }
  //
  // Future<double> getTotalRevenue() async {
  //   try {
  //     final response = await _api.get('statistics/total-revenue');
  //     return double.tryParse(response['amount'].toString()) ?? 0.0;
  //   } catch (e) {
  //     print("Daromadni olishda xatolik: $e");
  //     return 0.0;
  //   }
  // }
}
