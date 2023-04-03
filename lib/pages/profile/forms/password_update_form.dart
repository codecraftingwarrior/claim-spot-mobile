import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';

class PasswordUpdateForm extends StatefulWidget {
  final BuildContext context;
  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback changePassword;

  const PasswordUpdateForm(
      {Key? key,
      required this.context,
      required this.formKey,
      required this.changePassword})
      : super(key: key);

  @override
  _PasswordUpdateFormState createState() => _PasswordUpdateFormState();
}

class _PasswordUpdateFormState extends State<PasswordUpdateForm> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FormBuilderTextField(
              name: 'currentPassword',
              textInputAction: TextInputAction.next,
              onChanged: _checkValid,
              decoration: standardInputDecoration(
                  labelText: 'Mot de passe actuel', icon: Icons.lock),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              obscureText: true,
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'newPassword',
              textInputAction: TextInputAction.next,
              onChanged: _checkValid,
              decoration: standardInputDecoration(
                  labelText: 'Nouveau mot de passe', icon: Icons.lock),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
                FormBuilderValidators.minLength(widget.context, 6,
                    errorText: 'Saisir au moins 6 caractéres.')
              ]),
              obscureText: true,
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'newPasswordConfirm',
              textInputAction: TextInputAction.next,
              onChanged: _checkValid,
              decoration: standardInputDecoration(
                  labelText: 'Confirmer le mot de passe', icon: Icons.lock),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire.'),
                FormBuilderValidators.minLength(widget.context, 6,
                    errorText: 'Saisir au moins 6 caractéres.')
              ]),
              obscureText: true,
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                    onPressed: (widget.formKey.currentState != null &&
                            widget.formKey.currentState!.validate())
                        ? widget.changePassword
                        : null,
                    icon: Icon(Icons.check_circle),
                    style: ElevatedButton.styleFrom(
                        primary: MainColors.primary, elevation: 5.0),
                    label: const Text('Valider')),
              ],
            )
          ]),
    );
  }

  void _checkValid(String? value) => setState(() {});
}
