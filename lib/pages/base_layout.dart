import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/accident/screens/accident_body.dart';
import 'package:insurance_mobile_app/pages/accident/widgets/accident_floating_action_button.dart';
import 'package:insurance_mobile_app/pages/annonces/screens/annonce_body.dart';
import 'package:insurance_mobile_app/pages/annonces/widgets/annonce_floating_action_button.dart';
import 'package:insurance_mobile_app/pages/profile/screens/profile_body.dart';
import 'package:insurance_mobile_app/pages/profile/widgets/profile_floating_action_button.dart';
import 'package:insurance_mobile_app/pages/rendez-vous/screens/rendez_vous_body.dart';
import 'package:insurance_mobile_app/pages/vehicules/screens/vehicule_body.dart';
import 'package:insurance_mobile_app/pages/vehicules/widgets/vehicule_floating_action_button.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/constant/drawer_resources.dart';
import 'package:insurance_mobile_app/shared/widgets/navbar.dart';

import 'auth/auth_service.dart';

class BaseLayout extends StatefulWidget {
  final int? targetPage;
  const BaseLayout({Key? key, this.targetPage}) : super(key: key);

  @override
  _BaseLayoutState createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  late List<dynamic> _tabItems = [
    AccidentBody(title: accidentResource.title,
        floatingActionButton: AccidentFloatingActionButton()),
    VehiculeBody(
        title: vehiculeResource.title,
        floatingActionButton: VehiculeFloatingActionButton()),
    RendezVousBody(title: rendezVousResource.title, floatingActionButton: null),
    AnnonceBody(
        title: annonceResource.title,
        floatingActionButton: AnnonceFloatingActionButton(baseContext: context)),
    ProfileBody(title: profileResource.title, floatingActionButton: ProfileFloatingActionButton()),
  ];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
  GlobalKey<CurvedNavigationBarState>();

  late int _activePage = widget.targetPage != null ? widget.targetPage! : 0;

  @override
  void initState() {
    _checkAuthenticated();
    super.initState();
  }

  void _checkAuthenticated() async {
    bool isAuthenticated = await AuthService.isAuthenticated();
    if (!isAuthenticated) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color appColor = Colors.white;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: Navbar(title: _tabItems[_activePage].title),
        backgroundColor: appColor,
        //  drawer: AppDrawer(currentPage: accidentResource.title),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _activePage,
          height: 60.0,
          items: <Widget>[
            Icon(FontAwesomeIcons.carCrash, size: 26, color: Colors.white),
            Icon(FontAwesomeIcons.car, size: 26, color: Colors.white),
            Icon(FontAwesomeIcons.calendarCheck, size: 26, color: Colors.white),
            Icon(FontAwesomeIcons.bullhorn, size: 26, color: Colors.white),
            Icon(Icons.perm_identity, size: 26, color: Colors.white),
          ],
          color: MainColors.primary,
          buttonBackgroundColor: MainColors.primary,
          backgroundColor: appColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 325),
          onTap: (index) {
            setState(() {
              _activePage = index;
            });
          },
          //letIndexChange: (index) => true,
        ),
        floatingActionButton: _tabItems[_activePage].floatingActionButton,
        body: _tabItems[_activePage],
      ),
    );
  }
}
