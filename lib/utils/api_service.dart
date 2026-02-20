
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../consts/app_url.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: AppUrl.baseUrlApi,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add token if needed
          // options.headers['Authorization'] = 'Bearer TOKEN';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
    _dio!.interceptors.add(
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
    return _dio!;
  }
}
class ApiService {
  final Dio _dio = DioClient.instance;

  /// GET API
  Future<dynamic> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      return null;
    }
  }

  /// POST API (JSON Body)
  Future<dynamic> post(
      String endpoint, {
        Map<String, dynamic>? data,
      }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      return null;
    }
  }

  /// POST API (FormData / File Upload)
  Future<dynamic> postFormData(
      String endpoint,
      FormData formData,
      ) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      return null;
    }
  }
}

