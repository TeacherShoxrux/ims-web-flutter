import 'package:http_interceptor/http_interceptor.dart';
import '../interceptors/auth_interceptor.dart';

final httpClient = InterceptedClient.build(interceptors: [
  AuthInterceptor(),
]);
