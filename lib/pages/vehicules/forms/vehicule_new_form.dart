import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';

class VehiculeNewForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<CategorieVehicule> categories;
  final BuildContext context;
  const VehiculeNewForm({Key? key, required this.formKey, required this.categories, required this.context}) : super(key: key);

  @override
  _VehiculeNewFormState createState() => _VehiculeNewFormState();
}

class _VehiculeNewFormState extends State<VehiculeNewForm> {
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
              keyboardType: TextInputType.text,
            ),
            FormBuilderTextField(
              name: 'modele',
              textInputAction: TextInputAction.next,
              decoration: standardInputDecoration(
                  labelText: 'Modele', icon:  FontAwesomeIcons.carBattery),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
            FormBuilderTextField(
              name: 'immatriculation',
              textInputAction: TextInputAction.next,
              decoration: standardInputDecoration(
                  labelText: 'Immatriculation', icon: FontAwesomeIcons.fileContract),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(widget.context,
                    errorText: 'Ce champs est obligatoire'),
              ]),
              keyboardType: TextInputType.text,
            ),
            FormBuilderDropdown(
              name: 'categorie',
              decoration: standardInputDecoration( helperText: 'Chosissez la catégorie du véhicule',
                  labelText: 'Catégorie', icon: FontAwesomeIcons.car),
              allowClear: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Ce champs est obligatoire')
              ]),
              items: [
                for (CategorieVehicule c in widget.categories)
                  DropdownMenuItem(child: Text('${c.libelle}'), value: c)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
