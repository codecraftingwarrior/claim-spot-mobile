import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:insurance_mobile_app/shared/common/http_service.dart';

import 'notifier.dart';

abstract class BaseService<T extends BaseModel> {
  String path;
  String resourceName;

  BaseService({required this.path, required this.resourceName});

  dynamic all() async {
    Response response = await HttpService.get(urn: path);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
      throw Exception("Une erreur s'est produite");
      }
    }

  Future<T?> find(T data) async {
    Response response = await HttpService.get(urn: '$path${data.id}');
    if (response.statusCode == 200)
      return data.fromJson(jsonDecode(response.body)) as T;
    else {
      print(jsonDecode(response.body));
      throw Exception("Une erreur s'est produite");
    }
  }

  Future<T> store(T data) async {
    Response response = await HttpService.post(urn: path, data: data);
    if (response.statusCode == 200) {
      return data.fromJson(jsonDecode(response.body)) as T;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Une erreur s'est produite");
    }
  }

  Future<T> update(T data) async {
    Response response =
    await HttpService.put(urn: '$path${data.id}', data: data);
    if (response.statusCode == 200)
      return data.fromJson(jsonDecode(response.body)) as T;
    else {
      print(jsonDecode(response.body));
      throw Exception("Une erreur s'est produite");
    }
  }

  Future<bool> destroy(T data) async {
    Response response = await HttpService.delete(urn: '$path${data.id}');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  void errorMessage(BuildContext context) {
    Notifier.of(context).error(message: "Une erreur s'est produite");
  }
}
