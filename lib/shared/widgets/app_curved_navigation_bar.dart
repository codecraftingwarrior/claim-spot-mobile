import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/shared/constant/drawer_resources.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';

class AppCurvedNavigationBar extends StatefulWidget {
  final String currentPage;
  final int currentIndex;
  final BuildContext context;

  const AppCurvedNavigationBar({Key? key,  required this.currentPage, required this.currentIndex, required this.context})
      : super(key: key);

  @override
  _AppCurvedNavigationBarState createState() => _AppCurvedNavigationBarState();
}

class _AppCurvedNavigationBarState extends State<AppCurvedNavigationBar> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: widget.currentIndex,
      height: 60.0,
      items: <Widget>[
        Icon(FontAwesomeIcons.carCrash, size: 26, color: Colors.white),
        Icon(FontAwesomeIcons.car, size: 26, color: Colors.white),
        Icon(FontAwesomeIcons.bullhorn, size: 26, color: Colors.white),
        Icon(Icons.perm_identity, size: 26, color: Colors.white),
      ],
      color: Colors.red,
      buttonBackgroundColor: Colors.red,
      backgroundColor: Colors.red,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 325),
      onTap: (index) {
      },
      //letIndexChange: (index) => true,
    );
  }
}
