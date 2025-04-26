import 'package:ims_web/models/statistic_model.dart';

import 'api_service.dart';

class StatisticService {
  final ApiService _api = ApiService();

  Future<StatisticModel> getDashboardStats() async {
    try {
      final response = await _api.get('api/Statistics/GetStoreTotal');
      print(response);
      var statistic = response['data'];

      return StatisticModel.fromJson(statistic);
    } catch (e) {
      print("📊 Statistikani olishda xatolik: $e");
      rethrow;
    }
  }
    void downloadProductsExcel()async{
      _api.downloadFileFromBackend(
        url: 'api/Statistics/export-products',
        fallbackFileName: 'products.xlsx',
      );
    }
    void downloadMonthExcel()async{
      _api.downloadFileFromBackend(
        url: 'api/Statistics/export-sale-month',
        fallbackFileName: 'products.xlsx',
      );
    }
    void downloadWeekExcel()async{
      _api.downloadFileFromBackend(
        url: 'api/Statistics/export-sale-week',
        fallbackFileName: 'products.xlsx',
      );
    }
  void downloadDayExcel()async{
    _api.downloadFileFromBackend(
      url: 'api/Statistics/export-sale-day',
      fallbackFileName: 'products.xlsx',
    );
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
