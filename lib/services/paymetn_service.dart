import 'package:ims_web/models/Payment_model.dart';
import 'package:ims_web/services/api_service.dart';

class PaymetnService {
  final ApiService _api = ApiService();

  Future<List<PaymentModel>> getPayment() async {
    try {
      final response = await _api.get('api/Payment/GetPayments?page=1&pageSize=10');
      print(response);
      final List<dynamic> data = response['data'];
      return data.map((e) => PaymentModel.fromJson(e)).toList();
      // data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Mahsulotni olishda xatolik: $e");
      return [];
    }
  }
}
