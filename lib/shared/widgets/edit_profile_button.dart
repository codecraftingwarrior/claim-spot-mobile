import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';


class EditProfileButton extends StatelessWidget {
  const EditProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5.0,
      right: 10.0,
      child: Bounce(
        duration: Duration(milliseconds: 100),
        onPressed: () {
          //TODO: Navigate to user profile page
        },
        child: Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: MainColors.primary
          ),
          constraints: BoxConstraints(minHeight: 16.0, minWidth: 16.0),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.userEdit, color: Colors.white, size: 20,),
              SizedBox(width: 12.0,),
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
