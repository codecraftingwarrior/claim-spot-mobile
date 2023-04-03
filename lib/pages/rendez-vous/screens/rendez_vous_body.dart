import 'package:flutter/material.dart';
import 'package:insurance_mobile_app/pages/rendez-vous/rendez_vous.dart';
import 'package:insurance_mobile_app/pages/rendez-vous/rendez_vous_service.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/models/creneau/creneau.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../meeting.dart';
import '../meeting_data_source.dart';

class RendezVousBody extends StatefulWidget {
  final String title;
  final Widget? floatingActionButton;

  const RendezVousBody(
      {Key? key, required this.title, required this.floatingActionButton})
      : super(key: key);

  @override
  _RendezVousBodyState createState() => _RendezVousBodyState();
}

class _RendezVousBodyState extends State<RendezVousBody> {
  bool loading = false;
  List<RendezVous> rendezVous = [];
  List<Creneau?> creneaux = [];
  RendezVousService rendezVousSrv = RendezVousService();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await _fetchRendezVous(refreshing: true);
  }

  @override
  void initState() {
    _fetchRendezVous();
    super.initState();
  }

  Future<void> _fetchRendezVous({bool refreshing = false}) async {
    setState(() => loading = !refreshing);
    rendezVousSrv.findByCurrentUser().then((List<RendezVous> rendezVous) {
      this.rendezVous = rendezVous;
      this.creneaux = rendezVous.map((RendezVous rv) => rv.creneau).toList();
    }).catchError((err, s) {
      print(err);
      print(s);
      rendezVousSrv.errorMessage(context);
      if (refreshing) _refreshController.refreshFailed();
    }).whenComplete(() {
      setState(() => loading = false);
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullUp: false,
      enablePullDown: true,
      header: MaterialClassicHeader(),
      child: SafeArea(
        child: Center(
          child: loading
              ? AppProgressIndicator()
              : Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: EdgeInsets.only(
                      top: 12.0, bottom: 20.0, left: 12.0, right: 12.0),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 1.0),
                    child: SfCalendar(
                      view: CalendarView.month,
                      dataSource: MeetingDataSource(_getDataSource()),
                      todayHighlightColor: MainColors.primary,
                      monthViewSettings: const MonthViewSettings(
                          showAgenda: true,
                          agendaItemHeight: 70,
                          appointmentDisplayCount: 2,
                          monthCellStyle: MonthCellStyle(
                            trailingDatesBackgroundColor: Color(0xFFF5F5F5),
                            leadingDatesBackgroundColor: Color(0xFFF5F5F5),
                          ),
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.appointment),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    List<Meeting> meetings = <Meeting>[];
    for (RendezVous? rendezVous in rendezVous) {
      final DateTime startTime = DateTime(
          rendezVous!.creneau!.date!.year,
          rendezVous.creneau!.date!.month,
          rendezVous.creneau!.date!.day,
          (int.parse(rendezVous.creneau!.heure!.split(':')[0])),
          (int.parse(rendezVous.creneau!.heure!.split(':')[1])));
      final DateTime endTime = startTime.add(const Duration(hours: 3));
      meetings.add(Meeting(
          'Expertise ( Identifiant du dossier : ${rendezVous.accident!.code} )',
          startTime,
          endTime,
          MainColors.primary,
          false));
    }
    return meetings;
  }
}
