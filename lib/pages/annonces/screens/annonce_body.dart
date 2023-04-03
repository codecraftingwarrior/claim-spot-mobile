import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insurance_mobile_app/pages/annonces/annonce_service.dart';
import 'package:insurance_mobile_app/pages/annonces/forms/edit_form.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule_service.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:insurance_mobile_app/shared/widgets/custom_progress_indicator.dart';
import 'package:insurance_mobile_app/shared/widgets/no_content.dart';
import 'package:insurance_mobile_app/utils/timeago_mixin.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../annonce.dart';

class AnnonceBody extends StatefulWidget {
  final String title;
  final Widget? floatingActionButton;

  const AnnonceBody({Key? key, required this.title, this.floatingActionButton})
      : super(key: key);

  @override
  _AnnonceBodyState createState() => _AnnonceBodyState();
}

class _AnnonceBodyState extends State<AnnonceBody> with TimeAgoMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  AnnonceService annonceSrv = AnnonceService();
  late VehiculeService vehiculeSrv = VehiculeService(context: context);
  bool loading = false;
  bool modalLoading = false;
  bool sheetLoader = false;
  String currentAction = '';
  List<Annonce> annonces = [];
  GlobalKey<FormBuilderState> _editKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _fetchAnnonces();
    super.initState();
  }

  Future<void> _fetchAnnonces({bool refreshing = false}) async {
    setState(() => loading = !refreshing);
    annonceSrv.findByCurrentUser().then((List<Annonce> annonces) {
      setState(() {
        this.annonces = annonces;
      });
    }).catchError((err, s) {
      if (refreshing) _refreshController.refreshFailed();
      print(err);
      print(s);
      annonceSrv.errorMessage(context);
    }).whenComplete(() {
      setState(() => loading = false);
      _refreshController.refreshCompleted();
    });
  }

  void _onRefresh() async {
    await _fetchAnnonces(refreshing: true);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? AppProgressIndicator()
        : SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullUp: false,
            enablePullDown: true,
            child: annonces.isEmpty
                ? NoContent(
                    message: "Vous n'avez aucune annonce pour le moment")
                : buildListView(),
          );
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: annonces.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            onLongPress: () => _showMenu(annonces[i]),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ]),
              margin: EdgeInsets.only(
                  top: 10.0, bottom: 15.0, left: 12.0, right: 12.0),
              padding:
                  EdgeInsets.only(right: 0, left: 7.0, top: 5.0, bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 5.0,
                        semanticContainer: false,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        child: SizedBox(
                          width: 75,
                          height: 75,
                          child: Image.network(
                            annonces[i].vehicule!.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${annonces[i].vehicule!.marque} ${annonces[i].vehicule!.modele}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Icon(
                                getIcon(annonces[i].vehicule!.categorie!.icon!),
                                size: 13.0,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '${annonces[i].vehicule!.categorie!.libelle}',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13.0),
                              )
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Text(
                              getTimeago(
                                  annonces[i].createdAt ?? DateTime.now()),
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 10.0),
                              overflow: TextOverflow.clip)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 13.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Chip(
                          label: Text(
                            'En ${annonces[i].type!}',
                            style: TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.all(0),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor: MainColors.primary.withOpacity(0.5)),
                      SizedBox(width: 8.0),
                      Chip(
                          label: Text(
                              '${NumberFormat.currency(locale: "en_US", symbol: '').format(annonces[i].prix)} F CFA' +
                                  (annonces[i].type!.toLowerCase() == 'location'
                                      ? ' / Jour'
                                      : ''),
                              style: TextStyle(
                                  fontSize: 10.0, fontWeight: FontWeight.bold)),
                          padding: EdgeInsets.all(0),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor: Colors.grey[300]),
                      // Container(
                      //     width: 70.0,
                      //     margin: EdgeInsets.only(left: 5.0),
                      //     child: Text(
                      //         getTimeago(
                      //             annonces[i].createdAt ?? DateTime.now()),
                      //         textAlign: TextAlign.end,
                      //         style: TextStyle(fontSize: 10.0),
                      //         overflow: TextOverflow.clip))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showMenu(Annonce annonce) async {
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
                  trailing: sheetLoader && currentAction == 'editing'
                      ? SizedBox(
                          width: 25.0,
                          child: SpinKitSpinningLines(
                            color: Colors.grey,
                            size: 25.0,
                            duration: Duration(milliseconds: 2000),
                          ),
                        )
                      : null,
                  onTap: () {
                    _showEditModal(annonce, sheetContext, sheetState);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.delete_forever),
                  title: new Text('Supprimer'),
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteAlert(annonce);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _showEditModal(Annonce annonce, BuildContext sheetContext,
      void Function(void Function()) sheetState) async {
    List<Vehicule> vehicules = [];
    List<String> types = ['Location', 'Vente'];
    sheetState(() {
      sheetLoader = true;
      currentAction = 'editing';
    });
    try {
      vehicules = await vehiculeSrv.findAllWithoutAnnonce();
    } catch (e, s) {
      print(e);
      print(s);
      vehiculeSrv.errorMessage(context);
    } finally {
      sheetState(() => sheetLoader = false);
      Navigator.pop(context);
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ScaffoldMessenger(
        child: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) =>
                  ModalProgressHUD(
            inAsyncCall: modalLoading,
            dismissible: false,
            opacity: 0.5,
            progressIndicator: AppProgressIndicator(color: Colors.white),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SimpleDialog(
                title: Text("Modifier"),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    height: 350.0,
                    width: 350.0,
                    child: Center(
                        child: AnnonceEditForm(
                      formKey: _editKey,
                      annonce: annonce,
                      vehicules: vehicules,
                      types: types,
                      edit: () => _update(context, setState, annonce),
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

  Future<void> _delete(BuildContext dc,
      void Function(void Function()) modalSetState, Annonce annonce) async {
    modalSetState(() => modalLoading = true);
    annonceSrv.destroy(annonce).then((resp) {
      Notifier.of(context)
          .success(message: 'Suppression effectué avec succès.');
      Navigator.pop(dc);
      _fetchAnnonces();
    }).catchError((err, s) {
      print(err);
      print(s);
      vehiculeSrv.errorMessage(dc);
    }).whenComplete(() => modalSetState(() => modalLoading = false));
  }

  void _update(BuildContext dc, void Function(void Function()) modalSetState,
      Annonce annonce) async {
    FocusScope.of(dc).requestFocus(FocusNode());
    _editKey.currentState?.save();
    if (!_editKey.currentState!.validate()) {
      Notifier.of(dc).error(message: 'Veuillez remplir tous les champs.');
      return;
    }
    Vehicule vehicule = _editKey.currentState?.fields['vehicule']!.value;

    vehicule.applicationUser!
      ..authorities = []
      ..grantedAuthorities = [];

    annonce
      ..type = _editKey.currentState?.fields['type']!.value
      ..prix = double.parse(_editKey.currentState?.fields['prix']!.value)
      ..validated = false
      ..disabled = false
      ..libelle = _editKey.currentState?.fields['vehicule']!.value.marque +
          ' ' +
          _editKey.currentState?.fields['vehicule']!.value.modele;

    Annonce editedAnnonce = Annonce.fromJson(jsonDecode(jsonEncode(annonce)));
    editedAnnonce.vehicule = null;
    vehicule.annonce = editedAnnonce;
    modalSetState(() => modalLoading = true);
    vehiculeSrv.update(vehicule).then((Vehicule vehicule) {
      Notifier.of(context).success(message: 'Mise à jour réussi.');
      _fetchAnnonces();
      Navigator.pop(dc);
    }).catchError((err, s) {
      print(err);
      print(s);
      vehiculeSrv.errorMessage(dc);
    }).whenComplete(() => modalSetState(() => modalLoading = false));
  }

  Future<void> _showDeleteAlert(Annonce annonce) {
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
                      onPressed: () => _delete(dc, modalSetState, annonce),
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
}
