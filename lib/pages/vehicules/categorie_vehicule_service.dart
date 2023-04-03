import 'dart:convert';

import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/shared/common/base_service.dart';

class CategorieVehiculeService extends BaseService<CategorieVehicule> {
  static final String _path = 'categorie-vehicule/';
  static final String _resourceName = 'categorie-vehicule';

  CategorieVehiculeService(): super(path: _path, resourceName:  _resourceName);

  @override
  Future<List<CategorieVehicule>> all() async {
    var items = await super.all();
    List<CategorieVehicule> result = [];
    for(var item in items) {
      result.add(CategorieVehicule.fromJson(item));
    }
    return result;
  }
}