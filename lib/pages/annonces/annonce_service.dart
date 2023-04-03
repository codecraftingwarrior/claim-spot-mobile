import 'dart:convert';

import 'package:http/http.dart';
import 'package:insurance_mobile_app/shared/common/base_service.dart';
import 'package:insurance_mobile_app/shared/common/http_service.dart';

import 'annonce.dart';

class AnnonceService extends BaseService<Annonce>  {
  static final String _path = 'annonce/';
  static final String _resourceName = 'annonce';

  AnnonceService(): super(path: _path, resourceName: _resourceName);

  Future<List<Annonce>> findByCurrentUser() async {
    Response response = await HttpService.get(urn: _path + 'current-user/');
    List<Annonce> annonces = [];
    if(response.statusCode == 200) {
      Iterable<dynamic> items = jsonDecode(response.body);
      annonces = items.map((e) => Annonce.fromJson(e)).toList();
      return annonces;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Une erreur s'est produite");
    }
  }
}