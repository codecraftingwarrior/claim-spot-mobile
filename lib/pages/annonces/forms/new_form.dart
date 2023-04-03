import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';

class AnnonceNewForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<Vehicule> vehicules;
  final List<String> types;
  final void Function() create;

  const AnnonceNewForm({Key? key,
    required this.formKey,
    required this.vehicules,
    required this.create,
    required this.types})
      : super(key: key);

  @override
  _AnnonceNewFormState createState() => _AnnonceNewFormState();
}

class _AnnonceNewFormState extends State<AnnonceNewForm> {

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FormBuilderDropdown(
              name: 'vehicule',
              decoration: standardInputDecoration(
                  helperText: 'Séléctionner le véhicule',
                  labelText: 'Vehicule', icon: FontAwesomeIcons.car),
              allowClear: true,
              hint: Text('Véhicule'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Ce champs est obligatoire')
              ]),
              items: [
                for (Vehicule v in widget.vehicules)
                  DropdownMenuItem(
                      child: Text('${v.marque} ${v.modele}'), value: v)
              ],
            ),
            FormBuilderDropdown(
              name: 'type',
              decoration: standardInputDecoration(
                  helperText: 'Selectionner le type d\'annonce',
                  labelText: 'Type', icon: FontAwesomeIcons.handshake),
              allowClear: true,
              hint: Text('Type d\'annonce'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Ce champs est obligatoire')
              ]),
              items: [
                for (String type in widget.types)
                  DropdownMenuItem(
                      child: Text(type), value: type)
              ],
            ),
            FormBuilderTextField(
              name: 'prix',
              decoration: standardInputDecoration(
                  labelText: 'Prix', icon: FontAwesomeIcons.moneyBillAlt),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              autofocus: false,
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Annuler'),
                  style: TextButton.styleFrom(primary: Colors.red[800],
                      textStyle: TextStyle(fontSize: 15.0)),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    widget.create();
                  },
                  icon: Icon(Icons.check_circle),
                  label: const Text('Valider'),
                  style: ElevatedButton.styleFrom(primary: MainColors.primary),
                ),
              ],
            )
          ],
        ));
  }
}
