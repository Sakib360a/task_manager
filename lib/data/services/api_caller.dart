import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiCaller {
  static final Logger _logger = Logger();
  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(uri);
      _logResponse(url,response);
      final int statusCode = response.statusCode;

      if (response.statusCode == 200) {
        // Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseData: decodedData,
          responseCode: statusCode,
        );
      } else {
        //Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responseData: decodedData,
          responseCode: statusCode,
        );
      }
    } on Exception catch (e) {
      // TODO
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }
  static Future<ApiResponse> postRequest({required String url, Map<String,dynamic>?body}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url,body: body);
      Response response = await post(uri);
      _logResponse(url,response);
      final int statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        // Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseData: decodedData,
          responseCode: statusCode,
        );
      } else {
        //Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responseData: decodedData,
          responseCode: statusCode,
        );
      }
    } on Exception catch (e) {
      // TODO
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(String? url,{Map<String,dynamic>?body}) {
    _logger.i("URL=> $url"
    'Body: $body');
  }
  static void _logResponse(String? url, Response response) {
    _logger.i("URL=> $url\n"
    'StatusCode: ${response.statusCode}\n'
    'Body: ${response.body}\n');
  }
}

class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;
  ApiResponse({
    required this.isSuccess,
    required this.responseData,
    required this.responseCode,
    this.errorMessage = 'Something went wrong',
  });
}
