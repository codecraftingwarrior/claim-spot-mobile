import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AccidentDetailForm extends StatefulWidget {
  final BuildContext context;
  final List<Vehicule> vehicules;
  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback keyPressed;

  const AccidentDetailForm({Key? key, required this.context, required this.vehicules, required this.formKey, required this.keyPressed}) : super(key: key);

  @override
  _AccidentDetailFormState createState() => _AccidentDetailFormState();
}

class _AccidentDetailFormState extends State<AccidentDetailForm> {

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
                  FormBuilderDateTimePicker(
                      name: 'date',
                      onChanged: (value) => widget.keyPressed(),
                      inputType: InputType.date,
                      decoration: standardInputDecoration(
                          labelText: 'Date', icon: Icons.calendar_today),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                      helpText: 'Selectionner la date de l\'accident',
                      cancelText: 'Annuler',
                      confirmText: 'Choisir',
                      locale: const Locale('fr', 'FR'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(widget.context,
                            errorText: 'Ce champs est obligatoire')
                      ]),
                      transitionBuilder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: MainColors.primary,
                            accentColor: MainColors.primary,
                            colorScheme:
                                ColorScheme.light(primary: MainColors.primary),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                      selectableDayPredicate: _decideWhichDayToEnable
                      // initialValue: DateTime.now(),
                      // enabled: true,
                      ),
                  verticalSpace(),
                  FormBuilderDateTimePicker(
                    name: 'heure',
                    onChanged: (value) => widget.keyPressed(),
                    inputType: InputType.time,
                    timePickerInitialEntryMode: TimePickerEntryMode.dial,
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    decoration: standardInputDecoration(
                        labelText: 'Heure', icon: Icons.timer),
                    helpText: 'Selectionner l\'heure de l\'accident',
                    cancelText: 'Annuler',
                    confirmText: 'Choisir',
                    locale: const Locale('fr', 'FR'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(widget.context,
                          errorText: 'Ce champs est obligatoire')
                    ]),
                    transitionBuilder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: MainColors.primary,
                          accentColor: MainColors.primary,
                          colorScheme:
                              ColorScheme.light(primary: MainColors.primary),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child!,
                      );
                    },
                    // initialValue: DateTime.now(),
                    // enabled: true,
                  ),
                  verticalSpace(),
                  FormBuilderTextField(
                    name: 'lieu',
                    onChanged: (value) => widget.keyPressed(),
                    decoration: standardInputDecoration(
                        labelText: 'Lieu', icon: Icons.pin_drop),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(widget.context,
                          errorText: 'Ce champs est obligatoire'),
                    ]),
                    autofocus: false,
                    keyboardType: TextInputType.text,
                  ),
                  verticalSpace(),
                  FormBuilderDropdown(
                    name: 'vehicule',
                    onChanged: (value) => widget.keyPressed(),
                    decoration: standardInputDecoration(
                        labelText: 'Vehicule', icon: FontAwesomeIcons.car),
                    allowClear: true,
                    hint: Text('Selectionner le véhicule'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Ce champs est obligatoire')
                    ]),
                    items: [
                      for (Vehicule v in widget.vehicules)
                        DropdownMenuItem(child: Text('${v.marque} ${v.modele}'), value: v)
                    ],
                  ),
                  verticalSpace(),
                  FormBuilderTextField(
                    name: 'details',
                    maxLines: 5,
                    onChanged: (value) => widget.keyPressed(),
                    decoration: standardInputDecoration(
                        helperText: "Saisir les détails concernant l\'accident",
                        labelText: 'Détails',
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

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isBefore(DateTime.now())) {
      return true;
    }
    return false;
  }
}
