import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:insurance_mobile_app/pages/annonces/annonce_service.dart';
import 'package:insurance_mobile_app/pages/annonces/forms/new_form.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule_service.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:insurance_mobile_app/shared/widgets/custom_progress_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../base_layout.dart';
import '../annonce.dart';

class AnnonceFloatingActionButton extends StatefulWidget {
  final BuildContext baseContext;

  const AnnonceFloatingActionButton({Key? key, required this.baseContext})
      : super(key: key);

  @override
  _AnnonceFloatingActionButtonState createState() =>
      _AnnonceFloatingActionButtonState();
}

class _AnnonceFloatingActionButtonState
    extends State<AnnonceFloatingActionButton> {
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late final VehiculeService vehiculeSrv = VehiculeService(context: context);
  List<String> types = ['Location', 'Vente'];
  List<Vehicule> vehicules = [];
  bool _fetching = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 2.0,
      child: _fetching ? AppProgressIndicator(size: 35.0, color: Colors.white) : Icon(Icons.add),
      onPressed: () {
        showAddDialog();
      },
      backgroundColor: MainColors.primary,
    );
  }

  Future<void> showAddDialog() async {
    setState(() => _fetching = true );
    try {
      vehicules = await vehiculeSrv.findAllWithoutAnnonce();
    } catch(err,s) {
      print(err);
      print(s);
      vehiculeSrv.errorMessage(context);
      return;
    } finally {
      setState(() => _fetching = false );
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ScaffoldMessenger(
        child: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) =>
                  ModalProgressHUD(
            inAsyncCall: _isLoading,
            dismissible: false,
            opacity: 0.5,
            progressIndicator: AppProgressIndicator(color: Colors.white),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SimpleDialog(
                title: Text("Faire une annonce"),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    height: 350.0,
                    width: 350.0,
                    child: Center(
                        child: AnnonceNewForm(
                      formKey: _formKey,
                      vehicules: vehicules,
                      types: types,
                      create: () => _create(context, setState),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _create(BuildContext dc,  void Function(void Function()) modalSetState) {
    FocusScope.of(dc).requestFocus(FocusNode());
    _formKey.currentState?.save();
    if (!_formKey.currentState!.validate()) {
      Notifier.of(dc).error(message: 'Veuillez remplir tous les champs.');
      return;
    }
    Vehicule vehicule = _formKey.currentState?.fields['vehicule']!.value;

    vehicule.applicationUser!
      ..authorities = []
      ..grantedAuthorities = [];

    Annonce annonce = Annonce.getInstance()
      ..type = _formKey.currentState?.fields['type']!.value
      ..prix = double.parse(_formKey.currentState?.fields['prix']!.value)
      ..validated = false
      ..disabled = false
      ..libelle = _formKey.currentState?.fields['vehicule']!.value.marque +
          ' ' +
          _formKey.currentState?.fields['vehicule']!.value.modele;

    vehicule.annonce = annonce;

    modalSetState(() => _isLoading = true);
    vehiculeSrv.update(vehicule).then((Vehicule vehicule) {
      Notifier.of(dc)
          .success(message: 'Votre annonce a été publiée avec succès');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => BaseLayout(targetPage: 3)),
              (route) => false);
    }).catchError((err, s) {
      print(err);
      print(s);
      vehiculeSrv.errorMessage(dc);
    }).whenComplete(() => modalSetState(() => _isLoading = false));
  }
}
