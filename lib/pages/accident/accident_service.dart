import 'package:flutter/cupertino.dart';
import 'package:insurance_mobile_app/shared/common/base_service.dart';

import 'accident.dart';

class AccidentService extends BaseService<Accident> {
  static final String _path = 'accident/';
  static final String _resourceName = 'accident';
  final BuildContext context;

  AccidentService({required this.context})
      : super(path: _path, resourceName: _resourceName);

  AccidentService.of(this.context)
      : super(path: _path, resourceName: _resourceName);

  @override
  Future<List<Accident>> all() async {
    var items = await super.all();
    List<Accident> accidents = [];
    for (var item in items) {
      accidents.add(Accident.fromJson(item));
    }
    return accidents;
  }
}
