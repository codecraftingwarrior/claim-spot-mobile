import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/src/response.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/shared/common/base_service.dart';
import 'package:insurance_mobile_app/shared/common/http_service.dart';

class VehiculeService extends BaseService<Vehicule> {
  final BuildContext context;
  static final String _path = 'vehicule/';
  static final String _resourceName = 'vehicule';

  VehiculeService({required this.context})
      : super(path: _path, resourceName: _resourceName);

  @override
  Future<List<Vehicule>> all() async {
    var items = await super.all();
    List<Vehicule> result = [];
    for (var item in items) {
      result.add(Vehicule.fromJson(item));
    }
    return result;
  }

  Future<Vehicule> update(Vehicule data) async {
    Response response = await HttpService.put(urn: '$path${data.id}?image=false', data: data);
    if (response.statusCode == 200)
      return data.fromJson(jsonDecode(response.body));
    else {
      print(jsonDecode(response.body));
      throw Exception("Une erreur s'est produite");
    }
  }
  
  Future<List<Vehicule>> findAllWithoutAnnonce() async {
    Response response = await HttpService.get(urn: _path + 'without-annonce/');
    List<Vehicule> result = [];
    if(response.statusCode == 200) {
      var items = jsonDecode(response.body);
      for(var item in items) result.add(Vehicule.fromJson(item));
      return result;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Une erreur s'est produite");
    }
  }
}
