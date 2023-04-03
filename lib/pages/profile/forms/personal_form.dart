import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/shared/common/preferences.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';

class PersonalForm extends StatefulWidget {
  final BuildContext context;
  final ApplicationUser currentUser;
  final VoidCallback update;
  final GlobalKey<FormBuilderState> formKey;

  const PersonalForm(
      {Key? key,
      required this.context,
      required this.currentUser,
      required this.update,
      required this.formKey})
      : super(key: key);

  @override
  _PersonalFormState createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FormBuilderTextField(
              name: 'prenom',
              textInputAction: TextInputAction.next,
              initialValue: widget.currentUser.prenom,
              onChanged: _checkValid,
              decoration: standardInputDecoration(
                  labelText: 'Prenom', icon: Icons.person),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'nom',
              textInputAction: TextInputAction.next,
              initialValue: widget.currentUser.nom,
              onChanged: _checkValid,
              decoration:
                  standardInputDecoration(labelText: 'Nom', icon: Icons.person),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'telephone',
              textInputAction: TextInputAction.next,
              onChanged: _checkValid,
              initialValue: widget.currentUser.telephone,
              decoration: standardInputDecoration(
                  labelText: 'Téléphone', icon: Icons.call),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.number,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'fonction',
              textInputAction: TextInputAction.next,
              onChanged: _checkValid,
              initialValue: widget.currentUser.fonction,
              decoration: standardInputDecoration(
                  labelText: 'Fonction', icon: FontAwesomeIcons.briefcase),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'adresse',
              textInputAction: TextInputAction.next,
              onChanged: _checkValid,
              initialValue: widget.currentUser.adresse,
              decoration: standardInputDecoration(
                  labelText: 'Adresse', icon: FontAwesomeIcons.mapMarkedAlt),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                    onPressed: widget.update,
                    icon: Icon(FontAwesomeIcons.userEdit, size: 20.0),
                    style: ElevatedButton.styleFrom(
                      primary: MainColors.primary,
                      elevation: 5.0
                    ),
                    label: const Text('Modifier')),
              ],
            )
          ]),
    );
  }

  void _checkValid(String? value) => setState((){});
}
