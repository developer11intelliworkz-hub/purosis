import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:purosis/utils/storage_service.dart';

import '../consts/app_url.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  DioClient._internal() {
    _initDio();
  }

  late Dio dio;

  void _initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppUrl.baseUrlApi,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final storage = Get.find<StorageService>();
          final token = storage.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // Optional:
            // Handle token expiration
            // Example: logout user or refresh token
          }
          return handler.next(e);
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    );
  }
}

class ApiService {
  final Dio _dio = DioClient().dio;

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException {
      return null;
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException {
      return null;
    }
  }

  Future<dynamic> postFormData(String endpoint, FormData formData) async {
    try {
      final response = await _dio.post(endpoint, data: formData);
      return response.data;
    } on DioException {
      return null;
    }
  }
}
