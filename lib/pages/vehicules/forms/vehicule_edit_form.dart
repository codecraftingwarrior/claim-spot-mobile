import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';

import '../categorie_vehicule.dart';
import '../vehicule.dart';

class VehiculeEditForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<CategorieVehicule> categories;
  final BuildContext context;
  final Vehicule vehicule;

  const VehiculeEditForm(
      {Key? key,
      required this.formKey,
      required this.categories,
      required this.context,
      required this.vehicule})
      : super(key: key);

  @override
  _VehiculeEditFormState createState() => _VehiculeEditFormState();
}

class _VehiculeEditFormState extends State<VehiculeEditForm> {
  List<DropdownMenuItem<CategorieVehicule>> categorieDropdownMenuItems = [];

  @override
  void initState() {
    _buildCategorieDropdown();
    super.initState();
  }

  void _buildCategorieDropdown() {
    categorieDropdownMenuItems.add(DropdownMenuItem(
      value: widget.vehicule.categorie,
      child: Row(
        children: [
          Icon(getIcon(widget.vehicule.categorie!.icon!), color: MainColors.primary, size: 20.0),
          SizedBox(width: 8),
          Text('${widget.vehicule.categorie!.libelle}'),
        ],
      ),
    ));
    for (CategorieVehicule c in widget.categories)
      categorieDropdownMenuItems.add(
          DropdownMenuItem(
              child: Row(
                children: [
                  Icon(getIcon(c.icon!), color: MainColors.primary, size: 18.0),
                  SizedBox(width: 8),
                  Text('${c.libelle}'),
                ],
              ), value: c)
      );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: SizedBox(
        height: MediaQuery.of(widget.context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FormBuilderTextField(
              name: 'marque',
              textInputAction: TextInputAction.next,
              decoration: standardInputDecoration(
                  labelText: 'Marque', icon: FontAwesomeIcons.carAlt),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              initialValue: widget.vehicule.marque,
              keyboardType: TextInputType.text,
            ),
            FormBuilderTextField(
              name: 'modele',
              textInputAction: TextInputAction.next,
              decoration: standardInputDecoration(
                  labelText: 'Modele', icon: FontAwesomeIcons.carBattery),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              initialValue: widget.vehicule.modele,
              keyboardType: TextInputType.text,
            ),
            FormBuilderTextField(
              name: 'immatriculation',
              textInputAction: TextInputAction.next,
              decoration: standardInputDecoration(
                  labelText: 'Immatriculation',
                  icon: FontAwesomeIcons.fileContract),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              initialValue: widget.vehicule.immatriculation,
              keyboardType: TextInputType.text,
            ),
            FormBuilderDropdown(
              name: 'categorie',
              decoration: standardInputDecoration(
                  helperText: 'Chosissez la catégorie du véhicule',
                  labelText: 'Catégorie',
                  hasIcon: false),
              allowClear: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Ce champs est obligatoire')
              ]),
              initialValue: widget.vehicule.categorie,
              items: categorieDropdownMenuItems
            ),
          ],
        ),
      ),
    );
  }
}
