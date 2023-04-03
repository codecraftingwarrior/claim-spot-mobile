import 'package:flutter/material.dart';
import 'package:insurance_mobile_app/pages/auth/credentials.dart';
import 'package:insurance_mobile_app/utils/constant.dart' as Constant;

class LoginForm extends StatefulWidget {
  final void Function(Credentials credentials) onSubmittedForm;

  LoginForm({required this.onSubmittedForm});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  bool isObscureText = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Text(
            'CONNECTEZ - VOUS',
            style: TextStyle(
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Constant.primary),
          ),
          TextFormField(
            controller: usernameController,
            onChanged: (value) {
              _checkValid();
            },
            decoration: InputDecoration(
                labelText: 'nom d\'utilisateur',
                labelStyle: TextStyle(color: Constant.primary),
                helperText: 'Exemple: example@gmail.com',
                prefixIcon:
                    Icon(Icons.alternate_email, color: Constant.primary),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(color: Constant.primary, width: 2.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "champ obligatoire";
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            obscureText: isObscureText,
            onChanged: (value) {
              _checkValid();
            },
            decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: Constant.primary),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Constant.primary,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() => isObscureText = !isObscureText);
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility : Icons.visibility_off,
                    color: Constant.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(color: Constant.primary, width: 2.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "champ obligatoire";
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: !filled()
                      ? null
                      : () => widget.onSubmittedForm(Credentials(
                          username: usernameController.value.text,
                          password: passwordController.value.text)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.login),
                          SizedBox(width: 10.0),
                          const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 2.0,
                            ),
                          )
                        ]),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Constant.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _checkValid() {
    setState(() {});
  }

  bool filled() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}
