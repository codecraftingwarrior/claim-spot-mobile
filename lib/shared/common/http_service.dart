import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:insurance_mobile_app/shared/common/authenticated_request_interceptor.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';

class HttpService {
  static final String _baseApiUrl = 'https://insurance-claim-management.herokuapp.com/api';
  static final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthenticatedRequestInterceptor(),
  ]);

  static Future<http.Response> get({required String urn}) {
    Uri uri = Uri.parse('$_baseApiUrl/$urn');
    return _httpClient.get(uri, headers: {
      'Content-type': 'application/json',
    });
  }

  static Future<http.Response> post({required String urn, required dynamic data}) {
    Uri uri = Uri.parse('$_baseApiUrl/$urn');
    return _httpClient
        .post(uri, body: jsonEncode(data.toJson()) , headers: {'Content-type': 'application/json'});
  }

 static Future<http.Response> put({required String urn, required dynamic data}) {
    Uri uri = Uri.parse('$_baseApiUrl/$urn');
    return _httpClient
        .put(uri, body: jsonEncode(data.toJson()) , headers: {'Content-type': 'application/json'});
  }

  static Future<http.Response> delete({required String urn}) {
    Uri uri = Uri.parse('$_baseApiUrl/$urn');
    return _httpClient.delete(uri, headers: {'Content-type': 'application/json'});
  }

  static void handleError(BuildContext context, dynamic error) {
    Notifier.of(context).error(message: error);
  }
}
