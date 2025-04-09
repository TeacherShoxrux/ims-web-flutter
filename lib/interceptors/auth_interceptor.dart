import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token != null) {
      data.headers['Authorization'] = 'Bearer $token';
    }

    data.headers['Content-Type'] = 'application/json';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // Agar token muddati tugagan bo‘lsa, bu yerda tekshirishingiz mumkin
    if (data.statusCode == 401) {
      // logout yoki tokenni yangilashni boshlash
    }

    return data;
  }
}
