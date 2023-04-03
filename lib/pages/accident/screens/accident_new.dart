import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:insurance_mobile_app/pages/accident/accident_service.dart';
import 'package:insurance_mobile_app/pages/accident/forms/accident_detail_form.dart';
import 'package:insurance_mobile_app/pages/accident/forms/adversaire_detail_form.dart';
import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule.dart';
import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule_service.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule_service.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/common/preferences.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';
import 'package:insurance_mobile_app/shared/models/detail_adversaire/detail_adversaire.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:insurance_mobile_app/shared/widgets/navbar.dart';
import 'package:intl/intl.dart';

import '../accident.dart';

class AccidentNewPage extends StatefulWidget {
  const AccidentNewPage({Key? key}) : super(key: key);

  @override
  _AccidentNewPageState createState() => _AccidentNewPageState();
}

class _AccidentNewPageState extends State<AccidentNewPage> {
  int _currentStep = 0;
  late final VehiculeService vehiculeSrv = VehiculeService(context: context);
  late final AccidentService accidentSrv = AccidentService(context: context);
  late final CategorieVehiculeService categorieVehiculeSrv =
      CategorieVehiculeService();
  late final List<Vehicule> vehicules;
  late final List<CategorieVehicule> categorieVehicules;
  bool _isLoading = false;
  final GlobalKey<FormBuilderState> _detailFormKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _adversaireFormKey =
      GlobalKey<FormBuilderState>();
  late final ApplicationUser currentUser;

  @override
  void initState() {
    _fetchVehicules();
    _fetchCurrentUser();
    super.initState();
  }

  _fetchCurrentUser() async {
    currentUser = await Preferences.getCurrentUser();
  }

  void _fetchCategories() {
    setState(() => _isLoading = true);
    categorieVehiculeSrv
        .all()
        .then((List<CategorieVehicule> categorieVehicules) {
      this.categorieVehicules = categorieVehicules;
    }).catchError((err, s) {
      print(err);
      print(s);
      categorieVehiculeSrv.errorMessage(context);
    }).whenComplete(() => setState(() => _isLoading = false));
  }

  void _fetchVehicules() {
    setState(() => _isLoading = true);
    vehiculeSrv.all().then((List<Vehicule> vehicules) {
      this.vehicules = vehicules;
      _fetchCategories();
    }).catchError((err, s) {
      print(err);
      print(s);
      vehiculeSrv.errorMessage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: Navbar(title: 'Faire une déclaration'),
        backgroundColor: MainColors.bgColorScreen,
        // drawer: AppDrawer(currentPage: accidentResource.title),
        body: _isLoading
            ? AppProgressIndicator()
            : SingleChildScrollView(
                child: SafeArea(
                  bottom: true,
                  child: Center(
                    child: Theme(
                      data: ThemeData(
                          accentColor: MainColors.primary,
                          primarySwatch: Colors.blue,
                          colorScheme:
                              ColorScheme.light(primary: MainColors.primary)),
                      child: buildStepper(context),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Stepper buildStepper(BuildContext context) {
    return Stepper(
        type: StepperType.vertical,
        physics: ScrollPhysics(),
        currentStep: _currentStep,
        onStepTapped: (step) => _tapped(step),
        onStepContinue: _continued,
        onStepCancel: _cancel,
        controlsBuilder: (BuildContext context,
            {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              children: <Widget>[
                if (_currentStep != 1)
                  OutlinedButton(
                    onPressed: onStepContinue,
                    child: const Text('Suivant'),
                  ),
                if (_currentStep == 1)
                  OutlinedButton.icon(
                    onPressed: () {
                      _detailFormKey.currentState?.save();
                      _adversaireFormKey.currentState?.save();
                      return ((_detailFormKey.currentState?.validate() ??
                              false) &&
                          (_adversaireFormKey.currentState?.validate() ??
                              false));
                    }()
                        ? _create
                        : null,
                    icon: Icon(Icons.check_circle),
                    label: const Text('Valider'),
                  ),
                SizedBox(width: 8.0),
                OutlinedButton(
                  onPressed: onStepCancel,
                  child: const Text('Précédent'),
                  style: OutlinedButton.styleFrom(primary: Colors.red),
                ),
              ],
            ),
          );
        },
        steps: <Step>[
          Step(
            title: Text('Accident'),
            content: Column(
              children: <Widget>[
                AccidentDetailForm(
                  context: context,
                  vehicules: vehicules,
                  formKey: _detailFormKey,
                  keyPressed: () => setState(() {}),
                )
              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: new Text('Adversaire'),
            content: Column(
              children: <Widget>[
                AdversaireDetailForm(
                    context: context,
                    categorieVehicules: categorieVehicules,
                    formKey: _adversaireFormKey,
                    keyPressed: () => setState(() {}))
              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
        ]);
  }

  void _tapped(int step) {
    setState(() => _currentStep = step);
  }

  _continued() {
    _currentStep < 1 ? setState(() => _currentStep++) : null;
  }

  _cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  _create() {
    _adversaireFormKey.currentState?.save();
    _detailFormKey.currentState?.save();
    DetailAdversaire detailAdversaire = DetailAdversaire.getInstance()
      ..prenom = _adversaireFormKey.currentState?.fields['prenom']?.value
      ..nom = _adversaireFormKey.currentState?.fields['nom']?.value
      ..genre = _adversaireFormKey.currentState?.fields['genre']?.value
      ..categorieVehicule =
          _adversaireFormKey.currentState?.fields['categorie']?.value
      ..marqueVehicule =
          _adversaireFormKey.currentState?.fields['marque']?.value
      ..modeleVehicule =
          _adversaireFormKey.currentState?.fields['modele']?.value
      ..description =
          _adversaireFormKey.currentState?.fields['description']?.value
      ..immatriculation =
          _adversaireFormKey.currentState?.fields['immatriculation']?.value;

    Accident accident = Accident.getInstance()
      ..date = _detailFormKey.currentState?.fields['date']?.value
      ..heure = DateFormat('hh:mm')
          .format(_detailFormKey.currentState?.fields['heure']?.value)
      ..lieu = _detailFormKey.currentState?.fields['lieu']?.value
      ..vehicule = _detailFormKey.currentState?.fields['vehicule']?.value
      ..details = _detailFormKey.currentState?.fields['details']?.value
      ..applicationUser = {'id': currentUser.id} as dynamic
      ..detailAdversaire = detailAdversaire;

    setState(() => _isLoading = true);
    accidentSrv.store(accident).then((Accident accident) {
      Notifier.of(context).success(
          message:
              'Votre déclaration a bien été enregistré. Nous vous contacterons sous peu.');
      _detailFormKey.currentState?.dispose();
      _adversaireFormKey.currentState?.dispose();
      Navigator.pushNamedAndRemoveUntil(
          context, '/base-layout', (Route route) => false);
    }).catchError((err, s) {
      accidentSrv.errorMessage(context);
      print(err);
      print(s);
    }).whenComplete(() => setState(() => _isLoading = false));
  }
}
