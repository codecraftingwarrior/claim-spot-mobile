import 'dart:convert';

import 'package:insurance_mobile_app/pages/auth/credentials.dart';
import 'package:http/http.dart' as http;
import 'package:insurance_mobile_app/shared/common/http_service.dart';
import 'package:insurance_mobile_app/shared/common/preferences.dart';

class AuthService {
 static final String _loginUrl = 'https://insurance-claim-management.herokuapp.com/login';

  static Future<http.Response> login(Credentials credentials) {
    Uri uri = Uri.parse('$_loginUrl');
    return http.post(uri,
        body: jsonEncode(credentials.toJson()),
        headers: {'Content-type': 'application/json'});
  }

  static Future<http.Response> getCurrentUser() {
    return HttpService.get(urn: 'user/current/');
  }

  static Future<bool> isAuthenticated() async {
    var token = (await Preferences.getToken());
    return token != null;
  }

  static Future<void> logout() async {
    Preferences.remove('token');
    Preferences.remove('currentUser');
  }
}
