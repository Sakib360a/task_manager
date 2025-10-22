import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/task_manager_app.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  //GET Request
  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? ''
        },
      );
      _logResponse(url, response);
      final int statusCode = response.statusCode;

      if (response.statusCode == 200) {
        // Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseData: decodedData,
          responseCode: statusCode,
        );
      } else if (response.statusCode == 401) {
        await _moveToLogin();
        return ApiResponse(
          isSuccess: false,
          responseData: null,
          errorMessage: 'Un-authorized',
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

  // POST Request
  static Future<ApiResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      Response response = await post(
        uri,
        headers: {
          'content-type': 'application/json',
          'token': AuthController.accessToken ?? '',
        },
        body: jsonEncode(body),
      );
      _logResponse(url, response);
      final int statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        // Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseData: decodedData,
          responseCode: statusCode,
        );
      } else if (response.statusCode == 401) {
        await _moveToLogin();
        return ApiResponse(
          isSuccess: false,
          responseData: null,
          errorMessage: 'Un-authorized',
          responseCode: statusCode,
        );
      }
      else {
        //Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responseData: decodedData,
          responseCode: statusCode,
          errorMessage: decodedData['data'],
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

  static void _logRequest(String? url, {Map<String, dynamic>? body}) {
    _logger.i(
      "URL=> $url\n"
      'Body: $body',
    );
  }

  static void _logResponse(String? url, Response response) {
    _logger.i(
      "URL=> $url\n"
      'StatusCode: ${response.statusCode}\n'
      'Body: ${response.body}\n',
    );
  }

  static Future<void> _moveToLogin() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      TaskManagerApp.navigator.currentContext!,
      LoginScreen.name,
      (predicate) => false,
    );
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
