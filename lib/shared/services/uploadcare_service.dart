import 'dart:convert';

import 'package:dio/dio.dart';


class UploadcareService {
  static final String _baseUrl = 'https://upload.uploadcare.com/base/';
  static final String _pubKey = '305870a947844f2c4cf5';

  static Future<Response<dynamic>> upload(Map<String, dynamic> data) async {
    data['UPLOADCARE_STORE'] = 'auto';
    data['UPLOADCARE_PUB_KEY'] = _pubKey;
    FormData formData = FormData.fromMap(data);
    var dio = Dio();
    return dio.post<dynamic>(_baseUrl, data: formData);
  }
}

class UploadcareResponse {
  String file;
  UploadcareResponse({required this.file});
}