import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule_service.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:insurance_mobile_app/shared/widgets/no_content.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VehiculeBody extends StatefulWidget {
  final String title;
  final Widget? floatingActionButton;

  const VehiculeBody({Key? key, required this.title, this.floatingActionButton})
      : super(key: key);

  @override
  _VehiculeBodyState createState() => _VehiculeBodyState();
}

class _VehiculeBodyState extends State<VehiculeBody> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late VehiculeService vehiculeSrv = VehiculeService(context: context);
  bool _isLoading = false;
  List<Vehicule> vehicules = [];
  bool modalLoading = false;


  @override
  void initState() {
    _fetchVehicules();
    super.initState();
  }

  Future<void> _fetchVehicules({bool refreshing = false}) async {
    setState(() => _isLoading = !refreshing);
    vehiculeSrv.all().then((List<Vehicule> vehicules) {
      setState(() => this.vehicules = vehicules);
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

  void _onRefresh() {
    _fetchVehicules(refreshing: true);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullUp: false,
      enablePullDown: true,
      child: vehicules.isEmpty && !_isLoading
          ? NoContent(message: "Vous n'avez aucun véhicule pour le moment.")
          : buildMainLayout(context),
    );
  }

  Widget buildMainLayout(BuildContext context) {
    return _isLoading
        ? AppProgressIndicator()
        : SafeArea(
            bottom: true,
            child: GridView.builder(
              shrinkWrap: false,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      (MediaQuery.of(context).size.width + 200) / (700)),
              itemCount: vehicules.length,
              itemBuilder: (BuildContext context, int i) {
                return Bounce(
                  duration: Duration(milliseconds: 80),
                  onPressed: () => _showMenu(vehicules[i]),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150.0,
                          child: Stack(fit: StackFit.expand, children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.network(
                                  vehicules[i].image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (vehicules[i].annonce != null)
                              Positioned(
                                top: 0,
                                right: 10,
                                child: Opacity(
                                  opacity: 0.9,
                                  child: Chip(
                                      label: Text(vehicules[i].annonce!.type!,
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold)),
                                      padding: EdgeInsets.all(0),
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      backgroundColor: Colors.grey[300]),
                                ),
                              ),
                          ]),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${vehicules[i].marque} ${vehicules[i].modele}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Icon(
                                getIcon(vehicules[i].categorie!.icon!),
                                size: 13.0,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '${vehicules[i].categorie!.libelle}',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13.0),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Future<void> _showMenu(Vehicule vehicule) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext sheetContext,
                void Function(void Function()) sheetState) =>
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: new Icon(Icons.edit_outlined),
                      title: new Text('Modifier'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/vehicule/edit', arguments: vehicule);
                      },
                    ),
                    ListTile(
                      leading: new Icon(Icons.delete_forever),
                      title: new Text('Supprimer'),
                      onTap: () {
                        Navigator.pop(context);
                        _showDeleteAlert(vehicule);
                      },
                    ),
                  ],
                ),
          );
        });
  }

  Future<void> _showDeleteAlert(Vehicule vehicule) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext dc,
                void Function(void Function()) modalSetState) {
              return ModalProgressHUD(
                inAsyncCall: modalLoading,
                dismissible: false,
                opacity: 0.5,
                progressIndicator: AppProgressIndicator(color: Colors.white),
                child: AlertDialog(
                  title: const Text('Suppréssion', textAlign: TextAlign.center),
                  elevation: 2.0,
                  content: Container(
                    constraints: BoxConstraints(maxHeight: 150.0),
                    height: 150.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_forever,
                              size: 60.0, color: Colors.red),
                          Text(
                              'Voulez vous vraiment procéder à la suppression ?',
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () => _delete(dc, modalSetState, vehicule),
                      child: const Text('Oui'),
                    ),
                    OutlinedButton(
                        onPressed: () => Navigator.pop(dc),
                        child: const Text('Non'),
                        style: OutlinedButton.styleFrom(primary: Colors.red))
                  ],
                ),
              );
            },
          );
        });
  }

  Future<void> _delete(BuildContext dc, void Function(void Function()) modalSetState, Vehicule vehicule) async {
    modalSetState(() => modalLoading = true);
    vehiculeSrv.destroy(vehicule).then((resp) {
      Notifier.of(context)
          .success(message: 'Suppression effectué avec succès.');
      Navigator.pop(dc);
      _fetchVehicules();
    }).catchError((err, s) {
      print(err);
      print(s);
      vehiculeSrv.errorMessage(dc);
    }).whenComplete(() => modalSetState(() => modalLoading = false));
  }
}
