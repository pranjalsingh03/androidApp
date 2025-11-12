import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_checker.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/api_response.dart';
import 'package:sheshya/constants/pref_constants.dart';
import 'package:sheshya/helper/logger.dart';

class ApiClient {
  static const baseUrl = ApiConstants.apiBaseUrlNew;
  final int timeoutInSeconds = 60;

  Future<Response> get(
    String uri, {
    String baseUrl = ApiConstants.apiBaseUrlNew,
    bool handleError = true,
    bool passToken = true,
  }) async {
    try {
      if (passToken) {
        final token = GetStorage().read(PrefConstants.token);
        if (token == null) {
          return Response(
            statusCode: 500,
            statusText: ApiConstants.defaultErrorMsg,
            body: ApiResponse(
              message: "Something went wrong!",
              success: false,
            ).toJson(),
          );
        }
      }
      jsonPrint('GET', baseUrl + uri);
      jsonPrint(
          'HEADERS | $uri',
          passToken
              ? {
                  'Content-Type': 'application/json',
                  'Accept': '*/*',
                  'authorization':
                      'Bearer ${GetStorage().read(PrefConstants.token)}'
                }
              : {
                  'Content-Type': 'application/json',
                  'Accept': '*/*',
                });
      http.Response response = await http
          .get(
            Uri.parse(baseUrl + uri),
            headers: passToken
                ? {
                    'Content-Type': 'application/json',
                    'Accept': '*/*',
                    'authorization':
                        'Bearer ${GetStorage().read(PrefConstants.token)}'
                  }
                : {
                    'Content-Type': 'application/json',
                    'Accept': '*/*',
                  },
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      jsonPrint('${response.statusCode} | GET | $uri', response.body);
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return Response(
        statusCode: 500,
        statusText: ApiConstants.defaultErrorMsg,
        body: ApiResponse(message: ApiConstants.defaultErrorMsg, success: false)
            .toJson(),
      );
    }
  }

  Future<Response> post(
    String uri,
    Map<String, dynamic> body, {
    String baseUrl = ApiConstants.baseUrl,
    bool handleError = true,
    bool passToken = true,
    bool sendBodyBytes = false,
  }) async {
    try {
      if (passToken) {
        final token = GetStorage().read(PrefConstants.token);
        if (token == null) {
          return Response(
            statusCode: 500,
            statusText: ApiConstants.defaultErrorMsg,
            body: ApiResponse(
              message: "Something went wrong!",
              success: false,
            ).toJson(),
          );
        }
      }
      jsonPrint('POST', baseUrl + uri);
      jsonPrint(
          'HEADERS | $uri',
          passToken
              ? {
                  'Content-Type': 'application/json',
                  'Accept': '*/*',
                  'authorization':
                      'Bearer ${GetStorage().read(PrefConstants.token)}'
                }
              : {
                  'Content-Type': 'application/json',
                  'Accept': '*/*',
                });
      jsonPrint('POST', body);
      http.Response response = await http
          .post(
            Uri.parse(baseUrl + uri),
            body: jsonEncode(body),
            headers: passToken
                ? {
                    'Content-Type': 'application/json',
                    'Accept': '*/*',
                    'authorization':
                        'Bearer ${GetStorage().read(PrefConstants.token)}'
                  }
                : {
                    'Content-Type': 'application/json',
                    'Accept': '*/*',
                  },
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      // jsonPrint('${response.statusCode} | POST | $uri', response.body);
      if(sendBodyBytes){
        return Response(
          statusCode: response.statusCode,
          statusText: response.reasonPhrase,
          body: response.bodyBytes,
        );
      }
      else{
        return handleResponse(response, uri, handleError);
      }
    } catch (e) {
      return Response(
        statusCode: 500,
        statusText: ApiConstants.defaultErrorMsg,
        body: ApiResponse(message: ApiConstants.defaultErrorMsg, success: false)
            .toJson(),
      );
    }
  }

  Future<Response> put(
    String uri,
    dynamic body, {
    String baseUrl = ApiConstants.baseUrl,
    bool handleError = true,
    bool passToken = true,
  }) async {
    try {
      debugPrint('====>[POST] API Call: ${baseUrl + uri}\n${passToken ? {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'authorization': 'Bearer ${GetStorage().read(PrefConstants.token)}'
        } : {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        }}');
      debugPrint('====> API Body: $body');
      http.Response response = await http
          .put(
            Uri.parse(baseUrl + uri),
            body: jsonEncode(body),
            headers: passToken
                ? {
                    'Content-Type': 'application/json',
                    'Accept': '*/*',
                    'authorization':
                        'Bearer ${GetStorage().read(PrefConstants.token)}'
                  }
                : {
                    'Content-Type': 'application/json',
                    'Accept': '*/*',
                  },
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      log("✅ POST ->[${response.statusCode}] ${response.body}");
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return Response(
        statusCode: 500,
        statusText: ApiConstants.defaultErrorMsg,
        body: ApiResponse(message: ApiConstants.defaultErrorMsg, success: false)
            .toJson(),
      );
    }
  }

  Response handleResponse(http.Response res, String uri, bool handleError) {
    dynamic body;
    // Server Error
    if (res.statusCode >= 500) {
      return Response(
        statusCode: res.statusCode,
        statusText: res.reasonPhrase,
        body: ApiResponse(
                message: res.statusCode == 502
                    ? ApiConstants.serverErrorMsg
                    : ApiConstants.defaultErrorMsg,
                success: false)
            .toJson(),
      );
    }

    try {
      body = jsonDecode(res.body);
    } catch (_) {}
    Response response = Response(
      body: body ?? res.body,
      bodyString: res.body.toString(),
      headers: res.headers,
      statusCode: res.statusCode,
      statusText: res.reasonPhrase,
    );
    jsonPrint('${response.statusCode} | $uri', response.body);
    if (handleError) ApiChecker.checkApi(response);
    return response;
  }
}
