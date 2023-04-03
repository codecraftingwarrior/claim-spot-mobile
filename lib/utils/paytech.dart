import 'dart:convert';

import 'package:http/http.dart';
import 'package:insurance_mobile_app/shared/common/http_service.dart';
import 'package:http/http.dart' as http;

class Paytech {
  final String _url = 'https://paytech.sn';
  final String _paymentRequestPath = '/api/payment/request-payment';
  final String _paymentRedirectPath = '/payment/checkout/';
  final String _mobileCancelUrl = 'https://paytech.sn/mobile/cancel';
  final String _mobileSuccessUrl = 'https://paytech.sn/mobile/success';

  final String _apiKey =
      'f382396b45b2203a38a1c53e7ef8f33837d7b82ca1065185d2ed14ebd0fd8014';
  final String _apiSecret =
      'f6514010b8d38a0443848b40d7685b3f6580d2454137c8d78a1474f3dca7edef';
  Map<String, String>? _query;
  Map<String, String>? _customField;
  bool _liveMode = true;
  bool _testMode = false;
  bool _isMobile = false;
  String _currency = 'XOF';
  String _refCommand = '';
  Map<String, String> notificationUrl = {};

  Paytech();

  static Paytech getInstance() => Paytech();

  static String _mapGet(Map<String, dynamic> data, $key, {$default = ''}) =>
      data.containsKey($key) ? data[$key] : $default;

  Future<Map<String, dynamic>> send() async {
    Map<String, dynamic> requestBody = {
      'item_name': _mapGet(_query!, 'item_name'),
      'item_price': _mapGet(_query!, 'item_price'),
      'command_name': _mapGet(_query!, 'command_name'),
      'ref_command': _refCommand,
      'env': _mapGet(_query!, 'env'),
      'currency': _currency,
      'ipn_url': _mapGet(notificationUrl, 'ipn_url'),
      'success_url': _isMobile
          ? _mobileSuccessUrl
          : _mapGet(notificationUrl, 'success_url'),
      'cancel_url':
          _isMobile ? _mobileCancelUrl : _mapGet(notificationUrl, 'cancel_url'),
      'custom_field': jsonEncode(_customField),
    };


    Uri uri = Uri.parse('$_url/$_paymentRequestPath');
    Response rawResponse =
        await http.post(uri, body: jsonEncode(requestBody), headers: {
      'Content-Type': 'application/json',
      'API_KEY': _apiKey,
      'API_SECRET': _apiSecret
    });

    Map<String, dynamic> response = jsonDecode(rawResponse.body);

    if (response.containsKey('token')) {
      String query = '';

      return {
        'success': 1,
        'token': response['token'],
        'redirect_url': _url + _paymentRedirectPath + response['token'] + query
      };
    }

    if (response.containsKey('error')) {
      return {'success': -1, 'errors': response['error']};
    }

     return {'success': -1, 'errors': 'Internal error'};
  }

  String get refCommand => _refCommand;

  set refCommand(String value) {
    _refCommand = value;
  }

  String get currency => _currency;

  set currency(String value) {
    _currency = value;
  }

  bool get isMobile => _isMobile;

  set isMobile(bool value) {
    _isMobile = value;
  }

  bool get testMode => _testMode;

  set testMode(bool value) {
    _testMode = value;
    _liveMode = !testMode;
  }

  bool get liveMode => _liveMode;

  set liveMode(bool value) {
    _liveMode = value;
    _testMode = !liveMode;
  }

  Map<String, String>? get customField => _customField;

  set customField(Map<String, String>? value) {
    _customField = value;
  }

  Map<String, String>? get query => _query;

  set query(Map<String, String>? value) {
    _query = value;
  }

  String get apiSecret => _apiSecret;

  String get apiKey => _apiKey;
}
