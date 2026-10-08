import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Single-call Dio logger: 1 [Logger] call per request/response/error,
/// so [PrettyPrinter] draws 1 box per HTTP event instead of 1 box per line
/// (which is what happens when Dio's [LogInterceptor.logPrint] is
/// forwarded to Logger — LogInterceptor calls logPrint ~6x per request).
class DioLoggerInterceptor extends Interceptor {
  final Logger logger;
  final int maxBodyLength;

  DioLoggerInterceptor(this.logger, {this.maxBodyLength = 2048});

  String _truncate(Object? data) {
    final text = data.toString();
    if (text.length <= maxBodyLength) return text;
    return '${text.substring(0, maxBodyLength)}… (truncated, ${text.length} chars)';
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d(
      '🚀 REQUEST\n'
      '${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Body: ${_truncate(options.data)}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      '✅ RESPONSE [${response.statusCode}]\n'
      '${response.requestOptions.method} ${response.requestOptions.uri}\n'
      'Body: ${_truncate(response.data)}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      '❌ ERROR [${err.response?.statusCode}]\n'
      '${err.requestOptions.method} ${err.requestOptions.uri}\n'
      'Message: ${err.message}\n'
      'Body: ${_truncate(err.response?.data)}',
    );
    super.onError(err, handler);
  }
}
