import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_checker.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class ChatApiClient {
  static const chatUrl = ApiConstants.chatBaseUrl;

  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  final Map<String, String> _mainHeaders = {
    'Content-Type': 'application/json',
  };

  Future<Response> postData(String uri, dynamic body,
      {bool handleError = true}) async {
    try {
      debugPrint('====>[POST] API Call: $uri');
      debugPrint('====> API Body: $body');
      http.Response response = await http
          .post(
            Uri.parse(chatUrl + uri),
            body: jsonEncode(body),
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response res, String uri, bool handleError) {
    dynamic body;
    try {
      body = jsonDecode(res.body);
    } catch (_) {}
    Response response = Response(
      // body: DateTime.now().toString(),
      body: body ?? res.body,
      bodyString: res.body.toString(),
      headers: res.headers,
      statusCode: res.statusCode,
      statusText: res.reasonPhrase,
    );
    debugPrint(
        '====> API Response: [${response.statusCode}] $uri\n${response.body}');
    if (handleError) ApiChecker.checkApi(response);
    return response;
  }
}
