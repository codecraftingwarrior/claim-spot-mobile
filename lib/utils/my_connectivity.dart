import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping/dart_ping.dart';

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    final ping = Ping('google.com', count: 1);

    ping.stream
        .listen((event) {
          isOnline = !(event.error != null && ErrorType.values.indexOf(event.error!.error) != (-1));
        })
        .asFuture()
        .whenComplete(() {
          controller.sink.add({result: isOnline});
        })
        .catchError((err, s) {
          print(err);
          print(s);
          controller.sink.add({result: false});
        });
  }

  void disposeStream() => controller.close();
}
