import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum DioMethod { get, post, patch, delete }

class ApiService {
  ApiService._singleton() {
    _dio = Dio(BaseOptions(
        baseUrl: "http://10.0.2.2:3001/", contentType: "application/json"));
  }

  late final Dio _dio;
  String? _token;

  set token(String? value) {
    if (value == null) {
      const FlutterSecureStorage().delete(key: "token");
    } else {
      const FlutterSecureStorage().write(key: "token", value: value);
      _token = value;
    }
  }

  void getTokenFromStorage() async {
    _token = await const FlutterSecureStorage().read(key: "token");
  }

  static final ApiService instance = ApiService._singleton();

  Dio get dio => _dio;

  Future<Response> request(String endpoint, DioMethod method,
      Map<String, dynamic>? params, Map<String, dynamic>? fromData) {
    final fullParams =
        params == null ? {'token': _token} : {...params, 'token': _token};
    switch (method) {
      case DioMethod.post:
        return dio.post(endpoint, queryParameters: fullParams, data: fromData);
      case DioMethod.patch:
        return dio.patch(endpoint, queryParameters: fullParams, data: fromData);
      case DioMethod.delete:
        return dio.delete(endpoint, queryParameters: fullParams);
      default:
        return dio.get(endpoint, queryParameters: fullParams);
    }
  }
}
