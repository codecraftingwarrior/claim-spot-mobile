import 'dart:convert';

import 'package:http/http.dart';
import 'package:insurance_mobile_app/pages/rendez-vous/rendez_vous.dart';
import 'package:insurance_mobile_app/shared/common/base_service.dart';
import 'package:insurance_mobile_app/shared/common/http_service.dart';

class RendezVousService extends BaseService<RendezVous> {
  static final String _path = 'rendez-vou/';
  static final String _resourceName = 'rendez-vous';

  RendezVousService(): super(path: _path, resourceName: _resourceName);

  Future<List<RendezVous>> all() async {
    var items = await super.all();
    List<RendezVous> result = [];
    for(var item in items) {
      result.add(RendezVous.fromJson(item));
    }
    return result;
  }

  Future<List<RendezVous>> findByCurrentUser() async {
    Response response = await HttpService.get(urn: _path + 'current-user/');
    List<RendezVous> rendezVous = [];
    if(response.statusCode == 200) {
      Iterable<dynamic> items = jsonDecode(response.body);
      rendezVous = items.map((e) => RendezVous.fromJson(e)).toList();
      return rendezVous;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Une erreur s'est produite");
    }
  }
}