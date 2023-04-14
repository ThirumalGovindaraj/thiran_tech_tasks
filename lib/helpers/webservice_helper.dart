import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utilities/validation_utils.dart';
import 'web_service_constants.dart';

class WebServiceHelper {
  static final WebServiceHelper _instance = WebServiceHelper.internal();

  WebServiceHelper.internal();

  factory WebServiceHelper() => _instance;

  /// Get API call
  Future<dynamic> get(String url,
      {Map<String, String> headers = const {},
      bool isOAuthTokenNeeded = true}) async {
    //debugPrint("URL $url");
    Map<String, String> headers = await addConfigHeaders();
    final http.Response response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(
            const Duration(seconds: WebserviceConstants.apiServiceTimeOutInSeconds),
            onTimeout: _onTimeOut);
    if (ValidationUtils.isSuccessResponse(response.statusCode)) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  /// Post API call
  Future<dynamic> post(String url,
      {Map<String, String> headers = const {},
      Map<String, String> params = const {},
      body,
      encoding,
      bool isOAuthTokenNeeded = true}) async {
    //debugPrint("URL $url");
    headers = isOAuthTokenNeeded ? await addConfigHeaders() : headers;
    final response = await http
        .post(Uri.parse(url), headers: headers, body: body, encoding: encoding)
        .timeout(
            const Duration(seconds: WebserviceConstants.apiServiceTimeOutInSeconds),
            onTimeout: _onTimeOut);
    if (ValidationUtils.isSuccessResponse(response.statusCode)) {
      return jsonDecode(response.body);
    } else {
      debugPrint("Error : ${response.body}");
      // return EWalletErrorResponse.fromJson(jsonDecode(response.body));
    }
  }

  /// Post API call
  Future<dynamic> put(String url,
      {Map<String, String> params = const {},
      body,
      Map<String, String> headers = const {},
      encoding,
      bool isOAuthTokenNeeded = true}) async {
    headers = isOAuthTokenNeeded ? await addConfigHeaders() : headers;
    final response = await http
        .put(Uri.parse(url), headers: headers, body: body, encoding: encoding)
        .timeout(
            const Duration(seconds: WebserviceConstants.apiServiceTimeOutInSeconds),
            onTimeout: _onTimeOut);
    if (ValidationUtils.isSuccessResponse(response.statusCode)) {
      return response.body;
    } else {
      return jsonDecode(response.body);
      // return EWalletErrorResponse.fromJson(jsonDecode(response.body));
    }
  }

  /// Post API call
  Future<dynamic> delete(String url, Map<String, String> headers,
      {Map<String, String> params = const {},
      body,
      encoding,
      bool isOAuthTokenNeeded = true}) async {
    headers = isOAuthTokenNeeded ? await addConfigHeaders() : headers;
    final response = await http
        .delete(
          Uri.parse(url),
          headers: headers,
        )
        .timeout(
            const Duration(seconds: WebserviceConstants.apiServiceTimeOutInSeconds),
            onTimeout: _onTimeOut);
    if (ValidationUtils.isSuccessResponse(response.statusCode)) {
      return response.body;
    } else {
      return jsonDecode(response.body);
      // return EWalletErrorResponse.fromJson(jsonDecode(response.body));
    }
  }

  addConfigHeaders() {
    var headers = <String, String>{};
    headers["Content-Type"] = 'application/json';
    headers["X-Requested-With"] = 'XMLHttpRequest';

    return headers;
  }

  addConfigHeadersForWithoutOTPLogin() {
    var headers = <String, String>{};
    headers["Content-Type"] = 'application/json';
    headers["X-Requested-With"] = 'XMLHttpRequest';

    return headers;
  }

  http.Response _onTimeOut() {
    http.Response response =
        http.Response(jsonEncode({"message": "Error response"}), 500);
    return response;
  }

  String contentType = 'application/json';
}
