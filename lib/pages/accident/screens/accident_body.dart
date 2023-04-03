import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_mobile_app/pages/accident/widgets/card_grid.dart';
import 'package:insurance_mobile_app/pages/accident/widgets/stats.dart';
import 'package:insurance_mobile_app/pages/profile/widgets/page_title.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:insurance_mobile_app/shared/widgets/no_content.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../accident.dart';
import '../accident_service.dart';

class AccidentBody extends StatefulWidget {
  final String title;
  final Widget? floatingActionButton;

  const AccidentBody({Key? key, required this.title, this.floatingActionButton})
      : super(key: key);

  @override
  _AccidentBodyState createState() => _AccidentBodyState();
}

class _AccidentBodyState extends State<AccidentBody> {
  late AccidentService accidentSrv = AccidentService.of(context);
  List<Accident> accidents = [];
  bool _isLoading = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _fetchAccident();
    super.initState();
  }

  void _onRefresh() async {
    await _fetchAccident(refreshing: true);
  }

  Future<void> _fetchAccident({refreshing = false}) async {
    setState(() => _isLoading = !refreshing);
    accidentSrv.all().then((List<Accident> accidents) {
      setState(() => this.accidents = accidents);
    }).catchError((err, s) {
      Notifier.of(context).error(message: "Une erreur s'est produite");
      if (refreshing) _refreshController.refreshFailed();
      print(err);
      print(s);
    }).whenComplete(() {
      setState(() => _isLoading = false);
      if (refreshing) _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: () => print('loading'),
      enablePullUp: false,
      enablePullDown: true,
      child: accidents.isEmpty && !_isLoading
          ? NoContent(message: "Vous n'avez aucune déclaration pour le moment.")
          : buildMainLayout(context),
    );
  }

  SafeArea buildMainLayout(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: _isLoading
          ? AppProgressIndicator()
          : Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PageTitle(title: 'Dossiers'),
                    Expanded(
                        flex: 1,
                        child: Stats(context: context, accidents: accidents)),
                    Expanded(
                      flex: 6,
                      child: CardGrid(context: context, accidents: accidents),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
