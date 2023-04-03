import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:insurance_mobile_app/pages/auth/auth_service.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/widgets/custom_progress_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double _prefferedHeight = 55.0;

  const Navbar({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2.0,
      title: Text(widget.title),
      backgroundColor: MainColors.primary,
      actions: <Widget>[
        IconButton(
            onPressed: _showLogoutAlert, icon: Icon(Icons.logout_outlined))
      ],
    );
  }

  Future<void> _showLogoutAlert() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return ModalProgressHUD(
                inAsyncCall: _isLoading,
                dismissible: false,
                opacity: 0.5,
                progressIndicator: CustomProgressIndicator(),
                child: AlertDialog(
                  title: const Text('Déconnexion', textAlign: TextAlign.center),
                  elevation: 2.0,
                  content: Container(
                    constraints: BoxConstraints(maxHeight: 150.0),
                    height: 150.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.report, size: 80.0, color: Colors.red),
                          Text('Voulez vous vraiment vous déconnecter ?',
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () => _logout(),
                      child: const Text('Oui'),
                    ),
                    OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Non'),
                        style: OutlinedButton.styleFrom(primary: Colors.red))
                  ],
                ),
              );
            },
          );
        });
  }

  void _logout() async {
    setState(() {
      _isLoading = true;
    });
    await AuthService.logout();
    setState(() {
      _isLoading = false;
    });
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
