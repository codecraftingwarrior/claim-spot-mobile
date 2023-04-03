import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/profile/forms/password_update_form.dart';
import 'package:insurance_mobile_app/pages/profile/forms/personal_form.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/common/preferences.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';
import 'package:insurance_mobile_app/shared/services/application_user_service.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';

class UpdatePersonalInfo extends StatefulWidget {
  final ApplicationUser currentUser;
  final void Function(ApplicationUser user) whenUpdated;

  const UpdatePersonalInfo(
      {Key? key, required this.currentUser, required this.whenUpdated})
      : super(key: key);

  @override
  _UpdatePersonalInfoState createState() => _UpdatePersonalInfoState();
}

class _UpdatePersonalInfoState extends State<UpdatePersonalInfo> {
  bool _loading = false;
  final GlobalKey<FormBuilderState> _persoFormKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _passwordUpdateFormKey =
      GlobalKey<FormBuilderState>();
 late ApplicationUserService applicationUserSrv = ApplicationUserService(context: context);

  @override
  Widget build(BuildContext context) {
    return buildLayout();
  }


  @override
  void dispose() {
    _persoFormKey.currentState?.dispose();
    _passwordUpdateFormKey.currentState?.dispose();
    super.dispose();
  }

  Widget buildLayout() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      elevation: 12.0,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 4.0, bottom: 10.0, left: 13.0, right: 13.0),
        child: _loading
            ? _loader()
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                      title: Text('Mes informations',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                      leading: Icon(
                        FontAwesomeIcons.userLock,
                        size: 18.0,
                        color: Colors.black,
                      )),
                  PersonalForm(
                      context: context,
                      currentUser: widget.currentUser,
                      update: _updatePersonalInfo,
                      formKey: _persoFormKey),
                  ListTile(
                    title: Text('Modifier mon mot de passe',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold)),
                    leading: Icon(
                      FontAwesomeIcons.lock,
                      size: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  PasswordUpdateForm(
                    context: context,
                    formKey: _passwordUpdateFormKey,
                    changePassword: _showChangePasswordAlert,
                  )
                ],
              )),
      ),
    );
  }

  Widget _loader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: AppProgressIndicator(size: 100.0),
    );
  }

  _updatePersonalInfo() {
    ApplicationUser user = widget.currentUser;
    if(!_persoFormKey.currentState!.validate()) {
      Notifier.of(context).error(message: 'Veuillez remplir tous les champs');
      return;
    }
    setState(() => _loading = true);
    user
      ..prenom = _persoFormKey.currentState?.fields['prenom']?.value
      ..nom = _persoFormKey.currentState?.fields['nom']?.value
      ..telephone = _persoFormKey.currentState?.fields['telephone']?.value
      ..fonction = _persoFormKey.currentState?.fields['fonction']?.value
      ..adresse = _persoFormKey.currentState?.fields['adresse']?.value
      ..authorities = []
      ..grantedAuthorities = [];

    applicationUserSrv.update(user).then((ApplicationUser user) {
      Preferences.setString("currentUser", jsonEncode(user.toJson()));
      widget.whenUpdated(user);
      Notifier.of(context)
          .success(message: 'Vos informations ont bien été mise à jour.');
    }).catchError((err, s) {
      applicationUserSrv.errorMessage(context);
      print(err);
      print(s);
    }).whenComplete(() => setState(() => _loading = false));
  }

 void _changePassword() {
    ApplicationUser user = widget.currentUser;
    String currentPassword =
        _passwordUpdateFormKey.currentState?.fields['currentPassword']?.value;
    String newPassword =
        _passwordUpdateFormKey.currentState?.fields['newPassword']?.value;
    String newPasswordConfirm =
        _passwordUpdateFormKey.currentState?.fields['newPasswordConfirm']?.value;

    if (newPassword.length < 6) {
      Notifier.of(context).error(
          message: 'Le mot de passe  doit contenir au moins 6 caractéres.');
      return;
    }

    if (newPassword != newPasswordConfirm) {
      Notifier.of(context)
          .error(message: 'Les mot de passes saisies ne concordent pas.');
      return;
    }

    setState(() => _loading = true);
    user
      ..authorities = []
      ..grantedAuthorities = []
      ..plainPassword = currentPassword
      ..newPassword = newPassword;

    applicationUserSrv.updatePassword(user).then((value) {
      _passwordUpdateFormKey.currentState?.fields['currentPassword']?.setValue('');
      _passwordUpdateFormKey.currentState?.fields['newPassword']?.setValue('');
      _passwordUpdateFormKey.currentState?.fields['newPasswordConfirm']?.setValue('');
      Notifier.of(context).success(message: 'Votre mot de passe a été modifié.');
    }).catchError((err, s) {
      applicationUserSrv.errorMessage(context);
      print(err);
      print(s);
    }).whenComplete(() => setState(() => _loading = false));
  }

  Future<void> _showChangePasswordAlert() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                title: const Text('Modifier de mot de passe',
                    textAlign: TextAlign.center),
                elevation: 2.0,
                content: Container(
                  constraints: BoxConstraints(maxHeight: 150.0),
                  height: 150.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.report, size: 80.0, color: Colors.red),
                        Text(
                            'Voulez vous vraiment changer votre mot de passe ?',
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _changePassword();
                    },
                    child: const Text('Oui'),
                  ),
                  OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Non'),
                      style: OutlinedButton.styleFrom(primary: Colors.red))
                ],
              );
            },
          );
        });
  }
}
