import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/widgets/navbar.dart';
import 'package:intl/intl.dart';

import '../accident.dart';

class AccidentDetail extends StatefulWidget {
  final Widget? floatingActionButton;

  const AccidentDetail({Key? key, this.floatingActionButton}) : super(key: key);

  @override
  _AccidentDetailState createState() => _AccidentDetailState();
}

class _AccidentDetailState extends State<AccidentDetail> {
  @override
  Widget build(BuildContext context) {
    Accident accident = ModalRoute.of(context)!.settings.arguments as Accident;
    return Scaffold(
        appBar: Navbar(title: accident.code!),
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          bottom: true,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: 30.0, top: 10.0, left: 8.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Chip(
                      label: Text('Etat : ${ accident.etat?.libelle}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: MainColors.primary.withOpacity(0.5)),
                  buildSubtitle('Date et Lieu'),
                  buildCardItem(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(DateFormat('dd/MM/yyyy').format(accident.date!)),
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Heure',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(accident.heure!),
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lieu',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(accident.lieu!),
                        ],
                      ),
                    ],
                  )),
                  SizedBox(height: 30),
                  buildSubtitle('Vehicule'),
                  buildCardItem(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Marque',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(accident.vehicule!.marque ?? ''),
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Modèle',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(accident.vehicule!.modele ?? ''),
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Immatriculation',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(accident.vehicule!.immatriculation ?? ''),
                        ],
                      ),
                    ],
                  )),
                  SizedBox(height: 30),
                  buildSubtitle('Adversaire'),
                  buildCardItem(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Prénom',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (accident.detailAdversaire!.prenom != null)
                            Text(accident.detailAdversaire!.prenom!),
                          if (accident.detailAdversaire!.prenom == null)
                            buildUnknownChip()
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nom',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (accident.detailAdversaire!.nom != null)
                            Text(accident.detailAdversaire!.nom!),
                          if (accident.detailAdversaire!.nom == null)
                            buildUnknownChip()
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Genre',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(accident.detailAdversaire!.genre ?? ''),
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Véhicule',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              '${accident.detailAdversaire!.marqueVehicule} ${accident.detailAdversaire!.modeleVehicule}'),
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Immatriculation ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (accident.detailAdversaire!.immatriculation != null)
                            Text(
                                '${accident.detailAdversaire!.immatriculation}'),
                          if (accident.detailAdversaire!.immatriculation == null)
                            buildUnknownChip()
                        ],
                      ),
                    ],
                  )),
                  SizedBox(height: 30),
                  buildSubtitle('Montants'),
                  buildCardItem(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Montant Réparation',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (accident.montantReparation != 0.0)
                            Container(
                                width: 80.0,
                                child: Text(
                                    '${NumberFormat.currency(locale: "en_US", symbol: '').format(accident.montantReparation)} F CFA',
                                    overflow: TextOverflow.clip)),
                          if (accident.montantReparation == 0.0)
                            buildUnknownChip()
                        ],
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Montant Remboursement',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (accident.montantRemboursement == 0.0)
                            buildUnknownChip(),
                          if (accident.montantRemboursement != 0.0)
                            Container(
                              width: 80.0,
                              child: Text(
                                  '${NumberFormat.currency(locale: "en_US", symbol: '').format(accident.montantRemboursement)} F CFA',
                                  overflow: TextOverflow.clip),
                            ),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ));
  }

  Chip buildUnknownChip() {
    return Chip(
        label: Text('Inconnu'),
        backgroundColor: MainColors.primary.withOpacity(0.5));
  }

  Widget buildSubtitle(String title) {
    return Container(
      height: 30,
      padding: EdgeInsets.only(left: 22.0),
      margin: EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildDivider() {
    return Divider(height: 35.0, thickness: 1.5);
  }

  Widget buildCardItem({required Widget child}) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      elevation: 12.0,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: deviceWidth / 1.1,
          child: Center(child: child),
        ),
      ),
    );
  }
}
