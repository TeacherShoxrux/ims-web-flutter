import 'package:ims_web/models/Payment_model.dart';
import 'package:ims_web/models/product_model.dart';
import 'package:ims_web/services/api_service.dart';

import '../models/base_model.dart';
import '../models/payment_info_model.dart';

class PaymentService {
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
  Future<BaseModel<PaymentModel>> createPayment(
      {
      required   int customerId,
      required  List<ProductModel> products,
      required  String paymentMethod}) async {
    // try {
      final response = await _api.post('api/Payment/Create',
          {
            "customerId": customerId,
            "poducts": products.map((e)=>e.toJson()).toList(),
            "paymentMethod": paymentMethod
          }
      );
      print(response);
      return BaseModel<PaymentModel>.fromJson(response,(e)=>PaymentModel.fromJson(e));
    //   data.cast<Map<String, dynamic>>();
    // } catch (e) {
    //   print("Mahsulotni olishda xatolik: $e");
    //   return PaymentInfoModel.fromJson({});
    // }
  }

}
