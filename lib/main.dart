import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:insurance_mobile_app/pages/accident/screens/accident_detail.dart';
import 'package:insurance_mobile_app/pages/accident/screens/accident_new.dart';
import 'package:insurance_mobile_app/pages/annonces/widgets/annonce_floating_action_button.dart';
import 'package:insurance_mobile_app/pages/base_layout.dart';
import 'package:insurance_mobile_app/pages/annonces/screens/annonce_body.dart';
import 'package:insurance_mobile_app/pages/auth/screens/login.dart';
import 'package:insurance_mobile_app/pages/vehicules/screens/vehicule_body.dart';
import 'package:insurance_mobile_app/pages/vehicules/screens/vehicule_edit.dart';
import 'package:insurance_mobile_app/pages/vehicules/screens/vehicule_new.dart';
import 'package:insurance_mobile_app/pages/vehicules/widgets/vehicule_floating_action_button.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/constant/drawer_resources.dart';
import 'package:insurance_mobile_app/shared/services/notification_service.dart';
import 'package:insurance_mobile_app/utils/my_connectivity.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';


Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
        bool status = _source.values.toList()[0];
        if (status) {
          Notifier.of(context).success(
              message: 'Votre connexion a été restaurée.',
              messengerKey: _messangerKey);
        } else {
          Notifier.of(context).warning(
              message: 'Vous êtes déconnecté.', messengerKey: _messangerKey);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: [const Locale('en'), const Locale('fr')],
      scaffoldMessengerKey: _messangerKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      locale: const Locale('fr'),
      initialRoute: '/base-layout',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => Login(),
        '/base-layout': (BuildContext context) => BaseLayout(),
        '${accidentResource.routeName}/new': (BuildContext context) =>
            AccidentNewPage(),
        '${accidentResource.routeName}/detail': (BuildContext context) =>
            AccidentDetail(),
        vehiculeResource.routeName: (BuildContext context) => VehiculeBody(
            title: vehiculeResource.title,
            floatingActionButton: VehiculeFloatingActionButton()),
        '${vehiculeResource.routeName}/new': (BuildContext context) =>
            VehiculeNew(),
        '${vehiculeResource.routeName}/edit': (BuildContext context) =>
            VehiculeEdit(),
        // annonceResource.routeName: (BuildContext context) => AnnonceBody(
        //     title: annonceResource.title,
        //     floatingActionButton: AnnonceFloatingActionButton())
      },
    );
  }
}
