import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shared/models/etat/etat.dart';
import '../accident.dart';

class Stats extends StatefulWidget {
  final BuildContext context;
  final List<Accident> accidents;

  const Stats({Key? key, required this.context, required this.accidents})
      : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  int _index = 0;
  late Map<String, int> stats = _compute();
  List<Etat> etats = [
    Etat(code: 'AV', libelle: 'En attente de validation'),
    Etat(code: 'AP', libelle: 'En attente de photo'),
    Etat(code: 'AEX', libelle: 'En attente d\'expertise'),
    Etat(code: 'CL', libelle: 'Clôturé'),
  ];

  @override
  void initState() {
    super.initState();
  }

  Map<String, int> _compute() {
    Map<String, int> stats = {};
    int avs = 0;
    int aps = 0;
    int aexs = 0;
    int cls = 0;

    for (Accident accident in widget.accidents) {
      if (accident.etat!.code == 'AV') avs++;
      if (accident.etat!.code == 'AP') aps++;
      if (accident.etat!.code == 'AEX') aexs++;
      if (accident.etat!.code == 'CL') cls++;
    }
    stats = {'AV': avs, 'AP': aps, 'AEX': aexs, 'CL': cls};
    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: 4,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (BuildContext context, int i) {
          return Transform.scale(
            scale: i == _index ? 1 : 0.9,
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 12.0, right: 12.0, bottom: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Icon(FontAwesomeIcons.radiation),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${etats[i].libelle}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(stats[etats[i].code].toString(), style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
