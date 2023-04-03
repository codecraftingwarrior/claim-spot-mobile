import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:insurance_mobile_app/pages/auth/auth_service.dart';
import 'package:insurance_mobile_app/pages/auth/credentials.dart';
import 'package:insurance_mobile_app/pages/auth/forms/login_form.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/common/preferences.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';
import 'package:insurance_mobile_app/shared/widgets/custom_progress_indicator.dart';
import 'package:insurance_mobile_app/utils/constant.dart' as Constant;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  bool isOffline = false;


  @override
  void initState() {
   super.initState();
  }

  Future<void> login(Credentials credentials) async {
    if (credentials.username.isEmpty || credentials.password.isEmpty) {
      Notifier.of(context)
          .error(message: 'Veuillez renseigner tous les champs.');
      return;
    }
    setState(() => _isLoading = true);
    AuthService.login(credentials).then((response) async {
      dynamic parsedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Preferences.setString('token',parsedResponse['token']);
        try {
          setState(() => _isLoading = true);
          Response userResp = await AuthService.getCurrentUser();
          setState(() => _isLoading = false);
          dynamic parsedResp = jsonDecode(userResp.body);
          ApplicationUser user = ApplicationUser.fromJson(parsedResp);
          Preferences.setString("currentUser", jsonEncode(user.toJson()));
          Navigator.pushNamedAndRemoveUntil(
              context, '/base-layout', (Route route) => false);
        } catch(e, s) {
          print(e);
          print(s);
        }
      } else {
        print('Error $parsedResponse');
        Notifier.of(context).error(message: parsedResponse['message']);
      }
    }).catchError((err) {
      Notifier.of(context).error(message: 'Une erreur s\'est produite.');
      print('Error $err');
    }).whenComplete(() => setState(() => _isLoading = false));
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        dismissible: false,
        opacity: 0.5,
        progressIndicator: CustomProgressIndicator(),
        child: Scaffold(
          backgroundColor: Constant.loginPrimay,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Center(
                          child: SvgPicture.asset(
                              '${Constant.imagePath}/login.svg'),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFF3F3F5),
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 8,
                                blurRadius: 20,
                                offset: Offset(0, -10))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Center(child: LoginForm(onSubmittedForm: login)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
