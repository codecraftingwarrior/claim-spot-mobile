import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/accident/accident_service.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/constant/drawer_resources.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:intl/intl.dart';

import '../accident.dart';

class CardGrid extends StatefulWidget {
  final BuildContext context;
  final List<Accident> accidents;

  const CardGrid({Key? key, required this.context, required this.accidents}) : super(key: key);

  @override
  _CardGridState createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {

  @override
  Widget build(BuildContext context) {
    return buildGridView();
  }

  GridView buildGridView() {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: widget.accidents.length,
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Bounce(
            duration: Duration(milliseconds: 80),
            onPressed: () {
              Navigator.pushNamed(
                  context, '${accidentResource.routeName}/detail',
                  arguments: widget.accidents[i]);
            },
            child: Container(
              child: Card(
                elevation: 8.5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesomeIcons.folderOpen,
                        color: MainColors.primary,
                        size: 50.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: MainColors.primary),
                        constraints:
                            BoxConstraints(minHeight: 16.0, minWidth: 16.0),
                        child: Text(
                          widget.accidents[i].code!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(widget.accidents[i].createdAt!),
                              style: TextStyle(
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                  color: MainColors.primary),
                            ),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              size: 12.0,
                              color: MainColors.primary,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
                ),
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 25.0, // soften the shadow
                  spreadRadius: -13, //extend the shadow
                  offset: Offset(
                    -5.0, // Move to right 10  horizontally
                    7, // Move to bottom 10 Vertically
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
