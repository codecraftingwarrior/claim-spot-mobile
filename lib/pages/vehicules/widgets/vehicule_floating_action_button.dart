import 'package:flutter/material.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';

class VehiculeFloatingActionButton extends StatelessWidget {
  const VehiculeFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 2.0,
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, '/vehicule/new');
      },
      backgroundColor: MainColors.primary,
    );
  }
}
