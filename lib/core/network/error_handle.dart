// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ErrorHandle {
 static void handleDioError(DioException e) {
  print("Error Type: ${e.type}");
  switch (e.type) {
    case DioExceptionType.badCertificate:
      print("badCertificate: ${e.message}");
      throw Exception("Bad certificate error: ${e.message}");
    case DioExceptionType.badResponse:
      print("badResponse: ${e.message}");
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      if (statusCode != null) {
        print("Status Code: $statusCode");
        print("Response Data: $data");
      }
      throw Exception(_friendlyBadResponseMessage(statusCode, data));
    case DioExceptionType.cancel:
      print("Request cancelled: ${e.message}");
      throw Exception("Request was cancelled: ${e.message}");
    case DioExceptionType.connectionError:
      print("Connection error: ${e.message}");
      throw Exception("Connection error: ${e.message}");
    case DioExceptionType.connectionTimeout:
      print("Connection Timeout: ${e.message}");
      print("Request URL: ${e.requestOptions.uri}");
      throw Exception("Connection timeout error: ${e.message}");
    case DioExceptionType.receiveTimeout:
      print("Receive Timeout: ${e.message}");
      print("Request URL: ${e.requestOptions.uri}");
      throw Exception("Receive timeout error: ${e.message}");
    case DioExceptionType.sendTimeout:
      print("Send Timeout: ${e.message}");
      print("Request URL: ${e.requestOptions.uri}");
      throw Exception("Send timeout error: ${e.message}");
    case DioExceptionType.unknown:
      print("Unknown error: ${e.message}");
      if (e.error != null) {
        print("Error: ${e.error}");
      }
      throw Exception("Unknown error: ${e.message}");
  }
 }

  /// Safely extracts a human-readable message from a bad-response body.
  /// Never indexes into [data] blindly: a 502 from nginx is an HTML
  /// [String], not a `{'message': {'message': ...}}` map — the old code
  /// crashed here with a TypeError, masking the real server error.
  static String _friendlyBadResponseMessage(int? statusCode, dynamic data) {
    if (statusCode == 502 ||
        statusCode == 503 ||
        statusCode == 504) {
      return "Server is temporarily unavailable (HTTP $statusCode). "
          "Please try again later.";
    }
    if (statusCode == 500) {
      return "Internal server error (HTTP 500). Please try again later.";
    }

    if (data is Map) {
      final message = data['message'];
      if (message is Map && message['message'] is String) {
        return message['message'] as String;
      }
      if (message is String && message.isNotEmpty) {
        return message;
      }
      final error = data['error'];
      if (error is String && error.isNotEmpty) {
        return error;
      }
    }
    if (data is String && data.isNotEmpty) {
      // nginx / proxy HTML error pages — don't surface raw HTML.
      final trimmed = data.trimLeft().toLowerCase();
      if (trimmed.startsWith('<html') || trimmed.startsWith('<!doctype')) {
        return "Server error${statusCode != null ? ' (HTTP $statusCode)' : ''}. "
            "Please try again later.";
      }
      return data.length > 300 ? data.substring(0, 300) : data;
    }
    return "Request failed${statusCode != null ? ' (HTTP $statusCode)' : ''}. "
        "Please try again.";
  }
}
