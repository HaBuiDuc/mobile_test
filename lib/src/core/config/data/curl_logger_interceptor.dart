import 'package:dio/dio.dart';
import 'dart:convert';

class CurlLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final curlCommand = _buildCurlCommand(options);
    print('╔═══════════════════════════════════════════════════════════════');
    print('║ CURL REQUEST');
    print('╠═══════════════════════════════════════════════════════════════');
    print(curlCommand);
    print('╚═══════════════════════════════════════════════════════════════\n');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('╔═══════════════════════════════════════════════════════════════');
    print('║ RESPONSE: ${response.statusCode} ${response.statusMessage ?? ''}');
    print('╠═══════════════════════════════════════════════════════════════');
    print('║ URL: ${response.requestOptions.uri}');
    print('║ Status: ${response.statusCode}');
    if (response.data != null) {
      try {
        final prettyJson =
            const JsonEncoder.withIndent('  ').convert(response.data);
        print('║ Body:\n$prettyJson');
      } catch (e) {
        print('║ Body: ${response.data}');
      }
    }
    print('╚═══════════════════════════════════════════════════════════════\n');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('╔═══════════════════════════════════════════════════════════════');
    print('║ ERROR: ${err.type}');
    print('╠═══════════════════════════════════════════════════════════════');
    print('║ URL: ${err.requestOptions.uri}');
    print('║ Method: ${err.requestOptions.method}');
    print('║ Status: ${err.response?.statusCode ?? 'N/A'}');
    print('║ Message: ${err.message}');
    if (err.response?.data != null) {
      try {
        final prettyJson =
            const JsonEncoder.withIndent('  ').convert(err.response!.data);
        print('║ Error Body:\n$prettyJson');
      } catch (e) {
        print('║ Error Body: ${err.response!.data}');
      }
    }
    print('╚═══════════════════════════════════════════════════════════════\n');
    super.onError(err, handler);
  }

  String _buildCurlCommand(RequestOptions options) {
    final buffer = StringBuffer();
    buffer.write('curl -X ${options.method}');

    // Add headers
    options.headers.forEach((key, value) {
      if (key.toLowerCase() != 'content-length') {
        buffer.write(' \\\n  -H "$key: $value"');
      }
    });

    buffer.write(' \\\n  "${options.uri}"');

    if (options.data != null) {
      String dataString;
      if (options.data is Map || options.data is List) {
        dataString = jsonEncode(options.data);
      } else if (options.data is String) {
        dataString = options.data as String;
      } else {
        try {
          final dynamic obj = options.data;
          final jsonMap = obj.toJson();
          dataString = jsonEncode(jsonMap);
        } catch (e) {
          dataString = options.data.toString();
        }
      }
      buffer.write(' \\\n  --data-raw \'$dataString\'');
    }

    if (options.queryParameters.isNotEmpty) {
      final queryString = options.queryParameters.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      buffer.write(' \\\n  "$queryString"');
    }

    return buffer.toString();
  }
}
