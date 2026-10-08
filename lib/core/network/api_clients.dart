import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../network/api_endpoints.dart';
import '../network/dio_logger_interceptor.dart';
import '../network/error_handle.dart';
import '../network/respose_handle.dart';
import '../../data/sources/local/shared_preference/shared_preference.dart';

class ApiClient {
  static final Dio _dio = _createDio();
  static final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: Duration(seconds: 10),
        sendTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );

    // Global logging — only in debug to keep release logs clean.
    // NOTE: custom single-call interceptor (not Dio's LogInterceptor),
    // otherwise PrettyPrinter draws 1 box per line.
    if (kDebugMode) {
      dio.interceptors.add(DioLoggerInterceptor(_logger));
    }

    return dio;
  }

  /// Exposes the shared Dio instance (already has LogInterceptor).
  /// Useful if a service needs direct access, e.g. for downloads/uploads.
  static Dio get dio => _dio;
  static Map<String, String>? headers;

  static Future<void> headerSet(String? token) async {
    final tokn = await SharedPreferenceData.getToken();
    headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      if (tokn != null) 'Authorization': 'Bearer $tokn',
    };
  }

  /// GET request
  Future<dynamic> getRequest({
    required String endpoints,
    // Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
      } else {
        _logger.e('Non-Dio error: $e');
      }
    }
  }

  /// POST request
  static Future<dynamic> postRequest({
    required String endpoints,
    Map<String, dynamic>? body,

    FormData? formData,
  }) async {
    try {
      final response = await _dio.post(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      //log("\nPOST Request Successful: ${response.data}\n");
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
      } else {
        _logger.e('Non-Dio error: $e');
      }
    }
  }

  /// PUT request
  static Future<dynamic> putRequest({
    required String endpoints,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await _dio.put(
        '/$endpoints',
        data: body,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      // debugPrint("\nPUT Request Successful: ${response.data}\n");
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
      } else {
        _logger.e('Non-Dio error: $e');
      }
    }
  }

  /// PATCH request
  static Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    // Map<String, String>? headers,
    FormData? formData,
  }) async {
    try {
      final response = await _dio.patch(
        '${ApiEndpoints.baseUrl}/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );

      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
      } else {
        _logger.e('Non-Dio error: $e');
      }
    }
  }

  /// PATCH request
  static Future<dynamic> deleteRequest({
    required String endpoints,

    // Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );

      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
      } else {
        _logger.e('Non-Dio error: $e');
      }
    }
  }
}
