import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:insurance_mobile_app/shared/common/base_service.dart';
import 'package:insurance_mobile_app/shared/common/http_service.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';

class ApplicationUserService extends BaseService<ApplicationUser> {
  static final String _path = 'user/';
  static final String _resourceName = 'user';
  final BuildContext context;
  ApplicationUserService({required this.context}): super(path: _path, resourceName: _resourceName);

  Future<ApplicationUser> updatePassword(ApplicationUser user) async {
    Response response = await HttpService.put(urn: '$path${user.id}/update-password', data: user);
    if(response.statusCode == 200) {
      return ApplicationUser.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 406) {
      Notifier.of(context).error(message: 'Le mot de passe courant indiqué est invalide.');
      throw new Exception("Une erreur s'est produite.");
    } else {
      print(jsonDecode(response.body));
      throw new Exception("Une erreur s'est produite.");
    }
  }
}