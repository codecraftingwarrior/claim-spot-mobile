import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';

class AdversaireDetailForm extends StatefulWidget {
  final BuildContext context;
  final List<CategorieVehicule> categorieVehicules;
  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback keyPressed;

  const AdversaireDetailForm(
      {Key? key,
      required this.context,
      required this.categorieVehicules,
      required this.formKey,
      required this.keyPressed})
      : super(key: key);

  @override
  _AdversaireDetailFormState createState() => _AdversaireDetailFormState();
}

class _AdversaireDetailFormState extends State<AdversaireDetailForm> {
  var genders = [
    {'name': 'Homme', 'icon': Icons.male},
    {'name': 'Femme', 'icon': Icons.female}
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: FormBuilder(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FormBuilderTextField(
              name: 'prenom',
              onChanged: (value) => widget.keyPressed(),
              decoration: standardInputDecoration(
                  labelText: 'prenom', icon: FontAwesomeIcons.user),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'nom',
              onChanged: (value) => widget.keyPressed(),
              decoration: standardInputDecoration(
                  labelText: 'nom', icon: FontAwesomeIcons.user),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderDropdown(
              name: 'genre',
              onChanged: (value) => widget.keyPressed(),
              decoration: standardInputDecoration(
                  labelText: 'genre', icon: Icons.people),
              allowClear: true,
              hint: Text('Selectionner le genre'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Ce champs est obligatoire')
              ]),
              items: [
                for (var gender in genders)
                  DropdownMenuItem(
                    child: Row(
                      children: [
                        Icon(gender['icon'] as IconData),
                        SizedBox(width: 5.0),
                        Text(gender['name'] as String)
                      ],
                    ),
                    value: gender['name'],
                  )
              ],
            ),
            verticalSpace(),
            FormBuilderDropdown(
              name: 'categorie',
              onChanged: (value) => widget.keyPressed(),
              decoration: standardInputDecoration(
                  labelText: 'categorie', icon: Icons.local_shipping),
              allowClear: true,
              hint: Text('Selectionner la categorie'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Ce champs est obligatoire')
              ]),
              items: [
                for (var cat in widget.categorieVehicules)
                  DropdownMenuItem(child: Text(cat.libelle!), value: cat)
              ],
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'marque',
              onChanged: (value) => widget.keyPressed(),
              decoration: standardInputDecoration(
                  labelText: 'Marque du vehicule', icon: Icons.car_rental),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'modele',
              onChanged: (value) => widget.keyPressed(),
              decoration: standardInputDecoration(
                  labelText: 'Modéle du vehicule',
                  icon: FontAwesomeIcons.carAlt),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'immatriculation',
              onChanged: (value) => widget.keyPressed(),
              decoration: standardInputDecoration(
                  labelText: 'Immatriculation du vehicule',
                  icon: FontAwesomeIcons.fileContract),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(),
            FormBuilderTextField(
              name: 'description',
              onChanged: (value) => widget.keyPressed(),
              maxLines: 5,
              decoration: standardInputDecoration(
                  helperText: "Faites une bréve description de l'incident",
                  labelText: 'Déscription',
                  icon: FontAwesomeIcons.commentDots),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
