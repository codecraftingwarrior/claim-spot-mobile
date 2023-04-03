import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';

class ExtraInfo extends StatelessWidget {
  final ApplicationUser user;
  const ExtraInfo({required this.user});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildInfo(context, FontAwesomeIcons.fileSignature, utf8.decode(utf8.encode(user.formule?.libelle! ?? '')) ),
      buildDivider(),
      buildInfo(context, FontAwesomeIcons.mapMarkedAlt, user.adresse!),
      buildDivider(),
      buildInfo(context, FontAwesomeIcons.briefcase, user.fonction!),
    ],
  );
  Widget buildDivider() => Container(
    height: 24,
    child: VerticalDivider(color: Colors.black),
  );

  Widget buildInfo(BuildContext context, IconData icon, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 18.0),
              SizedBox(height: 5),
              Text(
                text,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            ],
          ),
        ),
      );
}
